From: yungching0725@gmail.com (Ken Lin)
Date: Fri,  3 Feb 2017 09:21:14 +0800
Subject: [PATCH] ARM: dts: imx6q-bx50v3/imx6q-b450v3/imx6q-b650v3: change
 pca953x GPIO default settings
Message-ID: <20170203012114.20411-1-ken.lin@advantech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Leave pca953x P06,P07 pins on b850v3 platform and P06 pin on b450v3/b650v3 unconfigured
in the kernel space since they could be configured as DP1_RST and DP2_RST by the applications
for the DP FW update support

Signed-off-by: Ken Lin <ken.lin@advantech.com>
---
 arch/arm/boot/dts/imx6q-b450v3.dts  |  7 +++++++
 arch/arm/boot/dts/imx6q-b650v3.dts  |  7 +++++++
 arch/arm/boot/dts/imx6q-bx50v3.dtsi | 14 --------------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-b450v3.dts b/arch/arm/boot/dts/imx6q-b450v3.dts
index 78bfc1a307d6..04779816d3d1 100644
--- a/arch/arm/boot/dts/imx6q-b450v3.dts
+++ b/arch/arm/boot/dts/imx6q-b450v3.dts
@@ -104,4 +104,11 @@
 		output-low;
 		line-name = "PCA9539-P05";
 	};
+
+        P07 {
+                gpio-hog;
+                gpios = <7 0>;
+                output-low;
+                line-name = "PCA9539-P07";
+        };
 };
diff --git a/arch/arm/boot/dts/imx6q-b650v3.dts b/arch/arm/boot/dts/imx6q-b650v3.dts
index 1dcaee23ed9c..9ee8c81c2b80 100644
--- a/arch/arm/boot/dts/imx6q-b650v3.dts
+++ b/arch/arm/boot/dts/imx6q-b650v3.dts
@@ -97,6 +97,13 @@
 		output-low;
 		line-name = "PCA9539-P05";
 	};
+
+        P07 {
+                gpio-hog;
+                gpios = <7 0>;
+                output-low;
+                line-name = "PCA9539-P07";
+        };
 };
 
 &usbphy1 {
diff --git a/arch/arm/boot/dts/imx6q-bx50v3.dtsi b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
index e4a415fd899b..f99e6efda3e2 100644
--- a/arch/arm/boot/dts/imx6q-bx50v3.dtsi
+++ b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
@@ -184,20 +184,6 @@
 				interrupt-parent = <&gpio2>;
 				interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
 
-				P06 {
-					gpio-hog;
-					gpios = <6 0>;
-					output-low;
-					line-name = "PCA9539-P06";
-				};
-
-				P07 {
-					gpio-hog;
-					gpios = <7 0>;
-					output-low;
-					line-name = "PCA9539-P07";
-				};
-
 				P10 {
 					gpio-hog;
 					gpios = <8 0>;
-- 
2.11.0
