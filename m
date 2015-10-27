From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 27 Oct 2015 12:21:05 +0900
Subject: [PATCH] ARM: dts: uniphier: add system-bus-controller nodes
Message-ID: <1445916065-13118-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The System Bus Controller block has two register regions,
but having only the second one in a separate node was not nice.

Replace it with a new node with two register regions in it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ph1-ld4.dtsi     | 7 +++----
 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi    | 7 +++----
 arch/arm/boot/dts/uniphier-ph1-pro5.dtsi    | 7 +++----
 arch/arm/boot/dts/uniphier-ph1-sld3.dtsi    | 7 +++----
 arch/arm/boot/dts/uniphier-ph1-sld8.dtsi    | 7 +++----
 arch/arm/boot/dts/uniphier-proxstream2.dtsi | 7 +++----
 6 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi b/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
index ae13469..af49381 100644
--- a/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
@@ -200,10 +200,9 @@
 			clock-frequency = <100000>;
 		};
 
-		system-bus-controller-misc at 59800000 {
-			compatible = "socionext,uniphier-system-bus-controller-misc",
-				     "syscon";
-			reg = <0x59800000 0x2000>;
+		system-bus-controller at 58c00000 {
+			compatible = "socionext,uniphier-system-bus-controller";
+			reg = <0x58c00000 0x400>, <0x59800000 0x2000>;
 		};
 
 		usb0: usb at 5a800100 {
diff --git a/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi b/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
index 85377b2..254642f 100644
--- a/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
@@ -232,10 +232,9 @@
 			clock-frequency = <400000>;
 		};
 
-		system-bus-controller-misc at 59800000 {
-			compatible = "socionext,uniphier-system-bus-controller-misc",
-				     "syscon";
-			reg = <0x59800000 0x2000>;
+		system-bus-controller at 58c00000 {
+			compatible = "socionext,uniphier-system-bus-controller";
+			reg = <0x58c00000 0x400>, <0x59800000 0x2000>;
 		};
 
 		usb2: usb at 5a800100 {
diff --git a/arch/arm/boot/dts/uniphier-ph1-pro5.dtsi b/arch/arm/boot/dts/uniphier-ph1-pro5.dtsi
index 96da01e..11eb762 100644
--- a/arch/arm/boot/dts/uniphier-ph1-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-pro5.dtsi
@@ -241,10 +241,9 @@
 			clock-frequency = <400000>;
 		};
 
-		system-bus-controller-misc at 59800000 {
-			compatible = "socionext,uniphier-system-bus-controller-misc",
-				     "syscon";
-			reg = <0x59800000 0x2000>;
+		system-bus-controller at 58c00000 {
+			compatible = "socionext,uniphier-system-bus-controller";
+			reg = <0x58c00000 0x400>, <0x59800000 0x2000>;
 		};
 
 		pinctrl: pinctrl at 5f801000 {
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi b/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
index 945b37f..691a17d 100644
--- a/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
@@ -216,10 +216,9 @@
 			clock-frequency = <400000>;
 		};
 
-		system-bus-controller-misc at 59800000 {
-			compatible = "socionext,uniphier-system-bus-controller-misc",
-				     "syscon";
-			reg = <0x59800000 0x2000>;
+		system-bus-controller at 58c00000 {
+			compatible = "socionext,uniphier-system-bus-controller";
+			reg = <0x58c00000 0x400>, <0x59800000 0x2000>;
 		};
 
 		usb0: usb at 5a800100 {
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi b/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
index c98428c..e88559b 100644
--- a/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
@@ -200,10 +200,9 @@
 			clock-frequency = <100000>;
 		};
 
-		system-bus-controller-misc at 59800000 {
-			compatible = "socionext,uniphier-system-bus-controller-misc",
-				     "syscon";
-			reg = <0x59800000 0x2000>;
+		system-bus-controller at 58c00000 {
+			compatible = "socionext,uniphier-system-bus-controller";
+			reg = <0x58c00000 0x400>, <0x59800000 0x2000>;
 		};
 
 		usb0: usb at 5a800100 {
diff --git a/arch/arm/boot/dts/uniphier-proxstream2.dtsi b/arch/arm/boot/dts/uniphier-proxstream2.dtsi
index ad5fb39..259f1a9 100644
--- a/arch/arm/boot/dts/uniphier-proxstream2.dtsi
+++ b/arch/arm/boot/dts/uniphier-proxstream2.dtsi
@@ -251,10 +251,9 @@
 			clock-frequency = <400000>;
 		};
 
-		system-bus-controller-misc at 59800000 {
-			compatible = "socionext,uniphier-system-bus-controller-misc",
-				     "syscon";
-			reg = <0x59800000 0x2000>;
+		system-bus-controller at 58c00000 {
+			compatible = "socionext,uniphier-system-bus-controller";
+			reg = <0x58c00000 0x400>, <0x59800000 0x2000>;
 		};
 
 		pinctrl: pinctrl at 5f801000 {
-- 
1.9.1
