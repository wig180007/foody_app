import 'package:foody_app/api/firebase_api.dart';
import 'package:foody_app/chatModel/user.dart';
import 'package:foody_app/chatWidget/chat_body_widget.dart';
import 'package:foody_app/chatWidget/chat_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:foody_app/resource/app_colors.dart';

class ChatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.PRIMARY_COLOR,
    body: SafeArea(
      child: StreamBuilder<List<User>>(
        stream: FirebaseApi.getUsers(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                print(snapshot.error);
                return buildText('Something Went Wrong Try later');
              } else {
                final users = snapshot.data;

                if (users.isEmpty) {
                  return buildText('No Users Found');
                } else
                  return Column(
                    children: [
                      ChatHeaderWidget(users: users),
                      ChatBodyWidget(users: users)
                    ],
                  );
              }
          }
        },
      ),
    ),
  );

  Widget buildText(String text) => Center(
    child: Text(
      text,
      style: TextStyle(fontSize: 24, color: Colors.white),
    ),
  );
}