From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 19 Apr 2017 13:09:16 +0800
Subject: [PATCH 1/4] ARM: sunxi: common-regulators: Drop pinmux settings for
 GPIO pins
In-Reply-To: <20170419050919.6762-1-wens@csie.org>
References: <20170419050919.6762-1-wens@csie.org>
Message-ID: <20170419050919.6762-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As part of our effort to move pinctrl/GPIO interlocking into the
driver where it belongs, this patch drops the definition and usage
of the pinmux settings for the common regulators defined in
sunxi-common-regulators.dtsi.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts       |  4 ---
 arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts       |  8 ------
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts       |  4 ---
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts   |  4 ---
 arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts           |  4 ---
 .../boot/dts/sun5i-a13-empire-electronix-d709.dts  |  4 ---
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts           |  5 ----
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts          |  4 ---
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts        |  5 ----
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts          |  8 ------
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts           |  4 ---
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts          |  4 ---
 arch/arm/boot/dts/sunxi-common-regulators.dtsi     | 30 ----------------------
 13 files changed, 88 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts b/arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts
index 85dcf81ab64e..bc4351bb851f 100644
--- a/arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts
+++ b/arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts
@@ -120,10 +120,6 @@
 	status = "okay";
 };
 
-&usb2_vbus_pin_a {
-	pins = "PH6";
-};
-
 &usb_otg {
 	dr_mode = "otg";
 	status = "okay";
diff --git a/arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts b/arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts
index c6f742a7e69f..d2dee8d434bf 100644
--- a/arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts
@@ -136,14 +136,6 @@
 	status = "okay";
 };
 
-&usb0_vbus_pin_a {
-	pins = "PG13";
-};
-
-&usb1_vbus_pin_a {
-	pins = "PB10";
-};
-
 &usb_otg {
 	dr_mode = "host";
 	status = "okay";
diff --git a/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts b/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
index a27c3fa58736..16f839df4227 100644
--- a/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
@@ -168,10 +168,6 @@
 	status = "okay";
 };
 
-&usb1_vbus_pin_a {
-	pins = "PG13";
-};
-
 &usbphy {
 	pinctrl-names = "default";
 	pinctrl-0 = <&usb0_id_detect_pin>;
diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index 894f874a5beb..eff36fe1aaa3 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -271,10 +271,6 @@
 	status = "okay";
 };
 
-&usb0_vbus_pin_a {
-	pins = "PG11";
-};
-
 &usbphy {
 	pinctrl-names = "default";
 	pinctrl-0 = <&usb0_id_detect_pin>;
diff --git a/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts b/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
index ea3e5655a61b..5482be174e12 100644
--- a/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
@@ -216,10 +216,6 @@
 	status = "okay";
 };
 
-&usb1_vbus_pin_a {
-	pins = "PG12";
-};
-
 &usbphy {
 	usb1_vbus-supply = <&reg_usb1_vbus>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts b/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts
index 34411d27aadf..3dbb0d7c2f8c 100644
--- a/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts
+++ b/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts
@@ -207,10 +207,6 @@
 	status = "okay";
 };
 
-&usb0_vbus_pin_a {
-	pins = "PG12";
-};
-
 &usbphy {
 	pinctrl-names = "default";
 	pinctrl-0 = <&usb0_id_detect_pin>, <&usb0_vbus_detect_pin>;
diff --git a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
index 2489c16f7efa..584fa579ded2 100644
--- a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
+++ b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
@@ -186,7 +186,6 @@
 };
 
 &reg_usb0_vbus {
-	pinctrl-0 = <&usb0_vbus_pin_a>;
 	gpio = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
 	status = "okay";
 };
@@ -202,10 +201,6 @@
 	status = "okay";
 };
 
-&usb0_vbus_pin_a {
-	pins = "PG12";
-};
-
 &usbphy {
 	pinctrl-names = "default";
 	pinctrl-0 = <&usb0_id_detect_pin>, <&usb0_vbus_detect_pin>;
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
index 95f591bb8ced..38072c7e10e2 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
@@ -269,10 +269,6 @@
 	status = "okay";
 };
 
-&usb0_vbus_pin_a {
-	pins = "PG12";
-};
-
 &usbphy {
 	pinctrl-names = "default";
 	pinctrl-0 = <&usb0_id_detect_pin>, <&usb0_vbus_detect_pin>;
diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index d4f74f476f25..b4c87a23e3f8 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -344,11 +344,6 @@
 	status = "okay";
 };
 
-&usb1_vbus_pin_a {
-	/* different pin from sunxi-common-regulators */
-	pins = "PH24";
-};
-
 &usbphy {
 	usb0_id_det-gpio = <&pio 0 15 GPIO_ACTIVE_HIGH>; /* PA15 */
 	usb0_vbus_det-gpio = <&pio 0 16 GPIO_ACTIVE_HIGH>; /* PA16 */
diff --git a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
index 96bb0bc198ba..004b6ddac813 100644
--- a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
+++ b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
@@ -85,10 +85,6 @@
 	};
 };
 
-&ahci_pwr_pin_a {
-	pins = "PB3";
-};
-
 &ahci {
 	target-supply = <&reg_ahci_5v>;
 	status = "okay";
@@ -319,10 +315,6 @@
 	status = "okay";
 };
 
-&usb2_vbus_pin_a {
-	pins = "PH12";
-};
-
 &usbphy {
 	pinctrl-names = "default";
 	pinctrl-0 = <&usb0_id_detect_pin>;
diff --git a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
index 7c96b53b76bf..98177b5891cb 100644
--- a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
+++ b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
@@ -106,10 +106,6 @@
 	status = "okay";
 };
 
-&ahci_pwr_pin_a {
-	pins = "PH2";
-};
-
 &codec {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
index 5b6d14555b7c..d7d5330c566f 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
@@ -195,10 +195,6 @@
 	status = "disabled";
 };
 
-&usb1_vbus_pin_a {
-	pins = "PG13";
-};
-
 &usbphy {
 	usb1_vbus-supply = <&reg_usb1_vbus>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/sunxi-common-regulators.dtsi b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
index ce5c53e4452f..d8e5826fb3de 100644
--- a/arch/arm/boot/dts/sunxi-common-regulators.dtsi
+++ b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
@@ -44,33 +44,9 @@
 
 #include <dt-bindings/gpio/gpio.h>
 
-&pio {
-	ahci_pwr_pin_a: ahci_pwr_pin at 0 {
-		pins = "PB8";
-		function = "gpio_out";
-	};
-
-	usb0_vbus_pin_a: usb0_vbus_pin at 0 {
-		pins = "PB9";
-		function = "gpio_out";
-	};
-
-	usb1_vbus_pin_a: usb1_vbus_pin at 0 {
-		pins = "PH6";
-		function = "gpio_out";
-	};
-
-	usb2_vbus_pin_a: usb2_vbus_pin at 0 {
-		pins = "PH3";
-		function = "gpio_out";
-	};
-};
-
 / {
 	reg_ahci_5v: ahci-5v {
 		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&ahci_pwr_pin_a>;
 		regulator-name = "ahci-5v";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
@@ -82,8 +58,6 @@
 
 	reg_usb0_vbus: usb0-vbus {
 		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&usb0_vbus_pin_a>;
 		regulator-name = "usb0-vbus";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
@@ -94,8 +68,6 @@
 
 	reg_usb1_vbus: usb1-vbus {
 		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&usb1_vbus_pin_a>;
 		regulator-name = "usb1-vbus";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
@@ -107,8 +79,6 @@
 
 	reg_usb2_vbus: usb2-vbus {
 		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&usb2_vbus_pin_a>;
 		regulator-name = "usb2-vbus";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-- 
2.11.0
