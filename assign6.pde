final int GAME_START=1,GAME_LOSE=2,GAME_RUN=3;
int gameState=GAME_START, numFrames=5;;
PImage enemy;
PImage sImg;
PImage aImg;
PImage bImg;
PImage d1Img;
PImage d2Img;
PImage hpImg;
PImage start1Img;
PImage start2Img;
PImage end1Img;
PImage end2Img;
int [][]e=new int[5][8];
int []xs=new int[5];
int score,j;
int []ys=new int[5];
int []xi=new int[8];
int []yi=new int[8];
int []aa=new int[8];
PImage []images=new PImage[numFrames];
int enemyCount = 8;
boolean up = false;
boolean down = false;
boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;
int x1,y1;//fighter
int x2,y2;//treasure
int xb1,xb2;//background
int hp;//hp
int a=0;
int jj=0,i,jjj;
int type;
int[] enemyX = new int[enemyCount];
int[] enemyY = new int[enemyCount];
boolean []xPressed = new boolean[8];
int xx=0,V=7;
PFont f;

void setup () {
  size(640, 480) ;
  f=createFont("Arial",24);
  for(int i=0;i<numFrames;i++){
   images[i]= loadImage("img/flame"+(i+1)+".png");
  }
  sImg=loadImage("img/shoot.png");
  aImg=loadImage("img/fighter.png");
  bImg=loadImage("img/treasure.png");
  d1Img=loadImage("img/bg1.png");
  d2Img=loadImage("img/bg2.png");
  hpImg=loadImage("img/hp.png");
  start1Img=loadImage("img/start1.png");
  start2Img=loadImage("img/start2.png");
  end1Img=loadImage("img/end1.png");
  end2Img=loadImage("img/end2.png");
  enemy = loadImage("img/enemy.png");
  a=0;
  score=0;
  xb1=640;
  xb2=0;
  jjj=0;
  x1=530;
  y1=200;
  x2=floor(random(3,300));
  y2=floor(random(3,277));
  hp=40;
  addEnemy(0);
  for(i=0;i<5;i++){
   xs[i]=0;
   ys[i]=0;
  }
  for(i=0;i<8;i++){
   xPressed[i] = false;
   aa[i]=0; 
  }
}

void draw()
{
  background(0);
  switch(gameState){
    case GAME_START:
    image(start2Img,0,0);
    if(mouseX>200&&mouseX<460&&mouseY>375&&mouseY<415){
      image(start1Img,0,0);
    }
    if(mousePressed&&mouseX>200&&mouseX<460&&mouseY>375&&mouseY<415){
     gameState=GAME_RUN; 
    }
    break;//.......................................................................................
    case GAME_RUN:
    if (upPressed) {
    y1 -= V;
    if(y1<0){
     y1=0; 
    }
  }
  if (downPressed) {
    y1 += V;
    if(y1>430){
     y1=430; 
    }
  }
  if (leftPressed) {
    x1 -= V;
    if(x1<0){
     x1=0; 
    }
  }
  if (rightPressed) {
    x1 += V;
    if(x1>590){
     x1=590;
    }
  }
  xx++;
  if(xx%(5)==0){
  if (keyPressed) {
    if (key == ' ') {
      if(xs[jjj%5]<-20||ys[jjj%5]==500){
      xs[jjj%5]=x1;
      ys[jjj%5]=y1+10;
      jjj++;
      }}}}
      for(i=0;i<5;i++){
      xs[i] -= 6;
      if(xs[i]<-20){
       ys[i]=500; 
      }
      }
  image(d1Img,xb1-640,0);
  xb1=xb1+1;
  xb1%=1280;
  image(d2Img,xb2-640,0);
  xb2=xb2+1;
  xb2%=1280;
  image(bImg,x2,y2);
  image(aImg,x1,y1);
  for(i=0;i<5;i++){
  image(sImg,xs[i],ys[i]);
  }
  colorMode(RGB);
  
  fill(255,0,0);
  stroke(255,0,0);
  rect(11,16,hp,13);
  
  image(hpImg,10,10);
  if(((a%3==0||a%3==1)&&enemyX[4]>700)||(a%3==2&&enemyX[7]>700)){
    a++;
   addEnemy(a%3); 
  }
  if(isHit(x1,y1,50,50,x2,y2,30,30)==true){
    if(hp+20>=200){
    hp=200;
    }else{
    hp+=20;
    }
    x2=floor(random(3,300));
    y2=floor(random(3,277));
  }
  textFont(f,40);
  fill(255);
  text("Score:"+score,10,470);
  for(i=0;i<8;i++){
  if((isHit(x1,y1,50,50,enemyX[i],enemyY[i],60,60)==true)||(x1>enemyX[i]&&x1<enemyX[i]+60&&y1+25>enemyY[i]&&y1+25<enemyY[i]+60)){
    hp-=40;
    xi[i]=enemyX[i];
    yi[i]=enemyY[i];
    xPressed[i]=true;
    enemyY[i]=-100;
    if(hp<=0){
     gameState=GAME_LOSE; 
  }}}
  for(int jj=0;jj<5;jj++){
  for(i=0;i<8;i++){
  if(isHit(xs[jj],ys[jj],40,40,enemyX[i],enemyY[i],60,60)==true&&xs[jj]>0){
    xi[i]=enemyX[i];
    yi[i]=enemyY[i];
    xPressed[i]=true;
    enemyY[i]=-100;
    ys[jj]=500;
    score+=20;
  }}}
  for(i=0;i<8;i++){
  if(xPressed[i]==true&&frameCount%(60/6)==0&&aa[i]<6){
  aa[i]++;
  image(images[aa[i]%5],xi[i],yi[i]);
  }
  if(aa[i]==6){
  xPressed[i]=false;
  aa[i]=0;
  }}
  for (int i = 0; i < enemyCount; ++i) {
    if (enemyX[i] != -200 || enemyY[i] != -200) {
      image(enemy, enemyX[i], enemyY[i]);
      enemyX[i]+=5;
      xx+=5;
    }
  }
  for(i=0;i<8;i++){
   for(int j=0;j<5;j++){
    e[j][i]=closestEnemy(xs[j],ys[j],enemyX[i],enemyY[i]); 
   }
  }
  for(j=0;j<5;j++){
   for(i=0;i<8;i++){
    for(int ii=0;ii<8;ii++){
     for(int jj=0;jj<5;jj++){
      if(e[j][i]<=e[jj][ii]){
      if(enemyY[i]>ys[j]&&ys[j]!=500&&enemyY[i]>0){
      down=true;
      }else{
       down=false; 
      }
      if(enemyY[i]<ys[j]&&ys[j]!=500&&enemyY[i]>0){
      up=true;
      }else{
       up=false; 
      }
      }
     }
    }
   }
  if(up==true){
    ys[j]-=2;
  }if(down==true){
    ys[j]+=2;
  }}
  /*i=0;
   for(int j=0;j<5;j++){
   if(closestEnemy(xs[j],ys[j],enemyX[i],enemyY[i])>ys[j]&&ys[j]!=500&&enemyY[i]>0){
    ys[j]++; 
   }if(closestEnemy(xs[j],ys[j],enemyX[i],enemyY[i])<ys[j]&&ys[j]!=500&&enemyY[i]>0){
    ys[j]--; 
   }
   if(xs[j]<enemyX[i]){
     i++;
   }
  }*/
  break;//........................................................................................
    case GAME_LOSE:
    image(end2Img,0,0);
    a=0;
  xb1=640;
  xb2=0;
  score=0;
  jjj=0;
  x1=530;
  y1=200;
  x2=floor(random(3,300));
  y2=floor(random(3,277));
  hp=40;
  addEnemy(0);
  for(i=0;i<5;i++){
   xs[i]=0;
   ys[i]=0;
  }
  for(i=0;i<8;i++){
   xPressed[i] = false;
   aa[i]=0; 
  }
    if(mouseX>210&&mouseX<440&&mouseY>305&&mouseY<350){
      image(end1Img,0,0);
    }
    if(mousePressed&&mouseX>210&&mouseX<440&&mouseY>305&&mouseY<350){
     gameState=GAME_RUN; 
  }
    break;//........................................................................................
  }
}

// 0 - straight, 1-slope, 2-dimond
void addEnemy(int type)
{  
  for (int i = 0; i < enemyCount; ++i) {
    enemyX[i] = -200;
    enemyY[i] = -200;
  }
  switch (type) {
    case 0:
      addStraightEnemy();
      break;
    case 1:
      addSlopeEnemy();
      break;
    case 2:
      addDiamondEnemy();
      break;
  }
}

void addStraightEnemy()
{
  float t = random(height - enemy.height);
  int h = int(t);
  for (int i = 0; i < 5; ++i) {

    enemyX[i] = (i+1)*-80;
    enemyY[i] = h;
  }if(i>=5&&i<8){
    enemyX[i] =-200;
    enemyY[i] = -200;
  }
}
void addSlopeEnemy()
{
  float t = random(height - enemy.height * 5);
  int h = int(t);
  for (int i = 0; i < 5; ++i) {
    enemyX[i] = (i+1)*-80;
    enemyY[i] = h + i * 40;
  }if(i>=5&&i<8){
    enemyX[i] =-200;
    enemyY[i] =-200;
  }
}
void addDiamondEnemy()
{
  float t = random( enemy.height * 3 ,height - enemy.height * 3);
  int h = int(t);
  int x_axis = 1;
  for (int i = 0; i < 8; ++i) {
    if (i == 0 || i == 7) {
      enemyX[i] = x_axis*-80;
      enemyY[i] = h;
      x_axis++;
    }
    else if (i == 1 || i == 5){
      enemyX[i] = x_axis*-80;
      enemyY[i] = h + 1 * 40;
      enemyX[i+1] = x_axis*-80;
      enemyY[i+1] = h - 1 * 40;
      i++;
      x_axis++;
      
    }
    else {
      enemyX[i] = x_axis*-80;
      enemyY[i] = h + 2 * 40;
      enemyX[i+1] = x_axis*-80;
      enemyY[i+1] = h - 2 * 40;
      i++;
      x_axis++;
    }
  }
}

boolean isHit(int ax,int ay,int ah,int aw,int bx,int by,int bh,int bw){
 if(((ax>=bx && ax<=bx+bw) && (ay+(1/2)*ah>=by && ay+(1/2)*ah<=by+bh))||((ax+(1/2)*aw>=bx && ax+(1/2)*aw<=bx+bw) && (ay>=by && ay<=by+bh))||((ax+(1/2)*aw>=bx && ax+(1/2)*aw<=bx+bw) && (ay+ah>=by && ay+ah<=by+bh))||((ax+aw>=bx && ax+aw<=bx+bw) && (ay>=by && ay<=by+bh))||((ax+aw>=bx && ax+aw<=bx+bw) && (ay+ah>=by && ay+ah<=by+bh))||((ax+aw>=bx && ax+(1/2)*aw<=bx+bw) && (ay+ah>=by && ay+(1/2)*ah<=by+bh))) {
   return true;
 }else{
  return false; 
 }
 }

void keyPressed() {
  if (key == CODED) { // detect special keys 
    switch (keyCode) {
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    switch (keyCode) {
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}

int closestEnemy(int xx1,int yy1,int xx2,int yy2){
  if(xx1>=xx2){
   if(yy1>=yy2){
   return (xx1-xx2)*(xx1-xx2)+(yy1-yy2)*(yy1-yy2);
   }else{
   return  (xx1-xx2)*(xx1-xx2)+(yy2-yy1)*(yy2-yy1);
   }
  }else{
    if(yy1>=yy2){
   return (xx2-xx1)*(xx2-xx1)+(yy1-yy2)*(yy1-yy2);
   }else{
   return  (xx1-xx2)*(xx1-xx2)+(yy1-yy2)*(yy1-yy2);
  }
  }
}
