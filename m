From: codekipper@gmail.com (codekipper at gmail.com)
Date: Sat, 23 Jan 2016 16:18:19 +0100
Subject: [linux-sunxi][PATCH v4 3/3] ARM: dts: sun4i: Itead Iteaduino to use
 common code
In-Reply-To: <1453562299-18495-1-git-send-email-codekipper@gmail.com>
References: <1453562299-18495-1-git-send-email-codekipper@gmail.com>
Message-ID: <1453562299-18495-4-git-send-email-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Convert the Itead Iteaduino A10 to use the new common itead core dtsi.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 .../boot/dts/sun4i-a10-itead-iteaduino-plus.dts    | 86 +---------------------
 1 file changed, 2 insertions(+), 84 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-itead-iteaduino-plus.dts b/arch/arm/boot/dts/sun4i-a10-itead-iteaduino-plus.dts
index 985e155..4e798f0 100644
--- a/arch/arm/boot/dts/sun4i-a10-itead-iteaduino-plus.dts
+++ b/arch/arm/boot/dts/sun4i-a10-itead-iteaduino-plus.dts
@@ -1,5 +1,6 @@
 /*
  * Copyright 2015 Josef Gajdusek <atx@atx.name>
+ * Copyright 2015 - Marcus Cooper <codekipper@gmail.com>
  *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPL or the X11 license, at your option. Note that this dual
@@ -42,22 +43,11 @@
 
 /dts-v1/;
 #include "sun4i-a10.dtsi"
-#include "sunxi-common-regulators.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
+#include "sunxi-itead-core-common.dtsi"
 
 / {
 	model = "Iteaduino Plus A10";
 	compatible = "itead,iteaduino-plus-a10", "allwinner,sun4i-a10";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
 };
 
 &ahci {
@@ -65,18 +55,6 @@
 	status = "okay";
 };
 
-&cpu0 {
-	cpu-supply = <&reg_dcdc2>;
-};
-
-&ehci0 {
-	status = "okay";
-};
-
-&ehci1 {
-	status = "okay";
-};
-
 &emac {
 	pinctrl-names = "default";
 	pinctrl-0 = <&emac_pins_a>;
@@ -89,12 +67,7 @@
 };
 
 &i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
-	status = "okay";
-
 	axp209: pmic at 34 {
-		reg = <0x34>;
 		interrupts = <0>;
 	};
 };
@@ -135,68 +108,13 @@
 	status = "okay";
 };
 
-&ohci0 {
-	status = "okay";
-};
-
-&ohci1 {
-	status = "okay";
-};
-
 &reg_ahci_5v {
 	status = "okay";
 };
 
-#include "axp209.dtsi"
-
-&reg_dcdc2 {
-	regulator-always-on;
-	regulator-min-microvolt = <1000000>;
-	regulator-max-microvolt = <1450000>;
-	regulator-name = "vdd-cpu";
-};
-
-&reg_dcdc3 {
-	regulator-always-on;
-	regulator-min-microvolt = <1000000>;
-	regulator-max-microvolt = <1400000>;
-	regulator-name = "vdd-int-dll";
-};
-
-&reg_ldo1 {
-	regulator-name = "vdd-rtc";
-};
-
-&reg_ldo2 {
-	regulator-always-on;
-	regulator-min-microvolt = <3000000>;
-	regulator-max-microvolt = <3000000>;
-	regulator-name = "avcc";
-};
-
-&reg_usb1_vbus {
-	status = "okay";
-};
-
-&reg_usb2_vbus {
-	status = "okay";
-};
-
 &spi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi0_pins_a>,
 		    <&spi0_cs0_pins_a>;
 	status = "okay";
 };
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
-	status = "okay";
-};
-
-&usbphy {
-	usb1_vbus-supply = <&reg_usb1_vbus>;
-	usb2_vbus-supply = <&reg_usb2_vbus>;
-	status = "okay";
-};
-- 
2.7.0
