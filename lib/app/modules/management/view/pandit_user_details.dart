import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:management/resources/app_exports.dart';
import 'package:switcher/switcher.dart';

import 'pandit_gallery.dart';
import 'pandit_puja_offering.dart';
import 'pandit_setting.dart';

class PanditUserDetails extends StatelessWidget{
  final String id;

  const PanditUserDetails({Key? key,required this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    return Scaffold(
      backgroundColor: context.theme.backgroundColor
      ,
      body: FutureBuilder(
       future: FirebaseFirestore.instance.doc('users_folder/folder/pandit_users/${id}').get(), 
       builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) { 
         if(snapshot.data==null){
           return Center(child: SizedBox(
             height: 50,width: 50,
             child: CircularProgressIndicator(color: !Get.isDarkMode?Colors.white:Colors.black54,),
           ),);
         }
          return  DefaultTabController(length: 5, child: Scaffold(
              backgroundColor: context.theme.backgroundColor,
              appBar: AppBar(
                backgroundColor:Colors.transparent,
                elevation: 0.0,
                automaticallyImplyLeading: false,
                flexibleSpace: Container(                 
                ),
                actions: [
                  TabBar(
                    labelStyle: GoogleFonts.aBeeZee(color:Colors.white),
                    labelColor: !Get.isDarkMode?Colors.white:Colors.black54,
                    indicatorColor: Colors.orangeAccent,
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator:BubbleTabIndicator(
                       indicatorHeight: 25.0,
                        indicatorColor: Get.isDarkMode?Colors.white:Colors.black54,
                        tabBarIndicatorSize: TabBarIndicatorSize.tab,
                        // Other flags
                        // indicatorRadius: 1,
                        // insets: EdgeInsets.all(1),
                        // padding: EdgeInsets.all(10)
                    ),
                    tabs: const[
                      Tab(
                        text: 'Puja Offering',
                      ),
                      Tab(
                        text: 'Bank detail',
                      ),
                      Tab(
                        text: 'Gallery',
                      ),
                      Tab(
                        text: 'Bookings',
                      ),
                      Tab(
                        text: 'Actions',
                      )
                    ],
                  ),
                  CircleAvatar(
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: const[
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 8),
                                blurRadius: 8)
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage("${snapshot.data!.get('pandit_display_profile')}"))),
                    ),
                  )
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 60.0, left: 20, right: 20),
                child: Row(
                  children: [
                    Container(
                      height: height,
                      width: width / 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: height * 0.4,
                            width: width * 0.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage('${snapshot.data!.get('pandit_display_profile')}'),
                                  fit: BoxFit.fill
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: SelectableText(
                                    '${snapshot.data!.get('pandit_name')}',
                                    style: TextStyle(fontSize: 20, color: Colors.black),
                                    autofocus: true,
                                  )),
                              SizedBox(
                                width: 5,
                              ),
                              snapshot.data!.get('pandit_verification_status')!
                                  ? Icon(
                                Icons.verified,
                                color: Colors.orangeAccent,
                                size: 14,
                              )
                                  : Icon(
                                Icons.verified,
                                color: Colors.grey,
                                size: 12,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_history,
                                color: Colors.orangeAccent,
                                size: 14,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Text(
                                  'State : ${snapshot.data!.get('pandit_state')}',
                                  style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                                ),
                              )
                            ],
                          ),
                          Text(
                            'City : ${snapshot.data!.get('pandit_city')}',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Swastik : ${snapshot.data!['pandit_swastik']}',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          SelectableText(
                            'Contact : ${snapshot.data!['pandit_mobile_number']}',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                            autofocus: true,
                          ),
                          SelectableText(
                            'Uid : ${snapshot.data!['pandit_uid']}',
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                          /* StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance.doc("punditUsers/${uid}/user_profile/user_bank_details").snapshots(),
                            builder: (context, snapshot) {
                              if(snapshot.data==null){
                                return Container(height: 10,width: 10,);
                              }
                              final servicess = snapshot.data;
                              return Column(
                                children: [
                                  Text("Bank Name :${servicess.data()['bankName']}"??"not provided"),
                                  Text("Ifsc code :${servicess.data()['IFSC']}"??"not provided"),
                                  Text("Account Number: ${servicess.data()['accountNumber']}"??"not provided"),
                                  Text("Name on bank : ${servicess.data()['name']}"??"not provided")
                                ],
                              );
                            }
                          )*/
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Column(
                      children: [
                        Container(                          
                          width: width * 0.7,
                          height: height * 0.8,
                          child: TabBarView(                            
                            children: [                              
                              PujaOffering(asyncSnapshot: snapshot),
                              Icon(Icons.account_balance_wallet),
                              Gallery(query: snapshot,galaryImages: snapshot.data!['pandit_pictures']??[],),
                              Icon(Icons.directions_bike),
                              PanditSetting(query: snapshot),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ))
        );
        }
      ),
    );
  }}
