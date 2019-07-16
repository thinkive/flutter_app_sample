import 'package:flutter/material.dart';
import 'package:flutter_app_sample/common/util/LogUtil.dart';

abstract class AppCommonStatefulPage extends StatefulWidget {
  EnterParameter enterParameter;
  ///有参数构造器
  AppCommonStatefulPage({
    @required this.enterParameter,
  });

  @override
  _AppCommonStatefulPage createState() {
    return _AppCommonStatefulPage(createConfig(), createWidget(), this.enterParameter);
  }
  ///创建页面的配置信息
  Config createConfig();

  ///创建页面的小部件
  Widget createWidget();
}

class _AppCommonStatefulPage extends State<AppCommonStatefulPage> {
  Config config;
  Widget rootWidget;
  EnterParameter enterParameter;

  _AppCommonStatefulPage(Config config, Widget rootWidget, EnterParameter enterParameter) {
    this.config = config;
    this.rootWidget = rootWidget;
    this.enterParameter = enterParameter;
  }

  Widget _getLeading() {
    if (config.showBackArrow) {
      return GestureDetector(
        onTap: () {
          _exitThisPage();
        },
        child: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      );
    } else {
      return null;
    }
  }

  _exitThisPage(){
    var context = enterParameter?.previousPageContext;
    if(context != null){
      Navigator.pop(context);
    }else{
      LogUtil.log("检测到异常；退出页面时，上下文对象为空！");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: _getLeading(),
          title: Text("${config.titleName}"),
          centerTitle: true,
        ),
        body: rootWidget,
      ),
    );
  }
}

class Config {
  const Config({
    @required this.titleName = 'title',
    this.showAppBar = true,
    this.showBackArrow = true,
  });

  final bool showAppBar;
  final String titleName;
  final bool showBackArrow;
}

class EnterParameter {
  BuildContext previousPageContext;
  EnterParameter({
    @required BuildContext previousPageContext,
  }){
    this.previousPageContext = previousPageContext;
  }
}
