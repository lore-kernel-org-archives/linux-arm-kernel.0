From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:11 +0100
Subject: [PATCH 10/77] ARM: dts: sun5i: Remove all useless pinctrl nodes
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <820ad10fea1f06f9be94497f82df3cd6cad070b1.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gpio pinctrl nodes are redundant and as such useless most of the times.
Since they will also generate warnings in DTC, we can simply remove most of
them.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts         |  6 +---
 arch/arm/boot/dts/sun5i-a10s-mk802.dts               | 13 +------
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts     |  6 +---
 arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts        |  6 +---
 arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts             | 14 +-------
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts             |  7 +---
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts      | 12 +------
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts            |  6 +---
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts             |  8 +----
 arch/arm/boot/dts/sun5i-gr8-chip-pro.dts             | 16 +--------
 arch/arm/boot/dts/sun5i-gr8-evb.dts                  | 27 +-------------
 arch/arm/boot/dts/sun5i-r8-chip.dts                  | 19 +---------
 arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi | 21 +----------
 13 files changed, 2 insertions(+), 159 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts b/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
index 8d4fb9331212..d5bca68ca6ca 100644
--- a/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
@@ -72,7 +72,6 @@
 	reg_vmmc1: vmmc1 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
-		pinctrl-0 = <&mmc1_vcc_en_pin_t004>;
 		regulator-name = "vmmc1";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
@@ -139,11 +138,6 @@
 		bias-pull-up;
 	};
 
-	mmc1_vcc_en_pin_t004: mmc1_vcc_en_pin at 0 {
-		pins = "PB18";
-		function = "gpio_out";
-	};
-
 	led_pins_t004: led_pins at 0 {
 		pins = "PB2";
 		function = "gpio_out";
diff --git a/arch/arm/boot/dts/sun5i-a10s-mk802.dts b/arch/arm/boot/dts/sun5i-a10s-mk802.dts
index dd7fd5c3d76f..b17c036293d6 100644
--- a/arch/arm/boot/dts/sun5i-a10s-mk802.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-mk802.dts
@@ -59,8 +59,6 @@
 
 	leds {
 		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_mk802>;
 
 		red {
 			label = "mk802:red:usr";
@@ -114,25 +112,14 @@
 };
 
 &pio {
-	led_pins_mk802: led_pins at 0 {
-		pins = "PB2";
-		function = "gpio_out";
-	};
-
 	mmc0_cd_pin_mk802: mmc0_cd_pin at 0 {
 		pins = "PG1";
 		function = "gpio_in";
 		bias-pull-up;
 	};
-
-	usb1_vbus_pin_mk802: usb1_vbus_pin at 0 {
-		pins = "PB10";
-		function = "gpio_out";
-	};
 };
 
 &reg_usb1_vbus {
-	pinctrl-0 = <&usb1_vbus_pin_mk802>;
 	gpio = <&pio 1 10 GPIO_ACTIVE_HIGH>; /* PB10 */
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index 243319e98cf7..3ffae227bab3 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -241,11 +241,6 @@
 		drive-strength = <20>;
 	};
 
-	usb1_vbus_pin_olinuxino_m: usb1_vbus_pin at 0 {
-		pins = "PB10";
-		function = "gpio_out";
-	};
-
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
 		pins = "PG12";
 		function = "gpio_in";
@@ -259,7 +254,6 @@
 };
 
 &reg_usb1_vbus {
-	pinctrl-0 = <&usb1_vbus_pin_olinuxino_m>;
 	gpio = <&pio 1 10 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts b/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
index 034853d1c08f..1e713a42e34f 100644
--- a/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
@@ -109,15 +109,9 @@
 		function = "gpio_out";
 		drive-strength = <20>;
 	};
-
-	usb1_vbus_pin_r7: usb1_vbus_pin at 0 {
-		pins = "PG13";
-		function = "gpio_out";
-	};
 };
 
 &reg_usb1_vbus {
-	pinctrl-0 = <&usb1_vbus_pin_r7>;
 	gpio = <&pio 6 13 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts b/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
index 3f68ef5d92a0..d8bff29f1049 100644
--- a/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
@@ -61,8 +61,6 @@
 
 	leds {
 		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_wobo_i5>;
 
 		blue {
 			label = "a10s-wobo-i5:blue:usr";
@@ -73,8 +71,6 @@
 
 	reg_emac_3v3: emac-3v3 {
 		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&emac_power_pin_wobo>;
 		regulator-name = "emac-3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
@@ -143,21 +139,11 @@
 };
 
 &pio {
-	led_pins_wobo_i5: led_pins at 0 {
-		pins = "PB2";
-		function = "gpio_out";
-	};
-
 	mmc0_cd_pin_wobo_i5: mmc0_cd_pin at 0 {
 		pins = "PB3";
 		function = "gpio_in";
 		bias-pull-up;
 	};
-
-	emac_power_pin_wobo: emac_power_pin at 0 {
-		pins = "PA02";
-		function = "gpio_out";
-	};
 };
 
 &reg_dcdc2 {
diff --git a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
index 24ac6f167426..f6211c22e4dc 100644
--- a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
+++ b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
@@ -144,11 +144,6 @@
 		function = "gpio_in";
 		bias-pull-up;
 	};
-
-	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
-		pins = "PG1";
-		function = "gpio_in";
-	};
 };
 
 #include "axp209.dtsi"
@@ -202,7 +197,7 @@
 
 &usbphy {
 	pinctrl-names = "default";
-	pinctrl-0 = <&usb0_id_detect_pin>, <&usb0_vbus_detect_pin>;
+	pinctrl-0 = <&usb0_id_detect_pin>;
 	usb0_id_det-gpios = <&pio 6 2 GPIO_ACTIVE_HIGH>; /* PG2 */
 	usb0_vbus_det-gpios = <&pio 6 1 GPIO_ACTIVE_HIGH>; /* PG1 */
 	usb0_vbus-supply = <&reg_usb0_vbus>;
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
index aa4b34fd9126..0e107ff5cff0 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
@@ -135,26 +135,14 @@
 		function = "gpio_in";
 		bias-pull-down;
 	};
-
-	usb0_vbus_pin_olinuxinom: usb0_vbus_pin at 0 {
-		pins = "PG12";
-		function = "gpio_out";
-	};
-
-	usb1_vbus_pin_olinuxinom: usb1_vbus_pin at 0 {
-		pins = "PG11";
-		function = "gpio_out";
-	};
 };
 
 &reg_usb0_vbus {
-	pinctrl-0 = <&usb0_vbus_pin_olinuxinom>;
 	gpio = <&pio 6 12 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
 
 &reg_usb1_vbus {
-	pinctrl-0 = <&usb1_vbus_pin_olinuxinom>;
 	gpio = <&pio 6 11 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
index 49dcef1090d2..d963cac2a04d 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
@@ -230,11 +230,6 @@
 		function = "gpio_in";
 		bias-pull-down;
 	};
-
-	usb1_vbus_pin_olinuxino: usb1_vbus_pin at 0 {
-		pins = "PG11";
-		function = "gpio_out";
-	};
 };
 
 &reg_usb0_vbus {
@@ -243,7 +238,6 @@
 };
 
 &reg_usb1_vbus {
-	pinctrl-0 = <&usb1_vbus_pin_olinuxino>;
 	gpio = <&pio 6 11 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
index bfdd38d6bfcc..962ec29b1934 100644
--- a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
+++ b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
@@ -79,10 +79,6 @@
 	allwinner,pa-gpios = <&pio 6 3 GPIO_ACTIVE_HIGH>; /* PG3 */
 };
 
-&codec_pa_pin {
-	pins = "PG3";
-};
-
 &mmc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins_a>;
@@ -128,7 +124,3 @@
 	/* The P66 uses the uart pins as gpios */
 	status = "disabled";
 };
-
-&usb0_vbus_pin_a {
-	pins = "PB4";
-};
diff --git a/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts b/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
index c55b11a4d3c7..959dd94c7b79 100644
--- a/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
+++ b/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
@@ -79,8 +79,6 @@
 
 	mmc0_pwrseq: mmc0_pwrseq {
 		compatible = "mmc-pwrseq-simple";
-		pinctrl-names = "default";
-		pinctrl-0 = <&wifi_reg_on_pin_chip_pro>;
 		reset-gpios = <&pio 1 10 GPIO_ACTIVE_LOW>; /* PB10 */
 	};
 };
@@ -157,18 +155,6 @@
 	status = "okay";
 };
 
-&pio {
-	usb0_id_pin_chip_pro: usb0-id-pin at 0 {
-		pins = "PG2";
-		function = "gpio_in";
-	};
-
-	wifi_reg_on_pin_chip_pro: wifi-reg-on-pin at 0 {
-		pins = "PB10";
-		function = "gpio_out";
-	};
-};
-
 &pwm {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pwm0_pins>, <&pwm1_pins>;
@@ -253,8 +239,6 @@
 };
 
 &usbphy {
-	pinctrl-names = "default";
-	pinctrl-0 = <&usb0_id_pin_chip_pro>;
 	usb0_id_det-gpio = <&pio 6 2 GPIO_ACTIVE_HIGH>; /* PG2 */
 	usb0_vbus_power-supply = <&usb_power_supply>;
 	usb1_vbus-supply = <&reg_vcc5v0>;
diff --git a/arch/arm/boot/dts/sun5i-gr8-evb.dts b/arch/arm/boot/dts/sun5i-gr8-evb.dts
index e914915e73d7..5196aeff75aa 100644
--- a/arch/arm/boot/dts/sun5i-gr8-evb.dts
+++ b/arch/arm/boot/dts/sun5i-gr8-evb.dts
@@ -233,7 +233,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_gr8_evb>;
+	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
@@ -256,28 +256,6 @@
 	status = "okay";
 };
 
-&pio {
-	mmc0_cd_pin_gr8_evb: mmc0-cd-pin at 0 {
-		pins = "PG0";
-		function = "gpio_in";
-	};
-
-	usb0_id_pin_gr8_evb: usb0-id-pin at 0 {
-		pins = "PG2";
-		function = "gpio_in";
-	};
-
-	usb0_vbus_det_pin_gr8_evb: usb0-vbus-det-pin at 0 {
-		pins = "PG1";
-		function = "gpio_in";
-	};
-
-	usb1_vbus_pin_gr8_evb: usb1-vbus-pin at 0 {
-		pins = "PG13";
-		function = "gpio_out";
-	};
-};
-
 &pwm {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pwm0_pins>;
@@ -310,7 +288,6 @@
 };
 
 &reg_usb1_vbus {
-	pinctrl-0 = <&usb1_vbus_pin_gr8_evb>;
 	gpio = <&pio 6 13 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
@@ -356,8 +333,6 @@
 };
 
 &usbphy {
-	pinctrl-names = "default";
-	pinctrl-0 = <&usb0_id_pin_gr8_evb>, <&usb0_vbus_det_pin_gr8_evb>;
 	usb0_id_det-gpio = <&pio 6 2 GPIO_ACTIVE_HIGH>; /* PG2 */
 	usb0_vbus_det-gpio = <&pio 6 1 GPIO_ACTIVE_HIGH>; /* PG1 */
 	usb0_vbus_power-supply = <&usb_power_supply>;
diff --git a/arch/arm/boot/dts/sun5i-r8-chip.dts b/arch/arm/boot/dts/sun5i-r8-chip.dts
index 879a4b0f3bd5..c97e46e4bb45 100644
--- a/arch/arm/boot/dts/sun5i-r8-chip.dts
+++ b/arch/arm/boot/dts/sun5i-r8-chip.dts
@@ -79,8 +79,6 @@
 
 	mmc0_pwrseq: mmc0_pwrseq {
 		compatible = "mmc-pwrseq-simple";
-		pinctrl-names = "default";
-		pinctrl-0 = <&chip_wifi_reg_on_pin>;
 		reset-gpios = <&pio 2 19 GPIO_ACTIVE_LOW>; /* PC19 */
 	};
 
@@ -184,20 +182,6 @@
 };
 
 &pio {
-	chip_vbus_pin: chip_vbus_pin at 0 {
-		pins = "PB10";
-		function = "gpio_out";
-	};
-
-	chip_wifi_reg_on_pin: chip_wifi_reg_on_pin at 0 {
-	        pins = "PC19";
-	        function = "gpio_out";
-	};
-
-	chip_id_det_pin: chip_id_det_pin at 0 {
-		pins = "PG2";
-		function = "gpio_in";
-	};
 
 	chip_w1_pin: chip_w1_pin at 0 {
 		pins = "PD2";
@@ -260,7 +244,6 @@
 };
 
 &reg_usb0_vbus {
-	pinctrl-0 = <&chip_vbus_pin>;
 	vin-supply = <&reg_vcc5v0>;
 	gpio = <&pio 1 10 GPIO_ACTIVE_HIGH>; /* PB10 */
 	status = "okay";
@@ -303,8 +286,6 @@
 };
 
 &usbphy {
-	pinctrl-names = "default";
-	pinctrl-0 = <&chip_id_det_pin>;
 	status = "okay";
 
 	usb0_id_det-gpio = <&pio 6 2 GPIO_ACTIVE_HIGH>; /* PG2 */
diff --git a/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
index d2a2eb8b3f26..eafb362e3993 100644
--- a/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
@@ -63,8 +63,6 @@
 };
 
 &codec {
-	pinctrl-names = "default";
-	pinctrl-0 = <&codec_pa_pin>;
 	allwinner,pa-gpios = <&pio 6 10 GPIO_ACTIVE_HIGH>; /* PG10 */
 	status = "okay";
 };
@@ -96,8 +94,6 @@
 		reg = <0x40>;
 		interrupt-parent = <&pio>;
 		interrupts = <6 11 IRQ_TYPE_EDGE_FALLING>; /* EINT11 (PG11) */
-		pinctrl-names = "default";
-		pinctrl-0 = <&ts_power_pin>;
 		power-gpios = <&pio 1 3 GPIO_ACTIVE_HIGH>; /* PB3 */
 		/* Tablet dts must provide reg and compatible */
 		status = "disabled";
@@ -137,24 +133,12 @@
 };
 
 &pio {
-	codec_pa_pin: codec_pa_pin at 0 {
-		pins = "PG10";
-		function = "gpio_out";
-	};
-
 	mmc0_cd_pin: mmc0_cd_pin at 0 {
 		pins = "PG0";
 		function = "gpio_in";
 		bias-pull-up;
 	};
 
-	ts_power_pin: ts_power_pin {
-		pins = "PB3";
-		function = "gpio_out";
-		drive-strength = <10>;
-		bias-disable;
-	};
-
 	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
 		pins = "PG1";
 		function = "gpio_in";
@@ -166,11 +150,6 @@
 		function = "gpio_in";
 		bias-pull-up;
 	};
-
-	usb0_vbus_pin_a: usb0_vbus_pin at 0 {
-		pins = "PG12";
-		function = "gpio_out";
-	};
 };
 
 &reg_dcdc2 {
-- 
git-series 0.9.1
