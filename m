From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 21 Dec 2012 17:45:13 +0800
Subject: [PATCH v6 3/8] ARM: dts: support pinctrl single in aspenite
In-Reply-To: <1356083118-18857-1-git-send-email-haojian.zhuang@linaro.org>
References: <1356083118-18857-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1356083118-18857-4-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Haojian Zhuang <haojian.zhuang@gmail.com>

Support pinctrl-single driver in aspenite DTS file.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/boot/dts/pxa168-aspenite.dts |  109 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/pxa168.dtsi         |  109 +++++++++++++++++++++++++++++++++
 2 files changed, 218 insertions(+)

diff --git a/arch/arm/boot/dts/pxa168-aspenite.dts b/arch/arm/boot/dts/pxa168-aspenite.dts
index e762fac..6955242 100644
--- a/arch/arm/boot/dts/pxa168-aspenite.dts
+++ b/arch/arm/boot/dts/pxa168-aspenite.dts
@@ -24,7 +24,116 @@
 
 	soc {
 		apb at d4000000 {
+			pmx: pinmux at d401e000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&ether_pins>;
+
+				ether_pins: pinmux_ether_pins {
+					pinctrl-single,pins = <
+						0x094 0x3	/* GPIO18_SMC_nCS0 */
+						0x0a8 0x0	/* GPIO23_SMC_nLUA */
+						0x0b0 0x0	/* GPIO25_SMC_nLLA */
+						0x0b8 0x0	/* GPIO27_GPIO as irq */
+						0x0bc 0x0	/* GPIO28_SMC_RDY */
+						0x0c0 0x0	/* GPIO29_SMC_SCLK */
+						0x0d4 0x2	/* GPIO34_SMC_nCS1 */
+						0x0d8 0x2	/* GPIO35_SMC_BE1 */
+						0x0dc 0x2	/* GPIO36_SMC_BE2 */
+					>;
+					pinctrl-single,power-source = <0x0c00 0x0c00>;
+					pinctrl-single,bias = <0 0xe000 0 0xa000 0xc000>;
+				};
+				uart1_pins: pinmux_uart1_pins {
+					pinctrl-single,pins = <
+						0x1ac 0x2	/* GPIO107_UART1_RXD */
+						0x1b0 0x2	/* GPIO108_UART1_TXD */
+					>;
+					pinctrl-single,power-source = <0x0c00 0x0c00>;
+					pinctrl-single,bias = <0 0xe000 0 0xa000 0xc000>;
+				};
+				nand_pins: pinmux_nand_pins {
+					pinctrl-single,pins = <
+						0x04c 0x0	/* ND_IO15 */
+						0x050 0x0	/* ND_IO14 */
+						0x054 0x0	/* ND_IO13 */
+						0x058 0x0	/* ND_IO12 */
+						0x05c 0x0	/* ND_IO11 */
+						0x060 0x0	/* ND_IO10 */
+						0x064 0x0	/* ND_IO9 */
+						0x068 0x0	/* ND_IO8 */
+						0x06c 0x0	/* ND_IO7 */
+						0x070 0x0	/* ND_IO6 */
+						0x074 0x0	/* ND_IO5 */
+						0x078 0x0	/* ND_IO4 */
+						0x07c 0x0	/* ND_IO3 */
+						0x080 0x0	/* ND_IO2 */
+						0x084 0x0	/* ND_IO1 */
+						0x088 0x0	/* ND_IO0 */
+					>;
+					pinctrl-single,power-source = <0x0800 0x0c00>;
+					pinctrl-single,bias = <0 0xe000 0 0xa000 0xc000>;
+				};
+				ssp1_pins: pinmux_ssp1_pins {
+					pinctrl-single,pins = <
+						0x1c4 0x6	/* GPIO113_I2S_MCLK */
+						0x1c8 0x1	/* GPIO114_I2S_FRM */
+						0x1cc 0x1	/* GPIO115_I2S_BCLK */
+						0x120 0x2	/* GPIO116_I2S_RXD */
+						0x124 0x2	/* GPIO117_I2S_TXD */
+					>;
+					pinctrl-single,power-source = <0x0800 0x0c00>;
+					pinctrl-single,bias = <0 0xe000 0 0xa000 0xc000>;
+				};
+				keypad_pins: pinmux_keypad_pins {
+					pinctrl-single,pins = <
+						0x1b4 0x7	/* GPIO109_KP_MKIN1 */
+						0x1b8 0x7	/* GPIO110_KP_MKIN0 */
+						0x1bc 0x7	/* GPIO111_KP_MKOUT7 */
+						0x1c0 0x7	/* GPIO112_KP_MKOUT6 */
+						0x1e4 0x7	/* GPIO121_MK_MKIN4 */
+					>;
+					pinctrl-single,power-source = <0x0800 0x0c00>;
+					pinctrl-single,bias = <0 0xe000 0 0xa000 0xc000>;
+				};
+				lcd_pins: pinmux_lcd_pins {
+					pinctrl-single,pins = <
+						0x0e0 0x1	/* GPIO56_LCD_FCLK_RD */
+						0x0e4 0x1	/* GPIO57_LCD_LCLK_A0 */
+						0x0e8 0x1	/* GPIO58_LCD_ACLK_WR */
+						0x0ec 0x1	/* GPIO59_LCD_DENA_BIAS */
+						0x0f0 0x1	/* GPIO60_LCD_DD0 */
+						0x0f4 0x1	/* GPIO60_LCD_DD1 */
+						0x0f8 0x1	/* GPIO60_LCD_DD2 */
+						0x0fc 0x1	/* GPIO60_LCD_DD3 */
+						0x100 0x1	/* GPIO60_LCD_DD4 */
+						0x104 0x1	/* GPIO60_LCD_DD5 */
+						0x108 0x1	/* GPIO60_LCD_DD6 */
+						0x10c 0x1	/* GPIO60_LCD_DD7 */
+						0x110 0x1	/* GPIO60_LCD_DD8 */
+						0x114 0x1	/* GPIO60_LCD_DD9 */
+						0x118 0x1	/* GPIO60_LCD_DD10 */
+						0x11c 0x1	/* GPIO60_LCD_DD11 */
+						0x120 0x1	/* GPIO60_LCD_DD12 */
+						0x124 0x1	/* GPIO60_LCD_DD13 */
+						0x128 0x1	/* GPIO60_LCD_DD14 */
+						0x12c 0x1	/* GPIO60_LCD_DD15 */
+						0x130 0x1	/* GPIO60_LCD_DD16 */
+						0x134 0x1	/* GPIO60_LCD_DD17 */
+						0x138 0x1	/* GPIO60_LCD_DD18 */
+						0x13c 0x1	/* GPIO60_LCD_DD19 */
+						0x140 0x1	/* GPIO60_LCD_DD20 */
+						0x144 0x1	/* GPIO60_LCD_DD21 */
+						0x148 0x1	/* GPIO60_LCD_DD22 */
+						0x14c 0x1	/* GPIO60_LCD_DD23 */
+					>;
+					pinctrl-single,power-source = <0x0800 0x0c00>;
+					pinctrl-single,bias = <0 0xe000 0 0xa000 0xc000>;
+				};
+			};
+
 			uart1: uart at d4017000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&uart1_pins>;
 				status = "okay";
 			};
 			twsi1: i2c at d4011000 {
diff --git a/arch/arm/boot/dts/pxa168.dtsi b/arch/arm/boot/dts/pxa168.dtsi
index 31a7186..f91c3f3 100644
--- a/arch/arm/boot/dts/pxa168.dtsi
+++ b/arch/arm/boot/dts/pxa168.dtsi
@@ -49,6 +49,115 @@
 			reg = <0xd4000000 0x00200000>;
 			ranges;
 
+			pmx: pinmux at d401e000 {
+				compatible = "pinconf-single";
+				reg = <0xd401e000 0x020c>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+
+				pinctrl-single,register-width = <32>;
+				pinctrl-single,function-mask = <7>;
+
+				range0: range at d401e04c {
+					/* GPIO0 ~ GPIO15 */
+					reg = <0xd401e04c 0x40>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <0 5>;
+				};
+
+				range1: range at d401e08c {
+					/* GPIO16 */
+					reg = <0xd401e08c 0x04>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <16 0>;
+				};
+
+				range2: range at d401e090 {
+					/* GPIO17 */
+					reg = <0xd401e090 0x04>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <17 5>;
+				};
+
+				range3: range at d401e094 {
+					/* GPIO18 */
+					reg = <0xd401e094 0x04>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <18 0>;
+				};
+
+				range4: range at d401e098 {
+					/* GPIO19 */
+					reg = <0xd401e098 0x04>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <19 5>;
+				};
+
+				range5: range at d401e09c {
+					/* GPIO20 */
+					reg = <0xd401e09c 0x04>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <20 0>;
+				};
+
+				range6: range at d401e0a0 {
+					/* GPIO21 */
+					reg = <0xd401e0a0 0x14>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <21 5>;
+				};
+
+				range7: range at d401e0b4 {
+					/* GPIO26 */
+					reg = <0xd401e0b4 0x04>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <26 0>;
+				};
+
+				range8: range at d401e0b8 {
+					/* GPIO27 */
+					reg = <0xd401e0b8 0x1c>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <27 5>;
+				};
+
+				range9: range at d401e0d4 {
+					/* GPIO34 ~ GPIO36 */
+					reg = <0xd401e0d4 0x0c>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <34 0>;
+				};
+
+				range10: range at d401e000 {
+					/* GPIO37 ~ GPIO55 */
+					reg = <0xd401e000 0x4c>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <37 0>;
+				};
+
+				range11: range at d401e0e0 {
+					/* GPIO56 ~ GPIO85 */
+					reg = <0xd401e0e0 0x78>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <56 0>;
+				};
+
+				range12: range at d401e158 {
+					/* GPIO86 ~ GPIO106 */
+					reg = <0xd401e158 0x54>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <86 0>;
+				};
+
+				range13: range at d401e1ac {
+					/* GPIO107 ~ GPIO122 */
+					reg = <0xd401e1ac 0x40>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <107 0>;
+				};
+			};
+
 			timer0: timer at d4014000 {
 				compatible = "mrvl,mmp-timer";
 				reg = <0xd4014000 0x100>;
-- 
1.7.10.4
