From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:32 +0100
Subject: [PATCH 31/77] ARM: dts: sun6i: Change pinctrl nodes to avoid warning
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <288a28fa42f816b4f255a316569e7f750c3e73ac.1543321707.git-series.maxime.ripard@bootlin.com>
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
 arch/arm/boot/dts/sun6i-a31-app4-evb1.dts                |  2 +-
 arch/arm/boot/dts/sun6i-a31-colombus.dts                 | 12 +--
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts              | 16 ++--
 arch/arm/boot/dts/sun6i-a31-i7.dts                       | 10 +--
 arch/arm/boot/dts/sun6i-a31-m9.dts                       |  8 +-
 arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts         |  8 +-
 arch/arm/boot/dts/sun6i-a31.dtsi                         | 34 ++++-----
 arch/arm/boot/dts/sun6i-a31s-cs908.dts                   |  6 +-
 arch/arm/boot/dts/sun6i-a31s-inet-q972.dts               |  2 +-
 arch/arm/boot/dts/sun6i-a31s-primo81.dts                 |  8 +-
 arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi           |  2 +-
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts                 |  8 +-
 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts         | 10 +--
 arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts |  8 +-
 arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi     |  2 +-
 15 files changed, 68 insertions(+), 68 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts b/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
index f26b84b61daf..32d22025ac99 100644
--- a/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
+++ b/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
@@ -72,7 +72,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_ph_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun6i-a31-colombus.dts b/arch/arm/boot/dts/sun6i-a31-colombus.dts
index f9c4169a875d..d7a19664bae9 100644
--- a/arch/arm/boot/dts/sun6i-a31-colombus.dts
+++ b/arch/arm/boot/dts/sun6i-a31-colombus.dts
@@ -77,7 +77,7 @@
 
 &gmac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gmac_pins_rgmii_a>;
+	pinctrl-0 = <&gmac_rgmii_pins>;
 	phy = <&phy1>;
 	phy-mode = "rgmii";
 	status = "okay";
@@ -89,19 +89,19 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "fail";
 };
 
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 };
 
 &i2c2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins_a>;
+	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 
 	mma8452: mma8452 at 1d {
@@ -114,7 +114,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v0>;
 	bus-width = <4>;
 	cd-gpios = <&pio 0 8 GPIO_ACTIVE_LOW>; /* PA8 */
@@ -136,7 +136,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_ph_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index f38413fd9906..5b4d89d2989a 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -152,7 +152,7 @@
 
 &gmac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gmac_pins_rgmii_a>;
+	pinctrl-0 = <&gmac_rgmii_pins>;
 	phy = <&phy1>;
 	phy-mode = "rgmii";
 	snps,reset-gpio = <&pio 0 21 GPIO_ACTIVE_HIGH>;
@@ -177,20 +177,20 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	/* pull-ups and devices require AXP221 DLDO3 */
 	status = "failed";
 };
 
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 };
 
 &i2c2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins_a>;
+	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 
 	pcf8563: rtc at 51 {
@@ -201,13 +201,13 @@
 
 &ir {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir_pins_a>;
+	pinctrl-0 = <&s_ir_rx_pin>;
 	status = "okay";
 };
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 0 8 GPIO_ACTIVE_LOW>; /* PA8 */
@@ -216,7 +216,7 @@
 
 &mmc1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
+	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&reg_aldo1>;
 	mmc-pwrseq = <&wifi_pwrseq>;
 	bus-width = <4>;
@@ -323,7 +323,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_ph_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun6i-a31-i7.dts b/arch/arm/boot/dts/sun6i-a31-i7.dts
index f3e95d08fefc..6f2bba8b7dd0 100644
--- a/arch/arm/boot/dts/sun6i-a31-i7.dts
+++ b/arch/arm/boot/dts/sun6i-a31-i7.dts
@@ -116,7 +116,7 @@
 
 &gmac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gmac_pins_mii_a>;
+	pinctrl-0 = <&gmac_mii_pins>;
 	phy = <&phy1>;
 	phy-mode = "mii";
 	status = "okay";
@@ -138,13 +138,13 @@
 
 &ir {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir_pins_a>;
+	pinctrl-0 = <&s_ir_rx_pin>;
 	status = "okay";
 };
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 22 GPIO_ACTIVE_LOW>; /* PH22 */
@@ -158,7 +158,7 @@
 
 &spdif {
 	pinctrl-names = "default";
-	pinctrl-0 = <&spdif_pins_a>;
+	pinctrl-0 = <&spdif_tx_pin>;
 	spdif-out = "okay";
 	status = "okay";
 };
@@ -169,7 +169,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_ph_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun6i-a31-m9.dts b/arch/arm/boot/dts/sun6i-a31-m9.dts
index 90fb1f603820..b65aa90a9167 100644
--- a/arch/arm/boot/dts/sun6i-a31-m9.dts
+++ b/arch/arm/boot/dts/sun6i-a31-m9.dts
@@ -83,7 +83,7 @@
 
 &gmac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gmac_pins_mii_a>;
+	pinctrl-0 = <&gmac_mii_pins>;
 	phy = <&phy1>;
 	phy-mode = "mii";
 	phy-supply = <&reg_dldo1>;
@@ -96,13 +96,13 @@
 
 &ir {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir_pins_a>;
+	pinctrl-0 = <&s_ir_rx_pin>;
 	status = "okay";
 };
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 22 GPIO_ACTIVE_LOW>; /* PH22 */
@@ -201,7 +201,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_ph_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts b/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
index 3dcf44580839..c3a85aac44d5 100644
--- a/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
+++ b/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
@@ -83,7 +83,7 @@
 
 &gmac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gmac_pins_mii_a>;
+	pinctrl-0 = <&gmac_mii_pins>;
 	phy = <&phy1>;
 	phy-mode = "mii";
 	phy-supply = <&reg_dldo1>;
@@ -96,13 +96,13 @@
 
 &ir {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir_pins_a>;
+	pinctrl-0 = <&s_ir_rx_pin>;
 	status = "okay";
 };
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 22 GPIO_ACTIVE_LOW>; /* PH22 */
@@ -201,7 +201,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_ph_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index c5fd97b88b90..596ab854da2c 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -604,7 +604,7 @@
 			#interrupt-cells = <3>;
 			#gpio-cells = <3>;
 
-			gmac_pins_gmii_a: gmac_gmii at 0 {
+			gmac_gmii_pins: gmac-gmii-pins {
 				pins = "PA0", "PA1", "PA2", "PA3",
 						"PA4", "PA5", "PA6", "PA7",
 						"PA8", "PA9", "PA10", "PA11",
@@ -620,7 +620,7 @@
 				drive-strength = <30>;
 			};
 
-			gmac_pins_mii_a: gmac_mii at 0 {
+			gmac_mii_pins: gmac-mii-pins {
 				pins = "PA0", "PA1", "PA2", "PA3",
 						"PA8", "PA9", "PA11",
 						"PA12", "PA13", "PA14", "PA19",
@@ -629,7 +629,7 @@
 				function = "gmac";
 			};
 
-			gmac_pins_rgmii_a: gmac_rgmii at 0 {
+			gmac_rgmii_pins: gmac-rgmii-pins {
 				pins = "PA0", "PA1", "PA2", "PA3",
 						"PA9", "PA10", "PA11",
 						"PA12", "PA13", "PA14", "PA19",
@@ -642,22 +642,22 @@
 				drive-strength = <40>;
 			};
 
-			i2c0_pins_a: i2c0 at 0 {
+			i2c0_pins: i2c0-pins {
 				pins = "PH14", "PH15";
 				function = "i2c0";
 			};
 
-			i2c1_pins_a: i2c1 at 0 {
+			i2c1_pins: i2c1-pins {
 				pins = "PH16", "PH17";
 				function = "i2c1";
 			};
 
-			i2c2_pins_a: i2c2 at 0 {
+			i2c2_pins: i2c2-pins {
 				pins = "PH18", "PH19";
 				function = "i2c2";
 			};
 
-			lcd0_rgb888_pins: lcd0_rgb888 {
+			lcd0_rgb888_pins: lcd0-rgb888-pins {
 				pins = "PD0", "PD1", "PD2", "PD3",
 						 "PD4", "PD5", "PD6", "PD7",
 						 "PD8", "PD9", "PD10", "PD11",
@@ -668,7 +668,7 @@
 				function = "lcd0";
 			};
 
-			mmc0_pins_a: mmc0 at 0 {
+			mmc0_pins: mmc0-pins {
 				pins = "PF0", "PF1", "PF2",
 						 "PF3", "PF4", "PF5";
 				function = "mmc0";
@@ -676,7 +676,7 @@
 				bias-pull-up;
 			};
 
-			mmc1_pins_a: mmc1 at 0 {
+			mmc1_pins: mmc1-pins {
 				pins = "PG0", "PG1", "PG2", "PG3",
 						 "PG4", "PG5";
 				function = "mmc1";
@@ -684,7 +684,7 @@
 				bias-pull-up;
 			};
 
-			mmc2_pins_a: mmc2 at 0 {
+			mmc2_4bit_pins: mmc2-4bit-pins {
 				pins = "PC6", "PC7", "PC8", "PC9",
 						 "PC10", "PC11";
 				function = "mmc2";
@@ -692,7 +692,7 @@
 				bias-pull-up;
 			};
 
-			mmc2_8bit_emmc_pins: mmc2 at 1 {
+			mmc2_8bit_emmc_pins: mmc2-8bit-emmc-pins {
 				pins = "PC6", "PC7", "PC8", "PC9",
 						 "PC10", "PC11", "PC12",
 						 "PC13", "PC14", "PC15",
@@ -702,7 +702,7 @@
 				bias-pull-up;
 			};
 
-			mmc3_8bit_emmc_pins: mmc3 at 1 {
+			mmc3_8bit_emmc_pins: mmc3-8bit-emmc-pins {
 				pins = "PC6", "PC7", "PC8", "PC9",
 						 "PC10", "PC11", "PC12",
 						 "PC13", "PC14", "PC15",
@@ -712,12 +712,12 @@
 				bias-pull-up;
 			};
 
-			spdif_pins_a: spdif at 0 {
+			spdif_tx_pin: spdif-pin {
 				pins = "PH28";
 				function = "spdif";
 			};
 
-			uart0_pins_a: uart0 at 0 {
+			uart0_ph_pins: uart0-ph-pins {
 				pins = "PH20", "PH21";
 				function = "uart0";
 			};
@@ -1364,12 +1364,12 @@
 			#size-cells = <0>;
 			#gpio-cells = <3>;
 
-			ir_pins_a: ir at 0 {
+			s_ir_rx_pin: s-ir-rx-pin {
 				pins = "PL4";
 				function = "s_ir";
 			};
 
-			p2wi_pins: p2wi {
+			s_p2wi_pins: s-p2wi-pins {
 				pins = "PL0", "PL1";
 				function = "s_p2wi";
 			};
@@ -1383,7 +1383,7 @@
 			clock-frequency = <100000>;
 			resets = <&apb0_rst 3>;
 			pinctrl-names = "default";
-			pinctrl-0 = <&p2wi_pins>;
+			pinctrl-0 = <&s_p2wi_pins>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm/boot/dts/sun6i-a31s-cs908.dts b/arch/arm/boot/dts/sun6i-a31s-cs908.dts
index 75e578159c3a..72a02c045a38 100644
--- a/arch/arm/boot/dts/sun6i-a31s-cs908.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-cs908.dts
@@ -66,7 +66,7 @@
 
 &gmac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gmac_pins_mii_a>;
+	pinctrl-0 = <&gmac_mii_pins>;
 	phy = <&phy1>;
 	phy-mode = "mii";
 	status = "okay";
@@ -77,7 +77,7 @@
 
 &ir {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir_pins_a>;
+	pinctrl-0 = <&s_ir_rx_pin>;
 	status = "okay";
 };
 
@@ -87,7 +87,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_ph_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun6i-a31s-inet-q972.dts b/arch/arm/boot/dts/sun6i-a31s-inet-q972.dts
index 85dab04be261..cc518740b700 100644
--- a/arch/arm/boot/dts/sun6i-a31s-inet-q972.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-inet-q972.dts
@@ -55,7 +55,7 @@
 
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 
 	ft5406ee8: touchscreen at 38 {
diff --git a/arch/arm/boot/dts/sun6i-a31s-primo81.dts b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
index 55d60c68694e..645d405fcfcc 100644
--- a/arch/arm/boot/dts/sun6i-a31s-primo81.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
@@ -91,13 +91,13 @@
 &i2c0 {
 	/* pull-ups and device VDDIO use AXP221 DLDO3 */
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "failed";
 };
 
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 
 	ctp at 5d {
@@ -111,7 +111,7 @@
 
 &i2c2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins_a>;
+	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 
 	accelerometer at 1c {
@@ -146,7 +146,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 0 8 GPIO_ACTIVE_LOW>; /* PA8 */
diff --git a/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi b/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
index d7325bc4eeb4..3099491de8c4 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
@@ -135,7 +135,7 @@
 /* UART0 pads available on core board */
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_ph_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun6i-a31s-sina31s.dts b/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
index 02c9a90fe876..0be033f4942d 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
@@ -114,7 +114,7 @@
 
 &gmac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gmac_pins_mii_a>;
+	pinctrl-0 = <&gmac_mii_pins>;
 	phy = <&phy1>;
 	phy-mode = "mii";
 	phy-supply = <&reg_dldo1>;
@@ -137,7 +137,7 @@
 
 &ir {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir_pins_a>;
+	pinctrl-0 = <&s_ir_rx_pin>;
 	status = "okay";
 };
 
@@ -162,7 +162,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 0 4 GPIO_ACTIVE_LOW>; /* PA4 */
@@ -181,7 +181,7 @@
 
 &spdif {
 	pinctrl-names = "default";
-	pinctrl-0 = <&spdif_pins_a>;
+	pinctrl-0 = <&spdif_tx_pin>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
index 14e27e81ddf8..4ee496c531d7 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
@@ -91,7 +91,7 @@
 
 &gmac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gmac_pins_rgmii_a>;
+	pinctrl-0 = <&gmac_rgmii_pins>;
 	phy = <&phy1>;
 	phy-mode = "rgmii";
 	phy-supply = <&reg_dldo1>;
@@ -107,13 +107,13 @@
 
 &ir {
 	pinctrl-names = "default";
-	pinctrl-0 = <&ir_pins_a>;
+	pinctrl-0 = <&s_ir_rx_pin>;
 	status = "okay";
 };
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 0 4 GPIO_ACTIVE_LOW>; /* PA4 */
@@ -122,7 +122,7 @@
 
 &mmc2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc2_pins_a>;
+	pinctrl-0 = <&mmc2_4bit_pins>;
 	vmmc-supply = <&reg_aldo1>;
 	mmc-pwrseq = <&mmc2_pwrseq>;
 	bus-width = <4>;
@@ -254,7 +254,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_ph_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts b/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
index 153e40d6f4c5..13525620bab5 100644
--- a/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
@@ -63,13 +63,13 @@
 
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 };
 
 &i2c2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins_a>;
+	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 };
 
@@ -91,7 +91,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v0>;
 	bus-width = <4>;
 	cd-gpios = <&pio 0 8 GPIO_ACTIVE_LOW>; /* PA8 */
@@ -177,7 +177,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_ph_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi
index 77f952b12188..a506d740dee3 100644
--- a/arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi
@@ -66,7 +66,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 0 8 GPIO_ACTIVE_LOW>; /* PA8 */
-- 
git-series 0.9.1
