From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 11 Dec 2017 16:57:53 +0000
Subject: [PATCH 07/20] ARM: dts: imx6*-hummingboard2: use proper gpio flags
 definitions
In-Reply-To: <20171211165631.GW10595@n2100.armlinux.org.uk>
References: <20171211165631.GW10595@n2100.armlinux.org.uk>
Message-ID: <E1eOROr-0000HP-82@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use proper gpio flag definitions for GPIOs rather than using opaque
uninformative numbers.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
index b632eb73e85c..4723bb279e57 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
@@ -46,7 +46,7 @@
 
 	ir_recv: ir-receiver {
 		compatible = "gpio-ir-receiver";
-		gpios = <&gpio7 9 1>;
+		gpios = <&gpio7 9 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_hummingboard2_gpio7_9>;
 		linux,rc-map-name = "rc-rc6-mce";
@@ -76,7 +76,7 @@
 	reg_usbh1_vbus: regulator-usb-h1-vbus {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio1 0 0>;
+		gpio = <&gpio1 0 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_hummingboard2_usbh1_vbus>;
 		regulator-name = "usb_h1_vbus";
@@ -87,7 +87,7 @@
 	reg_usbotg_vbus: regulator-usb-otg-vbus {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio3 22 0>;
+		gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_hummingboard2_usbotg_vbus>;
 		regulator-name = "usb_otg_vbus";
@@ -98,7 +98,7 @@
 	reg_usbh2_vbus: regulator-usb-h2-vbus {
 		compatible = "regulator-gpio";
 		enable-active-high;
-		enable-gpio = <&gpio2 13 0>;
+		enable-gpio = <&gpio2 13 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_hummingboard2_usbh2_vbus>;
 		regulator-name = "usb_h2_vbus";
@@ -110,7 +110,7 @@
 	reg_usbh3_vbus: regulator-usb-h3-vbus {
 		compatible = "regulator-gpio";
 		enable-active-high;
-		enable-gpio = <&gpio7 10 0>;
+		enable-gpio = <&gpio7 10 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_hummingboard2_usbh3_vbus>;
 		regulator-name = "usb_h3_vbus";
-- 
2.7.4
