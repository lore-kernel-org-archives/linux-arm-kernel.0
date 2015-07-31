From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat,  1 Aug 2015 00:58:26 +0200
Subject: [PATCH 5/9] ARM: at91/dt: add drm support for at91sam9n12ek
In-Reply-To: <1438383510-10521-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438383510-10521-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1438383510-10521-6-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bo Shen <voice.shen@atmel.com>

Add drm support for at91sam9n12ek board.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
Signed-off-by: Josh Wu <josh.wu@atmel.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9n12.dtsi  | 71 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9n12ek.dts | 61 +++++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 5c2a8c8c8bd4..41578d1a0dc4 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -443,6 +443,34 @@
 				clock-names = "t0_clk";
 			};
 
+			hlcdc: hlcdc at f8038000 {
+				compatible = "atmel,at91sam9n12-hlcdc";
+				reg = <0xf8038000 0x2000>;
+				interrupts = <25 IRQ_TYPE_LEVEL_HIGH 0>;
+				clocks = <&lcdc_clk>, <&lcdck>, <&clk32k>;
+				clock-names = "periph_clk", "sys_clk", "slow_clk";
+				status = "disabled";
+
+				hlcdc-display-controller {
+					compatible = "atmel,hlcdc-display-controller";
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port at 0 {
+						#address-cells = <1>;
+						#size-cells = <0>;
+						reg = <0>;
+					};
+				};
+
+				hlcdc_pwm: hlcdc-pwm {
+					compatible = "atmel,hlcdc-pwm";
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_lcd_pwm>;
+					#pwm-cells = <3>;
+				};
+			};
+
 			dma: dma-controller at ffffec00 {
 				compatible = "atmel,at91sam9g45-dma";
 				reg = <0xffffec00 0x200>;
@@ -475,6 +503,49 @@
 					};
 				};
 
+				lcd {
+					pinctrl_lcd_base: lcd-base-0 {
+						atmel,pins =
+							<AT91_PIOC 27 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDVSYNC */
+							 AT91_PIOC 28 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDHSYNC */
+							 AT91_PIOC 24 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDDISP */
+							 AT91_PIOC 29 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDDEN */
+							 AT91_PIOC 30 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* LCDPCK */
+					};
+
+					pinctrl_lcd_pwm: lcd-pwm-0 {
+						atmel,pins = <AT91_PIOC 26 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* LCDPWM */
+					};
+
+					pinctrl_lcd_rgb888: lcd-rgb-3 {
+						atmel,pins =
+							<AT91_PIOC 0 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDD0 pin */
+							 AT91_PIOC 1 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDD1 pin */
+							 AT91_PIOC 2 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDD2 pin */
+							 AT91_PIOC 3 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDD3 pin */
+							 AT91_PIOC 4 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDD4 pin */
+							 AT91_PIOC 5 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDD5 pin */
+							 AT91_PIOC 6 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDD6 pin */
+							 AT91_PIOC 7 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDD7 pin */
+							 AT91_PIOC 8 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDD8 pin */
+							 AT91_PIOC 9 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDD9 pin */
+							 AT91_PIOC 10 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDD10 pin */
+							 AT91_PIOC 11 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDD11 pin */
+							 AT91_PIOC 12 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDD12 pin */
+							 AT91_PIOC 13 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDD13 pin */
+							 AT91_PIOC 14 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDD14 pin */
+							 AT91_PIOC 15 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDD15 pin */
+							 AT91_PIOC 16 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDD16 pin */
+							 AT91_PIOC 17 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDD17 pin */
+							 AT91_PIOC 18 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDD18 pin */
+							 AT91_PIOC 19 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDD19 pin */
+							 AT91_PIOC 20 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDD20 pin */
+							 AT91_PIOC 21 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDD21 pin */
+							 AT91_PIOC 22 AT91_PERIPH_A AT91_PINCTRL_NONE	/* LCDD22 pin */
+							 AT91_PIOC 23 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* LCDD23 pin */
+					};
+				};
+
 				usart0 {
 					pinctrl_usart0: usart0-0 {
 						atmel,pins =
diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index eab17fcace6d..efa75064d38a 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -128,6 +128,22 @@
 				};
 			};
 
+			hlcdc: hlcdc at f8038000 {
+				status = "okay";
+
+				hlcdc-display-controller {
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb888>;
+
+					port at 0 {
+						hlcdc_panel_output: endpoint at 0 {
+							reg = <0>;
+							remote-endpoint = <&panel_input>;
+						};
+					};
+				};
+			};
+
 			usb1: gadget at f803c000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usb1_vbus_sense>;
@@ -161,6 +177,23 @@
 		};
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&hlcdc_pwm 0 50000 0>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+		power-supply = <&bl_reg>;
+		status = "okay";
+	};
+
+	bl_reg: backlight_regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "backlight-power-supply";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		status = "okay";
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -194,6 +227,34 @@
 		};
 	};
 
+	panel: panel {
+		compatible = "qd,qd43003c0-40", "simple-panel";
+		backlight = <&backlight>;
+		power-supply = <&panel_reg>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+
+		port at 0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			panel_input: endpoint at 0 {
+				reg = <0>;
+				remote-endpoint = <&hlcdc_panel_output>;
+			};
+		};
+	};
+
+	panel_reg: panel_regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "panel-power-supply";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		status = "okay";
+	};
+
 	sound {
 		compatible = "atmel,asoc-wm8904";
 		pinctrl-names = "default";
-- 
2.1.4
