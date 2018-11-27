From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:33 +0100
Subject: [PATCH 32/77] ARM: dts: sun6i: Remove underscores from nodes names
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <23da5b1409c3d509c34391bb82863aaf7ff39478.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some GPIO pinctrl nodes cannot be easily removed, because they would also
change the pin configuration, for example to add a pull resistor or change
the current delivered by the pin.

Those nodes still have underscores and unit-addresses in their node names
in our DTs, so adjust their name to remove the warnings. Use that occasion
to also fix some poorly chosen node-names.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun6i-a31-colombus.dts             | 2 +-
 arch/arm/boot/dts/sun6i-a31s-primo81.dts             | 2 +-
 arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31-colombus.dts b/arch/arm/boot/dts/sun6i-a31-colombus.dts
index d7a19664bae9..99f25b2d5189 100644
--- a/arch/arm/boot/dts/sun6i-a31-colombus.dts
+++ b/arch/arm/boot/dts/sun6i-a31-colombus.dts
@@ -122,7 +122,7 @@
 };
 
 &pio {
-	i2c_lcd_pins: i2c_lcd_pin at 0 {
+	i2c_lcd_pins: i2c-lcd-pins {
 		pins = "PA23", "PA24";
 		function = "gpio_out";
 		bias-pull-up;
diff --git a/arch/arm/boot/dts/sun6i-a31s-primo81.dts b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
index 645d405fcfcc..ba378affd497 100644
--- a/arch/arm/boot/dts/sun6i-a31s-primo81.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
@@ -154,7 +154,7 @@
 };
 
 &pio {
-	mma8452_int_primo81: mma8452_int_pin at 0 {
+	mma8452_int_primo81: mma8452-int-pin {
 		pins = "PA9";
 		function = "gpio_in";
 		bias-pull-up;
diff --git a/arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi
index a506d740dee3..86143de21c22 100644
--- a/arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi
@@ -74,7 +74,7 @@
 };
 
 &pio {
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+	usb0_id_detect_pin: usb0-id-detect-pin {
 		pins = "PA15";
 		function = "gpio_in";
 		bias-pull-up;
-- 
git-series 0.9.1
