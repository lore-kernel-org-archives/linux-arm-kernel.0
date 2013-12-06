From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Fri,  6 Dec 2013 15:56:40 +0100
Subject: [PATCH] ARM: i.MX28: dts: rename usbphy pin names
Message-ID: <1386341800-12098-1-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pins have nothing todo with the phy layer. We better rename them, so
it gets clear they are routed to the ehci core not to any phy.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 arch/arm/boot/dts/imx28-cfa10037.dts | 2 +-
 arch/arm/boot/dts/imx28-cfa10049.dts | 2 +-
 arch/arm/boot/dts/imx28-cfa10057.dts | 2 +-
 arch/arm/boot/dts/imx28-cfa10058.dts | 2 +-
 arch/arm/boot/dts/imx28-m28cu3.dts   | 2 +-
 arch/arm/boot/dts/imx28-m28evk.dts   | 4 ++--
 arch/arm/boot/dts/imx28-sps1.dts     | 2 +-
 arch/arm/boot/dts/imx28.dtsi         | 6 +++---
 8 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-cfa10037.dts b/arch/arm/boot/dts/imx28-cfa10037.dts
index f93e9a7..3935e86 100644
--- a/arch/arm/boot/dts/imx28-cfa10037.dts
+++ b/arch/arm/boot/dts/imx28-cfa10037.dts
@@ -54,7 +54,7 @@
 	ahb at 80080000 {
 		usb1: usb at 80090000 {
 			vbus-supply = <&reg_usb1_vbus>;
-			pinctrl-0 = <&usbphy1_pins_a>;
+			pinctrl-0 = <&usb1_pins_a>;
 			pinctrl-names = "default";
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
index 7087b4b..f1d4e2a 100644
--- a/arch/arm/boot/dts/imx28-cfa10049.dts
+++ b/arch/arm/boot/dts/imx28-cfa10049.dts
@@ -274,7 +274,7 @@
 	ahb at 80080000 {
 		usb1: usb at 80090000 {
 			vbus-supply = <&reg_usb1_vbus>;
-			pinctrl-0 = <&usbphy1_pins_a>;
+			pinctrl-0 = <&usb1_pins_a>;
 			pinctrl-names = "default";
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/imx28-cfa10057.dts b/arch/arm/boot/dts/imx28-cfa10057.dts
index 3c13128..4f6394b 100644
--- a/arch/arm/boot/dts/imx28-cfa10057.dts
+++ b/arch/arm/boot/dts/imx28-cfa10057.dts
@@ -134,7 +134,7 @@
 	ahb at 80080000 {
 		usb1: usb at 80090000 {
 			vbus-supply = <&reg_usb1_vbus>;
-			pinctrl-0 = <&usbphy1_pins_a>;
+			pinctrl-0 = <&usb1_pins_a>;
 			pinctrl-names = "default";
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/imx28-cfa10058.dts b/arch/arm/boot/dts/imx28-cfa10058.dts
index 2469d34..62382b6 100644
--- a/arch/arm/boot/dts/imx28-cfa10058.dts
+++ b/arch/arm/boot/dts/imx28-cfa10058.dts
@@ -101,7 +101,7 @@
 	ahb at 80080000 {
 		usb1: usb at 80090000 {
 			vbus-supply = <&reg_usb1_vbus>;
-			pinctrl-0 = <&usbphy1_pins_a>;
+			pinctrl-0 = <&usb1_pins_a>;
 			pinctrl-names = "default";
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/imx28-m28cu3.dts b/arch/arm/boot/dts/imx28-m28cu3.dts
index d3958da..8f75736 100644
--- a/arch/arm/boot/dts/imx28-m28cu3.dts
+++ b/arch/arm/boot/dts/imx28-m28cu3.dts
@@ -180,7 +180,7 @@
 		usb1: usb at 80090000 {
 			vbus-supply = <&reg_usb1_vbus>;
 			pinctrl-names = "default";
-			pinctrl-0 = <&usbphy1_pins_a>;
+			pinctrl-0 = <&usb1_pins_a>;
 			disable-over-current;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/imx28-m28evk.dts b/arch/arm/boot/dts/imx28-m28evk.dts
index 8e2477f..6a13e5c 100644
--- a/arch/arm/boot/dts/imx28-m28evk.dts
+++ b/arch/arm/boot/dts/imx28-m28evk.dts
@@ -248,14 +248,14 @@
 		usb0: usb at 80080000 {
 			vbus-supply = <&reg_usb0_vbus>;
 			pinctrl-names = "default";
-			pinctrl-0 = <&usbphy0_pins_a>;
+			pinctrl-0 = <&usb0_pins_a>;
 			status = "okay";
 		};
 
 		usb1: usb at 80090000 {
 			vbus-supply = <&reg_usb1_vbus>;
 			pinctrl-names = "default";
-			pinctrl-0 = <&usbphy1_pins_a>;
+			pinctrl-0 = <&usb1_pins_a>;
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/imx28-sps1.dts b/arch/arm/boot/dts/imx28-sps1.dts
index 4870f07..097354c 100644
--- a/arch/arm/boot/dts/imx28-sps1.dts
+++ b/arch/arm/boot/dts/imx28-sps1.dts
@@ -106,7 +106,7 @@
 		usb0: usb at 80080000 {
 			vbus-supply = <&reg_usb0_vbus>;
 			pinctrl-names = "default";
-			pinctrl-0 = <&usbphy0_pins_b>;
+			pinctrl-0 = <&usb0_pins_b>;
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index cda19c8..5f29304 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -743,7 +743,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				usbphy0_pins_a: usbphy0 at 0 {
+				usb0_pins_a: usb0 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
 						MX28_PAD_SSP2_SS2__USB0_OVERCURRENT
@@ -753,7 +753,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				usbphy0_pins_b: usbphy0 at 1 {
+				usb0_pins_b: usb0 at 1 {
 					reg = <1>;
 					fsl,pinmux-ids = <
 						MX28_PAD_AUART1_CTS__USB0_OVERCURRENT
@@ -763,7 +763,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				usbphy1_pins_a: usbphy1 at 0 {
+				usb1_pins_a: usb1 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
 						MX28_PAD_SSP2_SS1__USB1_OVERCURRENT
-- 
1.8.4.3
