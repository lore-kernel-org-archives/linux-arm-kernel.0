From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:46:11 +0100
Subject: [PATCH 70/77] ARM: dts: sun8i: v3s: Change pinctrl nodes to avoid
 warning
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <d33aaf8256329425130a21720a2e39a8d3afb85a.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All our pinctrl nodes were using a node name convention with a unit-address
to differentiate the different muxing options. However, since those nodes
didn't have a reg property, they were generating warnings in DTC.

In order to accomodate for this, convert the old nodes to the syntax we've
been using for the new SoCs, including removing the letter suffix of the
node labels to the bank of those pins to make things more readable.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts |  4 ++--
 arch/arm/boot/dts/sun8i-v3s.dtsi              | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts
index 387fc2aa546d..333df90e8037 100644
--- a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts
+++ b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts
@@ -78,7 +78,7 @@
 };
 
 &mmc0 {
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	pinctrl-names = "default";
 	broken-cd;
 	bus-width = <4>;
@@ -87,7 +87,7 @@
 };
 
 &uart0 {
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	pinctrl-names = "default";
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index 443b083c6adc..92fcb756a08a 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -292,17 +292,17 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
-			i2c0_pins: i2c0 {
+			i2c0_pins: i2c0-pins {
 				pins = "PB6", "PB7";
 				function = "i2c0";
 			};
 
-			uart0_pins_a: uart0 at 0 {
+			uart0_pb_pins: uart0-pb-pins {
 				pins = "PB8", "PB9";
 				function = "uart0";
 			};
 
-			mmc0_pins_a: mmc0 at 0 {
+			mmc0_pins: mmc0-pins {
 				pins = "PF0", "PF1", "PF2", "PF3",
 				       "PF4", "PF5";
 				function = "mmc0";
@@ -310,7 +310,7 @@
 				bias-pull-up;
 			};
 
-			mmc1_pins: mmc1 {
+			mmc1_pins: mmc1-pins {
 				pins = "PG0", "PG1", "PG2", "PG3",
 				       "PG4", "PG5";
 				function = "mmc1";
@@ -318,7 +318,7 @@
 				bias-pull-up;
 			};
 
-			spi0_pins: spi0 {
+			spi0_pins: spi0-pins {
 				pins = "PC0", "PC1", "PC2", "PC3";
 				function = "spi0";
 			};
-- 
git-series 0.9.1
