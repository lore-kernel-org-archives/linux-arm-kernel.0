From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 08 Jan 2017 15:03:21 +0000
Subject: [PATCH 3/4] ARM: dts: imx6*-hummingboard2: use proper gpio flags
 definitions
In-Reply-To: <20170108150201.GS14217@n2100.armlinux.org.uk>
References: <20170108150201.GS14217@n2100.armlinux.org.uk>
Message-ID: <E1cQF0D-0003NG-PD@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use proper gpio flag definitions for GPIOs rather than using opaque
uninformative numbers.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
index a98ddcad175f..88833d757f7b 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
@@ -50,7 +50,7 @@
 
 	ir_recv: ir-receiver {
 		compatible = "gpio-ir-receiver";
-		gpios = <&gpio7 9 1>;
+		gpios = <&gpio7 9 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_hummingboard2_gpio7_9>;
 		linux,rc-map-name = "rc-rc6-mce";
@@ -78,7 +78,7 @@
 		reg_usbh1_vbus: usb-h1-vbus {
 			compatible = "regulator-fixed";
 			enable-active-high;
-			gpio = <&gpio1 0 0>;
+			gpio = <&gpio1 0 GPIO_ACTIVE_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_hummingboard2_usbh1_vbus>;
 			regulator-name = "usb_h1_vbus";
@@ -89,7 +89,7 @@
 		reg_usbotg_vbus: usb-otg-vbus {
 			compatible = "regulator-fixed";
 			enable-active-high;
-			gpio = <&gpio3 22 0>;
+			gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_hummingboard2_usbotg_vbus>;
 			regulator-name = "usb_otg_vbus";
@@ -100,7 +100,7 @@
 		reg_usbh2_vbus: usb-h2-vbus {
 			compatible = "regulator-gpio";
 			enable-active-high;
-			enable-gpio = <&gpio2 13 0>;
+			enable-gpio = <&gpio2 13 GPIO_ACTIVE_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_hummingboard2_usbh2_vbus>;
 			regulator-name = "usb_h2_vbus";
@@ -112,7 +112,7 @@
 		reg_usbh3_vbus: usb-h3-vbus {
 			compatible = "regulator-gpio";
 			enable-active-high;
-			enable-gpio = <&gpio7 10 0>;
+			enable-gpio = <&gpio7 10 GPIO_ACTIVE_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_hummingboard2_usbh3_vbus>;
 			regulator-name = "usb_h3_vbus";
-- 
2.7.4
