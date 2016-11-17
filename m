From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 17 Nov 2016 17:34:38 +0800
Subject: [PATCH] ARM: dts: sunxi: Explicitly enable pull-ups for MMC pins
Message-ID: <20161117093438.17988-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the past, all the MMC pins had

	allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;

which was actually a no-op. We were relying on U-boot to set the bias
pull up for us. These properties were removed as part of the fix up to
actually support no bias on the pins. During the transition some boards
experienced regular MMC time-outs during normal operation, while others
completely failed to initialize the SD card.

Given that MMC starts in open-drain mode and the pull-ups are required,
it's best to enable it for all the pin settings.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun4i-a10.dtsi     | 1 +
 arch/arm/boot/dts/sun5i.dtsi         | 1 +
 arch/arm/boot/dts/sun6i-a31.dtsi     | 4 ++++
 arch/arm/boot/dts/sun7i-a20.dtsi     | 2 ++
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 3 +++
 arch/arm/boot/dts/sun8i-a83t.dtsi    | 1 +
 arch/arm/boot/dts/sun8i-h3.dtsi      | 3 +++
 arch/arm/boot/dts/sun9i-a80.dtsi     | 3 +++
 8 files changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index dae838e4dd9e..ba20b48c0702 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -1023,6 +1023,7 @@
 				       "PF3", "PF4", "PF5";
 				function = "mmc0";
 				drive-strength = <30>;
+				bias-pull-up;
 			};
 
 			mmc0_cd_pin_reference_design: mmc0_cd_pin at 0 {
diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 7ab6b336533e..54170147040f 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -582,6 +582,7 @@
 				       "PF4", "PF5";
 				function = "mmc0";
 				drive-strength = <30>;
+				bias-pull-up;
 			};
 
 			mmc2_pins_a: mmc2 at 0 {
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 7ea1116c7c88..20a0331ddfb5 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -547,6 +547,7 @@
 						 "PF3", "PF4", "PF5";
 				function = "mmc0";
 				drive-strength = <30>;
+				bias-pull-up;
 			};
 
 			mmc1_pins_a: mmc1 at 0 {
@@ -554,6 +555,7 @@
 						 "PG4", "PG5";
 				function = "mmc1";
 				drive-strength = <30>;
+				bias-pull-up;
 			};
 
 			mmc2_pins_a: mmc2 at 0 {
@@ -571,6 +573,7 @@
 						 "PC24";
 				function = "mmc2";
 				drive-strength = <30>;
+				bias-pull-up;
 			};
 
 			mmc3_8bit_emmc_pins: mmc3 at 1 {
@@ -580,6 +583,7 @@
 						 "PC24";
 				function = "mmc3";
 				drive-strength = <40>;
+				bias-pull-up;
 			};
 
 			uart0_pins_a: uart0 at 0 {
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 34d613b0dd73..a1ee4197129a 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -1179,6 +1179,7 @@
 				       "PF3", "PF4", "PF5";
 				function = "mmc0";
 				drive-strength = <30>;
+				bias-pull-up;
 			};
 
 			mmc0_cd_pin_reference_design: mmc0_cd_pin at 0 {
@@ -1200,6 +1201,7 @@
 				       "PI7", "PI8", "PI9";
 				function = "mmc3";
 				drive-strength = <30>;
+				bias-pull-up;
 			};
 
 			ps20_pins_a: ps20 at 0 {
diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index ecb49a5a7615..bc3e936edfcf 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -293,6 +293,7 @@
 				       "PF3", "PF4", "PF5";
 				function = "mmc0";
 				drive-strength = <30>;
+				bias-pull-up;
 			};
 
 			mmc1_pins_a: mmc1 at 0 {
@@ -300,6 +301,7 @@
 				       "PG3", "PG4", "PG5";
 				function = "mmc1";
 				drive-strength = <30>;
+				bias-pull-up;
 			};
 
 			mmc2_8bit_pins: mmc2_8bit {
@@ -309,6 +311,7 @@
 				       "PC15", "PC16";
 				function = "mmc2";
 				drive-strength = <30>;
+				bias-pull-up;
 			};
 
 			pwm0_pins: pwm0 {
diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 656cdb5f7a88..79eaa7139f43 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -171,6 +171,7 @@
 				       "PF3", "PF4", "PF5";
 				function = "mmc0";
 				drive-strength = <30>;
+				bias-pull-up;
 			};
 
 			uart0_pins_a: uart0 at 0 {
diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 416b825ddb9f..fca66bf2dec5 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -348,6 +348,7 @@
 				       "PF4", "PF5";
 				function = "mmc0";
 				drive-strength = <30>;
+				bias-pull-up;
 			};
 
 			mmc0_cd_pin: mmc0_cd_pin at 0 {
@@ -361,6 +362,7 @@
 				       "PG4", "PG5";
 				function = "mmc1";
 				drive-strength = <30>;
+				bias-pull-up;
 			};
 
 			mmc2_8bit_pins: mmc2_8bit {
@@ -370,6 +372,7 @@
 				       "PC15", "PC16";
 				function = "mmc2";
 				drive-strength = <30>;
+				bias-pull-up;
 			};
 
 			spi0_pins: spi0 {
diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index b97db1df0803..7231d2c90dde 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -696,6 +696,7 @@
 				       "PF4", "PF5";
 				function = "mmc0";
 				drive-strength = <30>;
+				bias-pull-up;
 			};
 
 			mmc1_pins: mmc1 {
@@ -703,6 +704,7 @@
 						 "PG4", "PG5";
 				function = "mmc1";
 				drive-strength = <30>;
+				bias-pull-up;
 			};
 
 			mmc2_8bit_pins: mmc2_8bit {
@@ -712,6 +714,7 @@
 				       "PC16";
 				function = "mmc2";
 				drive-strength = <30>;
+				bias-pull-up;
 			};
 
 			uart0_pins_a: uart0 at 0 {
-- 
2.10.2
