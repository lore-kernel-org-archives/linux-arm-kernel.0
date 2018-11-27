From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:46:02 +0100
Subject: [PATCH 61/77] ARM: dts: sun8i: a23/a33: Reorder the pin groups
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <14f95be8c3b94b4adcb06627556a84a78733b3e7.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pin groups are supposed to be in alphabetical order, and they aren't.
Fix this.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 52 ++++++++++++++---------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index b76b88a45e99..43978625df21 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -298,19 +298,27 @@
 			#interrupt-cells = <3>;
 			#gpio-cells = <3>;
 
-			uart0_pins_a: uart0 at 0 {
-				pins = "PF2", "PF4";
-				function = "uart0";
+			i2c0_pins_a: i2c0 at 0 {
+				pins = "PH2", "PH3";
+				function = "i2c0";
 			};
 
-			uart1_pins_a: uart1 at 0 {
-				pins = "PG6", "PG7";
-				function = "uart1";
+			i2c1_pins_a: i2c1 at 0 {
+				pins = "PH4", "PH5";
+				function = "i2c1";
 			};
 
-			uart1_pins_cts_rts_a: uart1-cts-rts at 0 {
-				pins = "PG8", "PG9";
-				function = "uart1";
+			i2c2_pins_a: i2c2 at 0 {
+				pins = "PE12", "PE13";
+				function = "i2c2";
+			};
+
+			lcd_rgb666_pins: lcd-rgb666 at 0 {
+				pins = "PD2", "PD3", "PD4", "PD5", "PD6", "PD7",
+				       "PD10", "PD11", "PD12", "PD13", "PD14", "PD15",
+				       "PD18", "PD19", "PD20", "PD21", "PD22", "PD23",
+				       "PD24", "PD25", "PD26", "PD27";
+				function = "lcd0";
 			};
 
 			mmc0_pins_a: mmc0 at 0 {
@@ -375,27 +383,19 @@
 				function = "pwm0";
 			};
 
-			i2c0_pins_a: i2c0 at 0 {
-				pins = "PH2", "PH3";
-				function = "i2c0";
-			};
-
-			i2c1_pins_a: i2c1 at 0 {
-				pins = "PH4", "PH5";
-				function = "i2c1";
+			uart0_pins_a: uart0 at 0 {
+				pins = "PF2", "PF4";
+				function = "uart0";
 			};
 
-			i2c2_pins_a: i2c2 at 0 {
-				pins = "PE12", "PE13";
-				function = "i2c2";
+			uart1_pins_a: uart1 at 0 {
+				pins = "PG6", "PG7";
+				function = "uart1";
 			};
 
-			lcd_rgb666_pins: lcd-rgb666 at 0 {
-				pins = "PD2", "PD3", "PD4", "PD5", "PD6", "PD7",
-				       "PD10", "PD11", "PD12", "PD13", "PD14", "PD15",
-				       "PD18", "PD19", "PD20", "PD21", "PD22", "PD23",
-				       "PD24", "PD25", "PD26", "PD27";
-				function = "lcd0";
+			uart1_pins_cts_rts_a: uart1-cts-rts at 0 {
+				pins = "PG8", "PG9";
+				function = "uart1";
 			};
 		};
 
-- 
git-series 0.9.1
