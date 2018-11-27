From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:31 +0100
Subject: [PATCH 30/77] ARM: dts: sun6i: Remove redundant MMC pinmux tuning
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <f0fedb9e722eb18306d0a33e7997f90910417b17.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some boards override the MMC pin muxing settings in order to enable the
pull-ups and change the drive strength to a value higher than the default.

While this was needed in the earlier days, this is now the default setting
for those pins, and therefore we don't need those board-specific settings
anymore.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun6i-a31-colombus.dts                 | 4 ----
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts              | 5 -----
 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts         | 8 --------
 arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts | 4 ----
 4 files changed, 21 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31-colombus.dts b/arch/arm/boot/dts/sun6i-a31-colombus.dts
index 21584c2f968f..f9c4169a875d 100644
--- a/arch/arm/boot/dts/sun6i-a31-colombus.dts
+++ b/arch/arm/boot/dts/sun6i-a31-colombus.dts
@@ -121,10 +121,6 @@
 	status = "okay";
 };
 
-&mmc0_pins_a {
-	bias-pull-up;
-};
-
 &pio {
 	i2c_lcd_pins: i2c_lcd_pin at 0 {
 		pins = "PA23", "PA24";
diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index 65b1b6e9180f..f38413fd9906 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -214,11 +214,6 @@
 	status = "okay";
 };
 
-&mmc0_pins_a {
-	/* external pull-ups missing for some pins */
-	bias-pull-up;
-};
-
 &mmc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins_a>;
diff --git a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
index 016b23831cec..14e27e81ddf8 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
@@ -120,10 +120,6 @@
 	status = "okay";
 };
 
-&mmc0_pins_a {
-	bias-pull-up;
-};
-
 &mmc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins_a>;
@@ -142,10 +138,6 @@
 	};
 };
 
-&mmc2_pins_a {
-	bias-pull-up;
-};
-
 &ohci0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts b/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
index 2d8dc4321b7b..153e40d6f4c5 100644
--- a/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
@@ -98,10 +98,6 @@
 	status = "okay";
 };
 
-&mmc0_pins_a {
-	bias-pull-up;
-};
-
 &p2wi {
 	status = "okay";
 
-- 
git-series 0.9.1
