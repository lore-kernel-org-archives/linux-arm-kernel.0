From: ian.ray@ge.com (Ian Ray)
Date: Sun,  4 Nov 2018 08:19:38 +0200
Subject: [PATCH] ARM: dts: imx6q-bx50v3: user-space watchdog GPIO configuration
Message-ID: <12f6a6d21202bf6622bda94df6f8029cbde6c0bc.1541312342.git.ian.ray@ge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Leave b{4,6}50v3 GPIO expander pca953x pins P05,P10,P11 unconfigured as
they are now used to implement an additional watchdog mechanism in user
space.  P10,P11 pins remain unused (and therefore hogged) on b850v3.

Signed-off-by: Ian Ray <ian.ray@ge.com>
---
 arch/arm/boot/dts/imx6q-b450v3.dts  |  7 -------
 arch/arm/boot/dts/imx6q-b650v3.dts  |  7 -------
 arch/arm/boot/dts/imx6q-b850v3.dts  | 16 ++++++++++++++++
 arch/arm/boot/dts/imx6q-bx50v3.dtsi | 14 --------------
 4 files changed, 16 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-b450v3.dts b/arch/arm/boot/dts/imx6q-b450v3.dts
index 3ec5850..95b8f2d 100644
--- a/arch/arm/boot/dts/imx6q-b450v3.dts
+++ b/arch/arm/boot/dts/imx6q-b450v3.dts
@@ -98,13 +98,6 @@
 		line-name = "PCA9539-P04";
 	};
 
-	P05 {
-		gpio-hog;
-		gpios = <5 0>;
-		output-low;
-		line-name = "PCA9539-P05";
-	};
-
         P07 {
                 gpio-hog;
                 gpios = <7 0>;
diff --git a/arch/arm/boot/dts/imx6q-b650v3.dts b/arch/arm/boot/dts/imx6q-b650v3.dts
index 5650a9b..611cb7a 100644
--- a/arch/arm/boot/dts/imx6q-b650v3.dts
+++ b/arch/arm/boot/dts/imx6q-b650v3.dts
@@ -91,13 +91,6 @@
 };
 
 &pca9539 {
-	P05 {
-		gpio-hog;
-		gpios = <5 0>;
-		output-low;
-		line-name = "PCA9539-P05";
-	};
-
         P07 {
                 gpio-hog;
                 gpios = <7 0>;
diff --git a/arch/arm/boot/dts/imx6q-b850v3.dts b/arch/arm/boot/dts/imx6q-b850v3.dts
index 044a5be..e4cb118 100644
--- a/arch/arm/boot/dts/imx6q-b850v3.dts
+++ b/arch/arm/boot/dts/imx6q-b850v3.dts
@@ -209,6 +209,22 @@
 	};
 };
 
+&pca9539 {
+	P10 {
+		gpio-hog;
+		gpios = <8 0>;
+		output-low;
+		line-name = "PCA9539-P10";
+	};
+
+	P11 {
+		gpio-hog;
+		gpios = <9 0>;
+		output-low;
+		line-name = "PCA9539-P11";
+	};
+};
+
 &pci_root {
 	/* PLX Technology, Inc. PEX 8605 PCI Express 4-port Gen2 Switch */
 	bridge at 1,0 {
diff --git a/arch/arm/boot/dts/imx6q-bx50v3.dtsi b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
index d3cba09..fa27dcd 100644
--- a/arch/arm/boot/dts/imx6q-bx50v3.dtsi
+++ b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
@@ -233,20 +233,6 @@
 				interrupt-parent = <&gpio2>;
 				interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
 
-				P10 {
-					gpio-hog;
-					gpios = <8 0>;
-					output-low;
-					line-name = "PCA9539-P10";
-				};
-
-				P11 {
-					gpio-hog;
-					gpios = <9 0>;
-					output-low;
-					line-name = "PCA9539-P11";
-				};
-
 				P12 {
 					gpio-hog;
 					gpios = <10 0>;
-- 
2.10.1
