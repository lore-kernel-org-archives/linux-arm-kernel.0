From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:46:00 +0100
Subject: [PATCH 59/77] ARM: dts: sun8i: a23/a33: Remove all useless pinctrl
 nodes
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <4f58a58f6076f6a454c98f7bf67001ba2e4e024b.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gpio pinctrl nodes are redundant and as such useless most of the times.
Since they will also generate warnings in DTC, we can simply remove most of
them.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts |  9 +-----
 arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts |  9 +-----
 arch/arm/boot/dts/sun8i-r16-parrot.dts                | 23 +------------
 arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi  |  7 +----
 4 files changed, 1 insertion(+), 47 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts b/arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts
index 61a4702b63c1..4a318faa462a 100644
--- a/arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts
+++ b/arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts
@@ -54,8 +54,6 @@
 
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
-		pinctrl-names = "default";
-		pinctrl-0 = <&wifi_pwrseq_pin_mid2407>;
 		reset-gpios = <&r_pio 0 6 GPIO_ACTIVE_LOW>; /* PL6 */
 		/* The esp8089 needs 200 ms after driving wifi-en high */
 		post-power-on-delay-ms = <200>;
@@ -85,13 +83,6 @@
 	};
 };
 
-&r_pio {
-	wifi_pwrseq_pin_mid2407: wifi_pwrseq_pin at 0 {
-		pins = "PL6";
-		function = "gpio_out";
-	};
-};
-
 &touchscreen {
 	reg = <0x40>;
 	compatible = "silead,gsl1680";
diff --git a/arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts b/arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts
index 29a032164e3d..22e153d50523 100644
--- a/arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts
+++ b/arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts
@@ -54,8 +54,6 @@
 
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
-		pinctrl-names = "default";
-		pinctrl-0 = <&wifi_pwrseq_pin_mid2809>;
 		reset-gpios = <&r_pio 0 6 GPIO_ACTIVE_LOW>; /* PL6 */
 		/* The esp8089 needs 200 ms after driving wifi-en high */
 		post-power-on-delay-ms = <200>;
@@ -78,13 +76,6 @@
 	};
 };
 
-&r_pio {
-	wifi_pwrseq_pin_mid2809: wifi_pwrseq_pin at 0 {
-		pins = "PL6";
-		function = "gpio_out";
-	};
-};
-
 &touchscreen {
 	reg = <0x40>;
 	compatible = "silead,gsl3670";
diff --git a/arch/arm/boot/dts/sun8i-r16-parrot.dts b/arch/arm/boot/dts/sun8i-r16-parrot.dts
index 5d93a2711dc3..16b38bd7a779 100644
--- a/arch/arm/boot/dts/sun8i-r16-parrot.dts
+++ b/arch/arm/boot/dts/sun8i-r16-parrot.dts
@@ -63,8 +63,6 @@
 
 	leds {
 		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_parrot>;
 
 		led1 {
 			label = "parrot:led1:usr";
@@ -138,7 +136,7 @@
 
 &mmc1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>, <&wifi_reset_pin_parrot>;
+	pinctrl-0 = <&mmc1_pins_a>;
 	vmmc-supply = <&reg_aldo1>;
 	mmc-pwrseq = <&wifi_pwrseq>;
 	bus-width = <4>;
@@ -167,28 +165,11 @@
 		bias-pull-up;
 	};
 
-	led_pins_parrot: led_pins at 0 {
-		pins = "PE16", "PE17";
-		function = "gpio_out";
-	};
-
 	usb0_id_det: usb0_id_detect_pin at 0 {
 		pins = "PD10";
 		function = "gpio_in";
 		bias-pull-up;
 	};
-
-	usb1_vbus_pin_parrot: usb1_vbus_pin at 0 {
-		pins = "PD12";
-		function = "gpio_out";
-	};
-};
-
-&r_pio {
-	wifi_reset_pin_parrot: wifi_reset_pin at 0 {
-		pins = "PL6";
-		function = "gpio_out";
-	};
 };
 
 &r_rsb {
@@ -314,8 +295,6 @@
 };
 
 &reg_usb1_vbus {
-	pinctrl-names = "default";
-	pinctrl-0 = <&usb1_vbus_pin_parrot>;
 	gpio = <&pio 3 12 GPIO_ACTIVE_HIGH>; /* PD12 */
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
index 5e8a95af89b8..c5f0f2e627bf 100644
--- a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
@@ -73,8 +73,6 @@
 		reg = <0x40>;
 		interrupt-parent = <&pio>;
 		interrupts = <1 5 IRQ_TYPE_EDGE_FALLING>; /* PB5 */
-		pinctrl-names = "default";
-		pinctrl-0 = <&ts_power_pin>;
 		power-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
 		/* Tablet dts must provide reg and compatible */
 		status = "disabled";
@@ -97,11 +95,6 @@
 		bias-pull-up;
 	};
 
-	ts_power_pin: ts_power_pin at 0 {
-		pins = "PH1";
-		function = "gpio_out";
-	};
-
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
 		pins = "PH8";
 		function = "gpio_in";
-- 
git-series 0.9.1
