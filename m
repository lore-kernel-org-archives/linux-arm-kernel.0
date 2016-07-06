From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  6 Jul 2016 17:10:47 +0800
Subject: [PATCH 6/9] ARM: dts: sun7i: bananapi-m1-plus: Unify suffix for board
 specific labels
In-Reply-To: <1467796250-22010-1-git-send-email-wens@csie.org>
References: <1467796250-22010-1-git-send-email-wens@csie.org>
Message-ID: <1467796250-22010-7-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dts file uses "bananapi" for some labels and "bananapim1plus" for
other. Use the shortened "bpi_m1p" suffix for all board specific labels.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
index edfb5b37939e..14fb463758e4 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
@@ -63,7 +63,7 @@
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_bananapi>;
+		pinctrl-0 = <&led_pins_bpi_m1p>;
 
 		green {
 			label = "bananapi-m1-plus:green:usr";
@@ -81,14 +81,14 @@
 	mmc3_pwrseq: mmc3_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		pinctrl-names = "default";
-		pinctrl-0 = <&mmc3_pwrseq_pin_bananapim1plus>;
+		pinctrl-0 = <&mmc3_pwrseq_pin_bpi_m1p>;
 		reset-gpios = <&pio 7 22 GPIO_ACTIVE_LOW>; /* PH22 WL-PMU-EN */
 	};
 
 	reg_gmac_3v3: gmac-3v3 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
-		pinctrl-0 = <&gmac_power_pin_bananapi>;
+		pinctrl-0 = <&gmac_power_pin_bpi_m1p>;
 		regulator-name = "gmac-3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
@@ -151,7 +151,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_bananapi>;
+	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_bpi_m1p>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 10 GPIO_ACTIVE_HIGH>; /* PH10 */
@@ -194,28 +194,28 @@
 };
 
 &pio {
-	gmac_power_pin_bananapi: gmac_power_pin at 0 {
+	gmac_power_pin_bpi_m1p: gmac_power_pin at 0 {
 		allwinner,pins = "PH23";
 		allwinner,function = "gpio_out";
 		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
-	led_pins_bananapi: led_pins at 0 {
+	led_pins_bpi_m1p: led_pins at 0 {
 		allwinner,pins = "PH24", "PG2";
 		allwinner,function = "gpio_out";
 		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
-	mmc0_cd_pin_bananapi: mmc0_cd_pin at 0 {
+	mmc0_cd_pin_bpi_m1p: mmc0_cd_pin at 0 {
 		allwinner,pins = "PH10";
 		allwinner,function = "gpio_in";
 		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
 	};
 
-	mmc3_pwrseq_pin_bananapim1plus: mmc3_pwrseq_pin at 0 {
+	mmc3_pwrseq_pin_bpi_m1p: mmc3_pwrseq_pin at 0 {
 		allwinner,pins = "PH22";
 		allwinner,function = "gpio_out";
 		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-- 
2.8.1
