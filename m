From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:30 +0100
Subject: [PATCH 29/77] ARM: dts: sun6i: Remove card detect pull-up
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <ad634fe042cbab93dd8bbad1ed868a96e3cb75b4.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boards usually have an external pull-up on the card-detect signal, so
there's no need to add another one.

This also removes a DTC warning.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun6i-a31-colombus.dts                 |  8 +-------
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts              | 11 +---------
 arch/arm/boot/dts/sun6i-a31-i7.dts                       | 10 +--------
 arch/arm/boot/dts/sun6i-a31-m9.dts                       | 10 +--------
 arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts         | 10 +--------
 arch/arm/boot/dts/sun6i-a31s-primo81.dts                 |  8 +-------
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts                 | 10 +--------
 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts         | 10 +--------
 arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts | 10 +--------
 arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi     |  8 +-------
 10 files changed, 10 insertions(+), 85 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31-colombus.dts b/arch/arm/boot/dts/sun6i-a31-colombus.dts
index 557d4a988d9a..21584c2f968f 100644
--- a/arch/arm/boot/dts/sun6i-a31-colombus.dts
+++ b/arch/arm/boot/dts/sun6i-a31-colombus.dts
@@ -114,7 +114,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_colombus>;
+	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v0>;
 	bus-width = <4>;
 	cd-gpios = <&pio 0 8 GPIO_ACTIVE_LOW>; /* PA8 */
@@ -126,12 +126,6 @@
 };
 
 &pio {
-	mmc0_cd_pin_colombus: mmc0_cd_pin at 0 {
-		pins = "PA8";
-		function = "gpio_in";
-		bias-pull-up;
-	};
-
 	i2c_lcd_pins: i2c_lcd_pin at 0 {
 		pins = "PA23", "PA24";
 		function = "gpio_out";
diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index a55291538c59..65b1b6e9180f 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -207,7 +207,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_hummingbird>;
+	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 0 8 GPIO_ACTIVE_LOW>; /* PA8 */
@@ -233,15 +233,6 @@
 	status = "okay";
 };
 
-&pio {
-	mmc0_cd_pin_hummingbird: mmc0_cd_pin at 0 {
-		pins = "PA8";
-		function = "gpio_in";
-		bias-pull-up;
-	};
-
-};
-
 &p2wi {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/sun6i-a31-i7.dts b/arch/arm/boot/dts/sun6i-a31-i7.dts
index 679f0fa7e50c..f3e95d08fefc 100644
--- a/arch/arm/boot/dts/sun6i-a31-i7.dts
+++ b/arch/arm/boot/dts/sun6i-a31-i7.dts
@@ -144,21 +144,13 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_i7>;
+	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 22 GPIO_ACTIVE_LOW>; /* PH22 */
 	status = "okay";
 };
 
-&pio {
-	mmc0_cd_pin_i7: mmc0_cd_pin at 0 {
-		pins = "PH22";
-		function = "gpio_in";
-		bias-pull-up;
-	};
-};
-
 &reg_usb1_vbus {
 	gpio = <&pio 2 27 GPIO_ACTIVE_HIGH>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/sun6i-a31-m9.dts b/arch/arm/boot/dts/sun6i-a31-m9.dts
index 87ae3031aa89..90fb1f603820 100644
--- a/arch/arm/boot/dts/sun6i-a31-m9.dts
+++ b/arch/arm/boot/dts/sun6i-a31-m9.dts
@@ -102,7 +102,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_m9>;
+	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 22 GPIO_ACTIVE_LOW>; /* PH22 */
@@ -122,14 +122,6 @@
 
 #include "axp22x.dtsi"
 
-&pio {
-	mmc0_cd_pin_m9: mmc0_cd_pin at 0 {
-		pins = "PH22";
-		function = "gpio_in";
-		bias-pull-up;
-	};
-};
-
 &reg_aldo1 {
 	regulator-min-microvolt = <3300000>;
 	regulator-max-microvolt = <3300000>;
diff --git a/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts b/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
index 0711f55945e0..3dcf44580839 100644
--- a/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
+++ b/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
@@ -102,7 +102,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_m9>;
+	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 22 GPIO_ACTIVE_LOW>; /* PH22 */
@@ -122,14 +122,6 @@
 
 #include "axp22x.dtsi"
 
-&pio {
-	mmc0_cd_pin_m9: mmc0_cd_pin at 0 {
-		pins = "PH22";
-		function = "gpio_in";
-		bias-pull-up;
-	};
-};
-
 &reg_aldo1 {
 	regulator-min-microvolt = <3300000>;
 	regulator-max-microvolt = <3300000>;
diff --git a/arch/arm/boot/dts/sun6i-a31s-primo81.dts b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
index dd6ede6a8377..55d60c68694e 100644
--- a/arch/arm/boot/dts/sun6i-a31s-primo81.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
@@ -146,7 +146,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_primo81>;
+	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 0 8 GPIO_ACTIVE_LOW>; /* PA8 */
@@ -159,12 +159,6 @@
 		function = "gpio_in";
 		bias-pull-up;
 	};
-
-	mmc0_cd_pin_primo81: mmc0_cd_pin at 0 {
-		pins = "PA8";
-		function = "gpio_in";
-		bias-pull-up;
-	};
 };
 
 &p2wi {
diff --git a/arch/arm/boot/dts/sun6i-a31s-sina31s.dts b/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
index 1b07a950cb45..02c9a90fe876 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
@@ -162,7 +162,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_sina31s>;
+	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 0 4 GPIO_ACTIVE_LOW>; /* PA4 */
@@ -173,14 +173,6 @@
 	status = "okay";
 };
 
-&pio {
-	mmc0_cd_pin_sina31s: mmc0_cd_pin at 0 {
-		pins = "PA4";
-		function = "gpio_in";
-		bias-pull-up;
-	};
-};
-
 &reg_dldo1 {
 	regulator-min-microvolt = <3300000>;
 	regulator-max-microvolt = <3300000>;
diff --git a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
index ea29af15125b..016b23831cec 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
@@ -113,7 +113,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_bpi_m2>;
+	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 0 4 GPIO_ACTIVE_LOW>; /* PA4 */
@@ -163,14 +163,6 @@
 	};
 };
 
-&pio {
-	mmc0_cd_pin_bpi_m2: mmc0_cd_pin at 0 {
-		pins = "PA4";
-		function = "gpio_in";
-		bias-pull-up;
-	};
-};
-
 #include "axp22x.dtsi"
 
 &reg_aldo1 {
diff --git a/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts b/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
index aab6c1720ef7..2d8dc4321b7b 100644
--- a/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
@@ -89,17 +89,9 @@
 	status = "okay";
 };
 
-&pio {
-	mmc0_cd_pin_bs1078v2: mmc0_cd_pin at 0 {
-		pins = "PA8";
-		function = "gpio_in";
-		bias-pull-up;
-	};
-};
-
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_bs1078v2>;
+	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v0>;
 	bus-width = <4>;
 	cd-gpios = <&pio 0 8 GPIO_ACTIVE_LOW>; /* PA8 */
diff --git a/arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi
index 4e72e4f3ef96..77f952b12188 100644
--- a/arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi
@@ -66,7 +66,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_e708_q1>;
+	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 0 8 GPIO_ACTIVE_LOW>; /* PA8 */
@@ -74,12 +74,6 @@
 };
 
 &pio {
-	mmc0_cd_pin_e708_q1: mmc0_cd_pin at 0 {
-		pins = "PA8";
-		function = "gpio_in";
-		bias-pull-up;
-	};
-
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
 		pins = "PA15";
 		function = "gpio_in";
-- 
git-series 0.9.1
