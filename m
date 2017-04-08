From: dev@lynxeye.de (Lucas Stach)
Date: Sat,  8 Apr 2017 16:36:07 +0200
Subject: [RFC PATCH 7/7] ARM: dts: imx6*-hummingboard2: rework regulators
In-Reply-To: <20170408143607.15928-1-dev@lynxeye.de>
References: <20170408143607.15928-1-dev@lynxeye.de>
Message-ID: <20170408143607.15928-8-dev@lynxeye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Name the regulators according to the voltage rails they are feeding in
the schematic. The USB 2-4 regulators are fixed regulators and are always
on, as they are not a VBUS supply for a single USB host port on the i.MX6,
but supply VBUS to ports behind a USB hub and there is currently no way
to model this in mainline.

Signed-off-by: Lucas Stach <dev@lynxeye.de>
---
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi | 30 ++++++++++++++--------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
index 892259f..19fe9d1 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
@@ -58,7 +58,7 @@
 
 	reg_3p3v: regulator-3p3v {
 		compatible = "regulator-fixed";
-		regulator-name = "3P3V";
+		regulator-name = "VCC_3V2";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
@@ -66,21 +66,22 @@
 
 	reg_1p8v: regulator-1p8v {
 		compatible = "regulator-fixed";
-		regulator-name = "1P8V";
+		regulator-name = "VCC_1V8";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 		regulator-always-on;
 	};
 
-	reg_usbh1_vbus: regulator-usb-h1-vbus {
+	reg_usbh2_vbus: regulator-usb-h1-vbus {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio1 0 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_hummingboard2_usbh1_vbus>;
-		regulator-name = "usb_h1_vbus";
+		regulator-name = "V_USB2";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
 	};
 
 	reg_usbotg_vbus: regulator-usb-otg-vbus {
@@ -89,33 +90,33 @@
 		gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_hummingboard2_usbotg_vbus>;
-		regulator-name = "usb_otg_vbus";
+		regulator-name = "V_USB1";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 	};
 
-	reg_usbh2_vbus: regulator-usb-h2-vbus {
-		compatible = "regulator-gpio";
+	reg_usbh3_vbus: regulator-usb-h2-vbus {
+		compatible = "regulator-fixed";
 		enable-active-high;
 		enable-gpio = <&gpio2 13 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_hummingboard2_usbh2_vbus>;
-		regulator-name = "usb_h2_vbus";
+		regulator-name = "V_USB3";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		regulator-boot-on;
+		regulator-always-on;
 	};
 
-	reg_usbh3_vbus: regulator-usb-h3-vbus {
-		compatible = "regulator-gpio";
+	reg_usbh4_vbus: regulator-usb-h3-vbus {
+		compatible = "regulator-fixed";
 		enable-active-high;
 		enable-gpio = <&gpio7 10 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_hummingboard2_usbh3_vbus>;
-		regulator-name = "usb_h3_vbus";
+		regulator-name = "V_USB4";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		regulator-boot-on;
+		regulator-always-on;
 	};
 
 	reg_usdhc2_vmmc: reg-usdhc2-vmmc {
@@ -126,7 +127,7 @@
 		regulator-boot-on;
 		regulator-max-microvolt = <3300000>;
 		regulator-min-microvolt = <3300000>;
-		regulator-name = "usdhc2_vmmc";
+		regulator-name = "V_SD";
 		startup-delay-us = <1000>;
 	};
 
@@ -488,7 +489,6 @@
 
 &usbh1 {
 	disable-over-current;
-	vbus-supply = <&reg_usbh1_vbus>;
 	status = "okay";
 };
 
-- 
2.9.3
