From: joonas.kylmala@iki.fi (=?UTF-8?q?Joonas=20Kylm=C3=A4l=C3=A4?=)
Date: Thu,  8 Feb 2018 14:01:41 +0200
Subject: [PATCH v3 4/4] ARM: dts: sunxi: h3-h5: rename mmc0_pins_a and
 mmc1_pins_a
In-Reply-To: <20180208120141.15780-1-joonas.kylmala@iki.fi>
References: <20180208120141.15780-1-joonas.kylmala@iki.fi>
Message-ID: <20180208120141.15780-5-joonas.kylmala@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is only one pinctrl configuration for mmc0 and mmc1 so let's
drop the _a suffix from both of them.

Signed-off-by: Joonas Kylm?l? <joonas.kylmala@iki.fi>
---
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 2 +-
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
index 73978853bb4c..f868cf197c8e 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
@@ -134,7 +134,7 @@
 	};
 };
 
-&mmc1_pins_a {
+&mmc1_pins {
 	bias-pull-up;
 };
 
diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index b4a4b3cb6c4e..7741166d34d8 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -142,7 +142,7 @@
 			/* compatible and clocks are in per SoC .dtsi file */
 			reg = <0x01c0f000 0x1000>;
 			pinctrl-names = "default";
-			pinctrl-0 = <&mmc0_pins_a>;
+			pinctrl-0 = <&mmc0_pins>;
 			resets = <&ccu RST_BUS_MMC0>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
@@ -155,7 +155,7 @@
 			/* compatible and clocks are in per SoC .dtsi file */
 			reg = <0x01c10000 0x1000>;
 			pinctrl-names = "default";
-			pinctrl-0 = <&mmc1_pins_a>;
+			pinctrl-0 = <&mmc1_pins>;
 			resets = <&ccu RST_BUS_MMC1>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
@@ -352,7 +352,7 @@
 				function = "i2c2";
 			};
 
-			mmc0_pins_a: mmc0 {
+			mmc0_pins: mmc0 {
 				pins = "PF0", "PF1", "PF2", "PF3",
 				       "PF4", "PF5";
 				function = "mmc0";
@@ -360,7 +360,7 @@
 				bias-pull-up;
 			};
 
-			mmc1_pins_a: mmc1 {
+			mmc1_pins: mmc1 {
 				pins = "PG0", "PG1", "PG2", "PG3",
 				       "PG4", "PG5";
 				function = "mmc1";
-- 
2.11.0
