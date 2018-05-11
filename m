From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 10 May 2018 21:16:50 -0300
Subject: [PATCH 3/3] ARM: dts: imx23: Remove unit-address from pinctrl
In-Reply-To: <1525997810-10964-1-git-send-email-festevam@gmail.com>
References: <1525997810-10964-1-git-send-email-festevam@gmail.com>
Message-ID: <1525997810-10964-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Remove unit-address and reg property from pinctrl subnodes to fix
the following DTC warnings with W=1:

arch/arm/boot/dts/imx23-olinuxino.dtb: Warning (unique_unit_address): /apb at 80000000/apbh at 80000000/pinctrl at 80018000/hog at 0: duplicate unit-address (also used in node /apb at 80000000/apbh at 80000000

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx23-evk.dts           |  3 +-
 arch/arm/boot/dts/imx23-olinuxino.dts     |  6 +--
 arch/arm/boot/dts/imx23-sansa.dts         |  3 +-
 arch/arm/boot/dts/imx23-stmp378x_devb.dts |  3 +-
 arch/arm/boot/dts/imx23-xfi3.dts          |  6 +--
 arch/arm/boot/dts/imx23.dtsi              | 62 ++++++++++---------------------
 6 files changed, 27 insertions(+), 56 deletions(-)

diff --git a/arch/arm/boot/dts/imx23-evk.dts b/arch/arm/boot/dts/imx23-evk.dts
index 9d92ece82..278a446 100644
--- a/arch/arm/boot/dts/imx23-evk.dts
+++ b/arch/arm/boot/dts/imx23-evk.dts
@@ -42,8 +42,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&hog_pins_a>;
 
-				hog_pins_a: hog at 0 {
-					reg = <0>;
+				hog_pins_a: hog {
 					fsl,pinmux-ids = <
 						MX23_PAD_LCD_RESET__GPIO_1_18
 						MX23_PAD_PWM3__GPIO_1_29
diff --git a/arch/arm/boot/dts/imx23-olinuxino.dts b/arch/arm/boot/dts/imx23-olinuxino.dts
index e935177..bc154b3 100644
--- a/arch/arm/boot/dts/imx23-olinuxino.dts
+++ b/arch/arm/boot/dts/imx23-olinuxino.dts
@@ -38,8 +38,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&hog_pins_a>;
 
-				hog_pins_a: hog at 0 {
-					reg = <0>;
+				hog_pins_a: hog {
 					fsl,pinmux-ids = <
 						MX23_PAD_GPMI_ALE__GPIO_0_17
 					>;
@@ -48,8 +47,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				led_pin_gpio2_1: led_gpio2_1 at 0 {
-					reg = <0>;
+				led_pin_gpio2_1: led_gpio2_1 {
 					fsl,pinmux-ids = <
 						MX23_PAD_SSP1_DETECT__GPIO_2_1
 					>;
diff --git a/arch/arm/boot/dts/imx23-sansa.dts b/arch/arm/boot/dts/imx23-sansa.dts
index 67de786..62514e4 100644
--- a/arch/arm/boot/dts/imx23-sansa.dts
+++ b/arch/arm/boot/dts/imx23-sansa.dts
@@ -79,8 +79,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&hog_pins_a>;
 
-				hog_pins_a: hog at 0 {
-					reg = <0>;
+				hog_pins_a: hog {
 					fsl,pinmux-ids = <
 						MX23_PAD_GPMI_D08__GPIO_0_8
 						MX23_PAD_PWM3__GPIO_1_29
diff --git a/arch/arm/boot/dts/imx23-stmp378x_devb.dts b/arch/arm/boot/dts/imx23-stmp378x_devb.dts
index 95c7b91..dd61bfa 100644
--- a/arch/arm/boot/dts/imx23-stmp378x_devb.dts
+++ b/arch/arm/boot/dts/imx23-stmp378x_devb.dts
@@ -36,8 +36,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&hog_pins_a>;
 
-				hog_pins_a: hog at 0 {
-					reg = <0>;
+				hog_pins_a: hog {
 					fsl,pinmux-ids = <
 						MX23_PAD_PWM3__GPIO_1_29
 						MX23_PAD_PWM4__GPIO_1_30
diff --git a/arch/arm/boot/dts/imx23-xfi3.dts b/arch/arm/boot/dts/imx23-xfi3.dts
index 9616e50..0c38b7e 100644
--- a/arch/arm/boot/dts/imx23-xfi3.dts
+++ b/arch/arm/boot/dts/imx23-xfi3.dts
@@ -77,8 +77,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&hog_pins_a>;
 
-				hog_pins_a: hog at 0 {
-					reg = <0>;
+				hog_pins_a: hog {
 					fsl,pinmux-ids = <
 						MX23_PAD_GPMI_D07__GPIO_0_7
 					>;
@@ -87,8 +86,7 @@
 					fsl,pull-up = <0>;
 				};
 
-				key_pins_a: keys at 0 {
-					reg = <0>;
+				key_pins_a: keys {
 					fsl,pinmux-ids = <
 						MX23_PAD_ROTARYA__GPIO_2_7
 						MX23_PAD_ROTARYB__GPIO_2_8
diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index cb0a3fe..8d2019f 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -115,14 +115,11 @@
 			};
 
 			pinctrl@80018000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
 				compatible = "fsl,imx23-pinctrl", "simple-bus";
 				reg = <0x80018000 0x2000>;
 
-				gpio0: gpio at 0 {
+				gpio0: gpio0 {
 					compatible = "fsl,imx23-gpio", "fsl,mxs-gpio";
-					reg = <0>;
 					interrupts = <16>;
 					gpio-controller;
 					#gpio-cells = <2>;
@@ -130,9 +127,8 @@
 					#interrupt-cells = <2>;
 				};
 
-				gpio1: gpio at 1 {
+				gpio1: gpio1 {
 					compatible = "fsl,imx23-gpio", "fsl,mxs-gpio";
-					reg = <1>;
 					interrupts = <17>;
 					gpio-controller;
 					#gpio-cells = <2>;
@@ -140,9 +136,8 @@
 					#interrupt-cells = <2>;
 				};
 
-				gpio2: gpio at 2 {
+				gpio2: gpio2 {
 					compatible = "fsl,imx23-gpio", "fsl,mxs-gpio";
-					reg = <2>;
 					interrupts = <18>;
 					gpio-controller;
 					#gpio-cells = <2>;
@@ -150,8 +145,7 @@
 					#interrupt-cells = <2>;
 				};
 
-				duart_pins_a: duart at 0 {
-					reg = <0>;
+				duart_pins_a: duart {
 					fsl,pinmux-ids = <
 						MX23_PAD_PWM0__DUART_RX
 						MX23_PAD_PWM1__DUART_TX
@@ -161,8 +155,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				auart0_pins_a: auart0 at 0 {
-					reg = <0>;
+				auart0_pins_a: auart0 {
 					fsl,pinmux-ids = <
 						MX23_PAD_AUART1_RX__AUART1_RX
 						MX23_PAD_AUART1_TX__AUART1_TX
@@ -174,8 +167,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				auart0_2pins_a: auart0-2pins at 0 {
-					reg = <0>;
+				auart0_2pins_a: auart0-2pins {
 					fsl,pinmux-ids = <
 						MX23_PAD_I2C_SCL__AUART1_TX
 						MX23_PAD_I2C_SDA__AUART1_RX
@@ -185,8 +177,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				auart1_2pins_a: auart1-2pins at 0 {
-					reg = <0>;
+				auart1_2pins_a: auart1-2pins {
 					fsl,pinmux-ids = <
 						MX23_PAD_GPMI_D14__AUART2_RX
 						MX23_PAD_GPMI_D15__AUART2_TX
@@ -196,8 +187,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				gpmi_pins_a: gpmi-nand at 0 {
-					reg = <0>;
+				gpmi_pins_a: gpmi-nand {
 					fsl,pinmux-ids = <
 						MX23_PAD_GPMI_D00__GPMI_D00
 						MX23_PAD_GPMI_D01__GPMI_D01
@@ -222,8 +212,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				gpmi_pins_fixup: gpmi-pins-fixup at 0 {
-					reg = <0>;
+				gpmi_pins_fixup: gpmi-pins-fixup {
 					fsl,pinmux-ids = <
 						MX23_PAD_GPMI_WPN__GPMI_WPN
 						MX23_PAD_GPMI_WRN__GPMI_WRN
@@ -232,8 +221,7 @@
 					fsl,drive-strength = <MXS_DRIVE_12mA>;
 				};
 
-				mmc0_4bit_pins_a: mmc0-4bit at 0 {
-					reg = <0>;
+				mmc0_4bit_pins_a: mmc0-4bit {
 					fsl,pinmux-ids = <
 						MX23_PAD_SSP1_DATA0__SSP1_DATA0
 						MX23_PAD_SSP1_DATA1__SSP1_DATA1
@@ -247,8 +235,7 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				mmc0_8bit_pins_a: mmc0-8bit at 0 {
-					reg = <0>;
+				mmc0_8bit_pins_a: mmc0-8bit {
 					fsl,pinmux-ids = <
 						MX23_PAD_SSP1_DATA0__SSP1_DATA0
 						MX23_PAD_SSP1_DATA1__SSP1_DATA1
@@ -267,8 +254,7 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				mmc0_pins_fixup: mmc0-pins-fixup at 0 {
-					reg = <0>;
+				mmc0_pins_fixup: mmc0-pins-fixup {
 					fsl,pinmux-ids = <
 						MX23_PAD_SSP1_DETECT__SSP1_DETECT
 						MX23_PAD_SSP1_SCK__SSP1_SCK
@@ -276,8 +262,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				mmc1_4bit_pins_a: mmc1-4bit at 0 {
-					reg = <0>;
+				mmc1_4bit_pins_a: mmc1-4bit {
 					fsl,pinmux-ids = <
 						MX23_PAD_GPMI_D00__SSP2_DATA0
 						MX23_PAD_GPMI_D01__SSP2_DATA1
@@ -291,8 +276,7 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				mmc1_8bit_pins_a: mmc1-8bit at 0 {
-					reg = <0>;
+				mmc1_8bit_pins_a: mmc1-8bit {
 					fsl,pinmux-ids = <
 						MX23_PAD_GPMI_D00__SSP2_DATA0
 						MX23_PAD_GPMI_D01__SSP2_DATA1
@@ -310,8 +294,7 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				pwm2_pins_a: pwm2 at 0 {
-					reg = <0>;
+				pwm2_pins_a: pwm2 {
 					fsl,pinmux-ids = <
 						MX23_PAD_PWM2__PWM2
 					>;
@@ -320,8 +303,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				lcdif_24bit_pins_a: lcdif-24bit at 0 {
-					reg = <0>;
+				lcdif_24bit_pins_a: lcdif-24bit {
 					fsl,pinmux-ids = <
 						MX23_PAD_LCD_D00__LCD_D00
 						MX23_PAD_LCD_D01__LCD_D01
@@ -357,8 +339,7 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				spi2_pins_a: spi2 at 0 {
-					reg = <0>;
+				spi2_pins_a: spi2 {
 					fsl,pinmux-ids = <
 						MX23_PAD_GPMI_WRN__SSP2_SCK
 						MX23_PAD_GPMI_RDY1__SSP2_CMD
@@ -370,8 +351,7 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				i2c_pins_a: i2c at 0 {
-					reg = <0>;
+				i2c_pins_a: i2c {
 					fsl,pinmux-ids = <
 						MX23_PAD_I2C_SCL__I2C_SCL
 						MX23_PAD_I2C_SDA__I2C_SDA
@@ -381,8 +361,7 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				i2c_pins_b: i2c at 1 {
-					reg = <1>;
+				i2c_pins_b: i2cb {
 					fsl,pinmux-ids = <
 						MX23_PAD_LCD_ENABLE__I2C_SCL
 						MX23_PAD_LCD_HSYNC__I2C_SDA
@@ -392,8 +371,7 @@
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
 
-				i2c_pins_c: i2c at 2 {
-					reg = <2>;
+				i2c_pins_c: i2cc {
 					fsl,pinmux-ids = <
 						MX23_PAD_SSP1_DATA1__I2C_SCL
 						MX23_PAD_SSP1_DATA2__I2C_SDA
-- 
2.7.4
