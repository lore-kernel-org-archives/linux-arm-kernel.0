From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  5 Oct 2017 12:49:50 +0200
Subject: [PATCH 15/20] ARM: dts: sun9i: Rename pinctrl nodes to avoid warnings
In-Reply-To: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
Message-ID: <63d98e5495bcfb55d4cce98bcec629dfd3f93cd3.1507198895.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our pinctrl node names were containing unit-adresses without a reg
property, resulting in a warning. Change the names for our new convention.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts |  2 +-
 arch/arm/boot/dts/sun9i-a80-optimus.dts     |  2 +-
 arch/arm/boot/dts/sun9i-a80.dtsi            | 12 ++++++------
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
index 3741ac71c3d6..1a09a35d266a 100644
--- a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
+++ b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
@@ -427,6 +427,6 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_ph_pins>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index 85f1ad670310..cc9e6a88f2a2 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -492,7 +492,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_ph_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index 190d1f9df2d4..f9cb701f29b0 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -489,12 +489,12 @@
 			#size-cells = <0>;
 			#gpio-cells = <3>;
 
-			i2c3_pins_a: i2c3 at 0 {
+			i2c3_pins: i2c3-pins {
 				pins = "PG10", "PG11";
 				function = "i2c3";
 			};
 
-			mmc0_pins: mmc0 {
+			mmc0_pins: mmc0-pins {
 				pins = "PF0", "PF1" ,"PF2", "PF3",
 				       "PF4", "PF5";
 				function = "mmc0";
@@ -502,7 +502,7 @@
 				bias-pull-up;
 			};
 
-			mmc1_pins: mmc1 {
+			mmc1_pins: mmc1-pins {
 				pins = "PG0", "PG1" ,"PG2", "PG3",
 						 "PG4", "PG5";
 				function = "mmc1";
@@ -510,7 +510,7 @@
 				bias-pull-up;
 			};
 
-			mmc2_8bit_pins: mmc2_8bit {
+			mmc2_8bit_pins: mmc2-8bit-pins {
 				pins = "PC6", "PC7", "PC8", "PC9",
 				       "PC10", "PC11", "PC12",
 				       "PC13", "PC14", "PC15",
@@ -520,12 +520,12 @@
 				bias-pull-up;
 			};
 
-			uart0_pins_a: uart0 at 0 {
+			uart0_ph_pins: uart0-ph-pins {
 				pins = "PH12", "PH13";
 				function = "uart0";
 			};
 
-			uart4_pins_a: uart4 at 0 {
+			uart4_pins: uart4-pins {
 				pins = "PG12", "PG13", "PG14", "PG15";
 				function = "uart4";
 			};
-- 
git-series 0.9.1
