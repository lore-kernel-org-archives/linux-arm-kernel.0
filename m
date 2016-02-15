From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 15 Feb 2016 17:13:02 +0000
Subject: [PATCH] ARM: dts: imx6*-hummingboard: use proper gpio flags
 definitions
Message-ID: <E1aVMhq-0001x5-ST@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use proper gpio flag definitions for GPIOs rather than using opaque
uninformative numbers.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
index 81be050c8d3c..3a06516fe7a9 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
@@ -48,7 +48,7 @@
 
 	ir_recv: ir-receiver {
 		compatible = "gpio-ir-receiver";
-		gpios = <&gpio3 5 1>;
+		gpios = <&gpio3 5 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_hummingboard_gpio3_5>;
 	};
@@ -67,7 +67,7 @@
 		reg_usbh1_vbus: usb-h1-vbus {
 			compatible = "regulator-fixed";
 			enable-active-high;
-			gpio = <&gpio1 0 0>;
+			gpio = <&gpio1 0 GPIO_ACTIVE_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_hummingboard_usbh1_vbus>;
 			regulator-name = "usb_h1_vbus";
@@ -78,7 +78,7 @@
 		reg_usbotg_vbus: usb-otg-vbus {
 			compatible = "regulator-fixed";
 			enable-active-high;
-			gpio = <&gpio3 22 0>;
+			gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_hummingboard_usbotg_vbus>;
 			regulator-name = "usb_otg_vbus";
-- 
2.1.0
