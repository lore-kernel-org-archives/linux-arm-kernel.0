From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 15 Oct 2015 22:48:44 +0200
Subject: [PATCH RFT] ARM: bcm2835: dt: fix memory of Raspberry Pi B+
Message-ID: <1444942124-23122-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the Raspberry Pi models differ in memory amount we
better define it at board level. After that we are able
to fix the memory node of the Raspberry Pi B+ .

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts |    4 ++++
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts |    4 ++++
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts |    4 ++++
 arch/arm/boot/dts/bcm2835-rpi-b.dts      |    4 ++++
 arch/arm/boot/dts/bcm2835-rpi.dtsi       |    4 ----
 5 files changed, 16 insertions(+), 4 deletions(-)

This patch is only compile-tested.

diff --git a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
index b2bff43..c08dff2 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
@@ -5,6 +5,10 @@
 	compatible = "raspberrypi,model-a-plus", "brcm,bcm2835";
 	model = "Raspberry Pi Model A+";
 
+	memory {
+		reg = <0 0x10000000>; /* 256 MB */
+	};
+
 	leds {
 		act {
 			gpios = <&gpio 47 0>;
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
index 668442b..b4a1e56 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
@@ -5,6 +5,10 @@
 	compatible = "raspberrypi,model-b-plus", "brcm,bcm2835";
 	model = "Raspberry Pi Model B+";
 
+	memory {
+		reg = <0 0x20000000>; /* 512 MB */
+	};
+
 	leds {
 		act {
 			gpios = <&gpio 47 0>;
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
index eab8b591..e6ccfab 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
@@ -5,6 +5,10 @@
 	compatible = "raspberrypi,model-b-rev2", "brcm,bcm2835";
 	model = "Raspberry Pi Model B rev2";
 
+	memory {
+		reg = <0 0x10000000>; /* 256 MB */
+	};
+
 	leds {
 		act {
 			gpios = <&gpio 16 1>;
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b.dts b/arch/arm/boot/dts/bcm2835-rpi-b.dts
index ff6b2d1..bfd917c 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b.dts
@@ -5,6 +5,10 @@
 	compatible = "raspberrypi,model-b", "brcm,bcm2835";
 	model = "Raspberry Pi Model B";
 
+	memory {
+		reg = <0 0x10000000>; /* 256 MB */
+	};
+
 	leds {
 		act {
 			gpios = <&gpio 16 1>;
diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index 3572f03..d1c6538 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -1,10 +1,6 @@
 #include "bcm2835.dtsi"
 
 / {
-	memory {
-		reg = <0 0x10000000>;
-	};
-
 	leds {
 		compatible = "gpio-leds";
 
-- 
1.7.10.4
