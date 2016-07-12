From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 13 Jul 2016 01:07:29 +0200
Subject: [PATCH 3/4] Documentation: dt: usb: atmel-usb: add unit-address
In-Reply-To: <1468364850-32475-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1468364850-32475-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1468364850-32475-3-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The endpoint nodes have a reg property, they also need a unit-address. Add
them in the example.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 Documentation/devicetree/bindings/usb/atmel-usb.txt | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/atmel-usb.txt b/Documentation/devicetree/bindings/usb/atmel-usb.txt
index 5883b73ea1b5..f4262ed60582 100644
--- a/Documentation/devicetree/bindings/usb/atmel-usb.txt
+++ b/Documentation/devicetree/bindings/usb/atmel-usb.txt
@@ -113,13 +113,13 @@ usb2: gadget at fff78000 {
 	clock-names = "hclk", "pclk";
 	atmel,vbus-gpio = <&pioB 19 0>;
 
-	ep0 {
+	ep at 0 {
 		reg = <0>;
 		atmel,fifo-size = <64>;
 		atmel,nb-banks = <1>;
 	};
 
-	ep1 {
+	ep at 1 {
 		reg = <1>;
 		atmel,fifo-size = <1024>;
 		atmel,nb-banks = <2>;
@@ -127,7 +127,7 @@ usb2: gadget at fff78000 {
 		atmel,can-isoc;
 	};
 
-	ep2 {
+	ep at 2 {
 		reg = <2>;
 		atmel,fifo-size = <1024>;
 		atmel,nb-banks = <2>;
@@ -135,21 +135,21 @@ usb2: gadget at fff78000 {
 		atmel,can-isoc;
 	};
 
-	ep3 {
+	ep at 3 {
 		reg = <3>;
 		atmel,fifo-size = <1024>;
 		atmel,nb-banks = <3>;
 		atmel,can-dma;
 	};
 
-	ep4 {
+	ep at 4 {
 		reg = <4>;
 		atmel,fifo-size = <1024>;
 		atmel,nb-banks = <3>;
 		atmel,can-dma;
 	};
 
-	ep5 {
+	ep at 5 {
 		reg = <5>;
 		atmel,fifo-size = <1024>;
 		atmel,nb-banks = <3>;
@@ -157,7 +157,7 @@ usb2: gadget at fff78000 {
 		atmel,can-isoc;
 	};
 
-	ep6 {
+	ep at 6 {
 		reg = <6>;
 		atmel,fifo-size = <1024>;
 		atmel,nb-banks = <3>;
-- 
2.8.1
