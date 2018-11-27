From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:46:04 +0100
Subject: [PATCH 63/77] ARM: dts: sun8i: a23/a33: Change pinctrl nodes to avoid
 warning
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <0808e07332c6fafa9a998d1c4ad1d710a3094750.1543321707.git-series.maxime.ripard@bootlin.com>
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
 arch/arm/boot/dts/sun8i-a23-a33.dtsi                  | 26 ++++++------
 arch/arm/boot/dts/sun8i-a23-evb.dts                   |  6 +--
 arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts |  2 +-
 arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts |  2 +-
 arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts            |  2 +-
 arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts        |  6 +--
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts             |  4 +-
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts        |  4 +-
 arch/arm/boot/dts/sun8i-a33.dtsi                      |  2 +-
 arch/arm/boot/dts/sun8i-q8-common.dtsi                |  2 +-
 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts          | 14 +++---
 arch/arm/boot/dts/sun8i-r16-nintendo-nes-classic.dts  |  2 +-
 arch/arm/boot/dts/sun8i-r16-parrot.dts                |  8 ++--
 arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi  | 11 ++++-
 14 files changed, 50 insertions(+), 41 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 43978625df21..bcb5b30a02f0 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -298,22 +298,22 @@
 			#interrupt-cells = <3>;
 			#gpio-cells = <3>;
 
-			i2c0_pins_a: i2c0 at 0 {
+			i2c0_pins: i2c0-pins {
 				pins = "PH2", "PH3";
 				function = "i2c0";
 			};
 
-			i2c1_pins_a: i2c1 at 0 {
+			i2c1_pins: i2c1-pins {
 				pins = "PH4", "PH5";
 				function = "i2c1";
 			};
 
-			i2c2_pins_a: i2c2 at 0 {
+			i2c2_pins: i2c2-pins {
 				pins = "PE12", "PE13";
 				function = "i2c2";
 			};
 
-			lcd_rgb666_pins: lcd-rgb666 at 0 {
+			lcd_rgb666_pins: lcd-rgb666-pins {
 				pins = "PD2", "PD3", "PD4", "PD5", "PD6", "PD7",
 				       "PD10", "PD11", "PD12", "PD13", "PD14", "PD15",
 				       "PD18", "PD19", "PD20", "PD21", "PD22", "PD23",
@@ -321,7 +321,7 @@
 				function = "lcd0";
 			};
 
-			mmc0_pins_a: mmc0 at 0 {
+			mmc0_pins: mmc0-pins {
 				pins = "PF0", "PF1", "PF2",
 				       "PF3", "PF4", "PF5";
 				function = "mmc0";
@@ -329,7 +329,7 @@
 				bias-pull-up;
 			};
 
-			mmc1_pins_a: mmc1 at 0 {
+			mmc1_pg_pins: mmc1-pg-pins {
 				pins = "PG0", "PG1", "PG2",
 				       "PG3", "PG4", "PG5";
 				function = "mmc1";
@@ -337,7 +337,7 @@
 				bias-pull-up;
 			};
 
-			mmc2_8bit_pins: mmc2_8bit {
+			mmc2_8bit_pins: mmc2-8bit-pins {
 				pins = "PC5", "PC6", "PC8",
 				       "PC9", "PC10", "PC11",
 				       "PC12", "PC13", "PC14",
@@ -378,22 +378,22 @@
 				bias-pull-up;
 			};
 
-			pwm0_pins: pwm0 {
+			pwm0_pin: pwm0-pin {
 				pins = "PH0";
 				function = "pwm0";
 			};
 
-			uart0_pins_a: uart0 at 0 {
+			uart0_pf_pins: uart0-pf-pins {
 				pins = "PF2", "PF4";
 				function = "uart0";
 			};
 
-			uart1_pins_a: uart1 at 0 {
+			uart1_pg_pins: uart1-pg-pins {
 				pins = "PG6", "PG7";
 				function = "uart1";
 			};
 
-			uart1_pins_cts_rts_a: uart1-cts-rts at 0 {
+			uart1_cts_rts_pg_pins: uart1-cts-rts-pg-pins {
 				pins = "PG8", "PG9";
 				function = "uart1";
 			};
@@ -658,14 +658,14 @@
 			#interrupt-cells = <3>;
 			#gpio-cells = <3>;
 
-			r_rsb_pins: r_rsb {
+			r_rsb_pins: r-rsb-pins {
 				pins = "PL0", "PL1";
 				function = "s_rsb";
 				drive-strength = <20>;
 				bias-pull-up;
 			};
 
-			r_uart_pins_a: r_uart at 0 {
+			r_uart_pins_a: r-uart-pins {
 				pins = "PL2", "PL3";
 				function = "s_uart";
 			};
diff --git a/arch/arm/boot/dts/sun8i-a23-evb.dts b/arch/arm/boot/dts/sun8i-a23-evb.dts
index 3c994df0ffdf..36896155f2b9 100644
--- a/arch/arm/boot/dts/sun8i-a23-evb.dts
+++ b/arch/arm/boot/dts/sun8i-a23-evb.dts
@@ -66,13 +66,13 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 };
 
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 };
 
@@ -104,7 +104,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v0>;
 	bus-width = <4>;
 	cd-gpios = <&pio 1 4 GPIO_ACTIVE_LOW>; /* PB4 */
diff --git a/arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts b/arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts
index 4a318faa462a..d5f6aebd7216 100644
--- a/arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts
+++ b/arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts
@@ -69,7 +69,7 @@
 
 &mmc1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
+	pinctrl-0 = <&mmc1_pg_pins>;
 	vmmc-supply = <&reg_dldo1>;
 	mmc-pwrseq = <&wifi_pwrseq>;
 	bus-width = <4>;
diff --git a/arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts b/arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts
index 22e153d50523..9f9232a2fefb 100644
--- a/arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts
+++ b/arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts
@@ -62,7 +62,7 @@
 
 &mmc1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
+	pinctrl-0 = <&mmc1_pg_pins>;
 	vmmc-supply = <&reg_dldo1>;
 	mmc-pwrseq = <&wifi_pwrseq>;
 	bus-width = <4>;
diff --git a/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts b/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts
index 9ead5e1b7b65..2dfdd0a3151e 100644
--- a/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts
+++ b/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts
@@ -79,7 +79,7 @@
 
 &mmc1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
+	pinctrl-0 = <&mmc1_pg_pins>;
 	vmmc-supply = <&reg_dldo1>;
 	bus-width = <4>;
 	non-removable;
diff --git a/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts b/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
index f8a72d07467c..42726576a6a9 100644
--- a/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
+++ b/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
@@ -72,7 +72,7 @@
 
 &mmc1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
+	pinctrl-0 = <&mmc1_pg_pins>;
 	vmmc-supply = <&reg_dldo1>;
 	bus-width = <4>;
 	non-removable;
@@ -97,7 +97,7 @@
 
 &uart1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pins_a>,
-		    <&uart1_pins_cts_rts_a>;
+	pinctrl-0 = <&uart1_pg_pins>,
+		    <&uart1_cts_rts_pg_pins>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun8i-a33-olinuxino.dts b/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
index a1a1eb64caeb..9ad7eeba9df4 100644
--- a/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
+++ b/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
@@ -83,7 +83,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 1 4 GPIO_ACTIVE_LOW>; /* PB4 */
@@ -207,7 +207,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_b>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
index 035c4d8006cd..b161a0ce03af 100644
--- a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
+++ b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
@@ -134,7 +134,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 1 4 GPIO_ACTIVE_LOW>; /* PB4 */
@@ -256,7 +256,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_b>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index 0036309e2c50..d03493d92618 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -525,7 +525,7 @@
 	interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
 		     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 
-	uart0_pins_b: uart0 at 1 {
+	uart0_pb_pins: uart0-pb-pins {
 		pins = "PB0", "PB1";
 		function = "uart0";
 	};
diff --git a/arch/arm/boot/dts/sun8i-q8-common.dtsi b/arch/arm/boot/dts/sun8i-q8-common.dtsi
index 0b3db925254b..e3ca8a94d690 100644
--- a/arch/arm/boot/dts/sun8i-q8-common.dtsi
+++ b/arch/arm/boot/dts/sun8i-q8-common.dtsi
@@ -70,7 +70,7 @@
 
 &mmc1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
+	pinctrl-0 = <&mmc1_pg_pins>;
 	vmmc-supply = <&reg_dldo1>;
 	mmc-pwrseq = <&wifi_pwrseq>;
 	bus-width = <4>;
diff --git a/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts b/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
index ee7ce3752581..a44d80c24416 100644
--- a/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
+++ b/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
@@ -127,27 +127,27 @@
 /* This is the i2c bus exposed on the DSI connector for the touch panel */
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "disabled";
 };
 
 /* This is the i2c bus exposed on the GPIO header */
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-0 = <&i2c1_pins>;
 	status = "disabled";
 };
 
 /* This is the i2c bus exposed on the CSI connector to control the sensor */
 &i2c2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins_a>;
+	pinctrl-0 = <&i2c2_pins>;
 	status = "disabled";
 };
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 1 4 GPIO_ACTIVE_LOW>; /* PB4 */
@@ -156,7 +156,7 @@
 
 &mmc1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
+	pinctrl-0 = <&mmc1_pg_pins>;
 	vmmc-supply = <&reg_aldo1>;
 	mmc-pwrseq = <&wifi_pwrseq>;
 	bus-width = <4>;
@@ -292,13 +292,13 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_b>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
 &uart1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pins_a>, <&uart1_pins_cts_rts_a>;
+	pinctrl-0 = <&uart1_pg_pins>, <&uart1_cts_rts_pg_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-r16-nintendo-nes-classic.dts b/arch/arm/boot/dts/sun8i-r16-nintendo-nes-classic.dts
index fc0658cfa319..32cf1ab33aab 100644
--- a/arch/arm/boot/dts/sun8i-r16-nintendo-nes-classic.dts
+++ b/arch/arm/boot/dts/sun8i-r16-nintendo-nes-classic.dts
@@ -25,7 +25,7 @@
 	 * PF can also be used for the SD card so PB is preferred.
 	 */
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pf_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-r16-parrot.dts b/arch/arm/boot/dts/sun8i-r16-parrot.dts
index 0465863743c2..62f53291ff22 100644
--- a/arch/arm/boot/dts/sun8i-r16-parrot.dts
+++ b/arch/arm/boot/dts/sun8i-r16-parrot.dts
@@ -96,7 +96,7 @@
 
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 
 	/*
@@ -127,7 +127,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
 	cd-gpios = <&pio 3 14 GPIO_ACTIVE_LOW>; /* PD14 */
 	bus-width = <4>;
@@ -136,7 +136,7 @@
 
 &mmc1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
+	pinctrl-0 = <&mmc1_pg_pins>;
 	vmmc-supply = <&reg_aldo1>;
 	mmc-pwrseq = <&wifi_pwrseq>;
 	bus-width = <4>;
@@ -299,7 +299,7 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_b>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
index 6838bce7dd4e..12a2ad67844e 100644
--- a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
@@ -62,6 +62,7 @@
 };
 
 &i2c0 {
+	pinctrl-0 = <&i2c0_pins>;
 	/*
 	 * The gsl1680 is rated at 400KHz and it will not work reliable at
 	 * 100KHz, this has been confirmed on multiple different q8 tablets.
@@ -79,9 +80,13 @@
 	};
 };
 
+&i2c1 {
+	pinctrl-0 = <&i2c1_pins>;
+};
+
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 1 4 GPIO_ACTIVE_LOW>; /* PB4 */
@@ -96,6 +101,10 @@
 	};
 };
 
+&pwm {
+	pinctrl-0 = <&pwm0_pin>;
+};
+
 &r_rsb {
 	status = "okay";
 
-- 
git-series 0.9.1
