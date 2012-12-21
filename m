From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 21 Dec 2012 17:45:14 +0800
Subject: [PATCH v6 4/8] ARM: dts: support pinctrl single in brownstone
In-Reply-To: <1356083118-18857-1-git-send-email-haojian.zhuang@linaro.org>
References: <1356083118-18857-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1356083118-18857-5-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Haojian Zhuang <haojian.zhuang@gmail.com>

Support pinctrl-single driver in brownstone platform with DT.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/boot/dts/mmp2-brownstone.dts |  171 +++++++++++++++++++++++++++
 arch/arm/boot/dts/mmp2.dtsi           |  204 +++++++++++++++++++++++++++++++++
 2 files changed, 375 insertions(+)

diff --git a/arch/arm/boot/dts/mmp2-brownstone.dts b/arch/arm/boot/dts/mmp2-brownstone.dts
index c9b4f27..60976a9 100644
--- a/arch/arm/boot/dts/mmp2-brownstone.dts
+++ b/arch/arm/boot/dts/mmp2-brownstone.dts
@@ -24,10 +24,181 @@
 
 	soc {
 		apb at d4000000 {
+			pmx: pinmux at d401e000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&board_pins>;
+
+				board_pins: pinmux_board_pins {
+					pinctrl-single,pins = <
+						0x010 0x0	/* GPIO125_GPIO as version:0 */
+						0x014 0x0	/* GPIO126_GPIO as version:1 */
+						0x018 0x0	/* GPIO127_GPIO as version:2 */
+						0x01c 0x0	/* GPIO128_GPIO as version:3 */
+					>;
+					pinctrl-single,power-source = <0x0800 0x1800>;
+					pinctrl-single,bias = <0 0xe000 0 0xa000 0xc000>;
+					pinctrl-single,input-schmitt = <0x40 0x70 0x40>;
+				};
+
+				uart1_pins: pinmux_uart1_pins {
+					pinctrl-single,pins = <
+						0x0c8 0x1	/* GPIO29_UART1_RXD */
+						0x0cc 0x1	/* GPIO30_UART1_TXD */
+					>;
+					/* power source, mask */
+					pinctrl-single,power-source = <0x1000 0x1800>;
+					/* bias, mask, disable, pull down, pull up */
+					pinctrl-single,bias = <0 0xe000 0 0xa000 0xc000>;
+					/* input schmitt, mask, disable */
+					pinctrl-single,input-schmitt = <0x40 0x70 0x40>;
+				};
+				uart2_pins: pinmux_uart2_pins {
+					pinctrl-single,pins = <
+						0x110 0x1	/* GPIO47_UART2_RXD */
+						0x114 0x1	/* GPIO48_UART2_TXD */
+					>;
+					pinctrl-single,power-source = <0x1000 0x1800>;
+					pinctrl-single,bias = <0 0xe000 0 0xa000 0xc000>;
+					pinctrl-single,input-schmitt = <0x40 0x70 0x40>;
+				};
+				uart3_pins: pinmux_uart3_pins {
+					pinctrl-single,pins = <
+						0x120 0x1	/* GPIO51_UART3_RXD */
+						0x124 0x1	/* GPIO52_UART3_TXD */
+					>;
+					pinctrl-single,power-source = <0x1000 0x1800>;
+					pinctrl-single,bias = <0 0xe000 0 0xa000 0xc000>;
+					pinctrl-single,input-schmitt = <0x40 0x70 0x40>;
+				};
+				twsi1_pins: pinmux_twsi1_pins {
+					pinctrl-single,pins = <
+						0x140 0x0	/* TWSI_SCL */
+						0x144 0x0	/* TWSI_SDA */
+					>;
+					pinctrl-single,power-source = <0x0800 0x1800>;
+					pinctrl-single,bias = <0 0xe000 0 0xa000 0xc000>;
+					pinctrl-single,input-schmitt = <0x40 0x70 0x40>;
+				};
+				twsi2_pins: pinmux_twsi2_pins {
+					pinctrl-single,pins = <
+						0x100 0x1	/* GPIO43_TWSI2_SCL */
+						0x104 0x1	/* GPIO44_TWSI2_SDA */
+					>;
+					pinctrl-single,power-source = <0x0800 0x1800>;
+					pinctrl-single,bias = <0 0xe000 0 0xa000 0xc000>;
+					pinctrl-single,input-schmitt = <0x40 0x70 0x40>;
+				};
+				twsi3_pins: pinmux_twsi3_pins {
+					pinctrl-single,pins = <
+						0x2b0 0x1	/* GPIO71_TWSI3_SCL */
+						0x2b4 0x1	/* GPIO72_TWSI3_SDA */
+					>;
+					pinctrl-single,power-source = <0x0800 0x1800>;
+					pinctrl-single,bias = <0 0xe000 0 0xa000 0xc000>;
+					pinctrl-single,input-schmitt = <0x40 0x70 0x40>;
+				};
+				twsi4_pins: pinmux_twsi4_pins {
+					pinctrl-single,pins = <
+						0x2bc 0x0	/* TWSI4_SCL */
+						0x2c0 0x0	/* TWSI4_SDA */
+					>;
+					pinctrl-single,power-source = <0x0800 0x1800>;
+					pinctrl-single,bias = <0 0xe000 0 0xa000 0xc000>;
+					pinctrl-single,input-schmitt = <0x40 0x70 0x40>;
+				};
+				twsi5_pins: pinmux_twsi5_pins {
+					pinctrl-single,pins = <
+						0x1d4 0x4	/* GPIO99_TWSI5_SCL */
+						0x1d8 0x4	/* GPIO100_TWSI5_SDA */
+					>;
+					pinctrl-single,power-source = <0x0800 0x1800>;
+					pinctrl-single,bias = <0 0xe000 0 0xa000 0xc000>;
+					pinctrl-single,input-schmitt = <0x40 0x70 0x40>;
+				};
+				twsi6_pins: pinmux_twsi6_pins {
+					pinctrl-single,pins = <
+						0x1cc 0x2	/* GPIO97_TWSI6_SCL */
+						0x1d0 0x2	/* GPIO98_TWSI6_SDA */
+					>;
+					pinctrl-single,power-source = <0x0800 0x1800>;
+					pinctrl-single,bias = <0 0xe000 0 0xa000 0xc000>;
+					pinctrl-single,input-schmitt = <0x40 0x70 0x40>;
+				};
+				sspa1_pins: pinmux_sspa1_pins {
+					pinctrl-single,pins = <
+						0x0b0 0x0	/* GPIO23_GPIO */
+						0x0b4 0x1	/* GPIO24_I2S_SYSCLK */
+						0x0b8 0x1	/* GPIO25_I2S_BITCLK */
+						0x0bc 0x1	/* GPIO26_I2S_SYNC */
+						0x0c0 0x1	/* GPIO27_I2S_DATA_OUT */
+						0x0c4 0x1	/* GPIO28_I2S_SDATA_IN */
+					>;
+					pinctrl-single,power-source = <0x1000 0x1800>;
+					pinctrl-single,bias = <0 0xe000 0 0xa000 0xc000>;
+					pinctrl-single,input-schmitt = <0x40 0x70 0x40>;
+				};
+				sspa2_pins: pinmux_sspa2_pins {
+					pinctrl-single,pins = <
+						0x0d8 0x1	/* GPIO33_SSPA2_CLK */
+						0x0dc 0x1	/* GPIO34_SSPA2_FRM */
+						0x0e0 0x1	/* GPIO35_SSPA2_TXD */
+						0x0e4 0x1	/* GPIO36_SSPA2_RXD */
+					>;
+					pinctrl-single,power-source = <0x1000 0x1800>;
+					pinctrl-single,bias = <0 0xe000 0 0xa000 0xc000>;
+					pinctrl-single,input-schmitt = <0x40 0x70 0x40>;
+				};
+				nand_pins: pinmux_nand_pins {
+					pinctrl-single,pins = <
+						0x1e0 0x0	/* GPIO168_DFI_D0 */
+						0x1e4 0x0	/* GPIO167_DFI_D1 */
+						0x1e8 0x0	/* GPIO166_DFI_D2 */
+						0x1ec 0x0	/* GPIO165_DFI_D3 */
+						0x1f0 0x0	/* GPIO107_DFI_D4 */
+						0x1f4 0x0	/* GPIO106_DFI_D5 */
+						0x1f8 0x0	/* GPIO105_DFI_D6 */
+						0x1fc 0x0	/* GPIO104_DFI_D7 */
+						0x200 0x0	/* GPIO111_DFI_D8 */
+						0x204 0x0	/* GPIO164_DFI_D9 */
+						0x208 0x0	/* GPIO163_DFI_D10 */
+						0x20c 0x0	/* GPIO162_DFI_D11 */
+						0x210 0x0	/* GPIO161_DFI_D12 */
+						0x214 0x0	/* GPIO110_DFI_D13 */
+						0x218 0x0	/* GPIO109_DFI_D14 */
+						0x21c 0x0	/* GPIO108_DFI_D15 */
+						0x220 0x0	/* GPIO143_ND_nCS0 */
+						0x224 0X0	/* GPIO144_ND_nCS1 */
+						0x230 0x0	/* GPIO147_ND_nWE */
+						0x234 0x0	/* GPIO148_ND_nRE */
+						0x238 0x0	/* GPIO149_ND_CLE */
+						0x23c 0x0	/* GPIO150_ND_ALE */
+						0x244 0x0	/* GPIO112_ND_RDY0 */
+						0x250 0x0	/* GPIO160_ND_RDY1 */
+					>;
+					pinctrl-single,power-source = <0x1000 0x1800>;
+					pinctrl-single,bias = <0 0xe000 0 0xa000 0xc000>;
+					pinctrl-single,input-schmitt = <0x40 0x70 0x40>;
+				};
+				keypad_pins: pinmux_keypad_pins {
+					pinctrl-single,pins = <
+						0x094 0x1	/* GPIO16_KP_DKIN0 */
+						0x098 0X1	/* GPIO17_KP_DKIN1 */
+						0x09c 0x1	/* GPIO18_KP_DKIN2 */
+						0x0a0 0x1	/* GPIO19_KP_DKIN3 */
+					>;
+					pinctrl-single,power-source = <0x1000 0x1800>;
+					pinctrl-single,bias = <0xc000 0xe000 0 0xa000 0xc000>;
+					pinctrl-single,input-schmitt = <0x40 0x70 0x40>;
+				};
+			};
 			uart3: uart at d4018000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&uart3_pins>;
 				status = "okay";
 			};
 			twsi1: i2c at d4011000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&twsi1_pins>;
 				status = "okay";
 			};
 			rtc: rtc at d4010000 {
diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 0514fb4..1f28a1c 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -125,6 +125,210 @@
 			reg = <0xd4000000 0x00200000>;
 			ranges;
 
+			pmx: pinmux at d401e000 {
+				compatible = "pinconf-single";
+				reg = <0xd401e000 0x02c4>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+
+				pinctrl-single,register-width = <32>;
+				pinctrl-single,function-mask = <7>;
+
+				range0: range at d401e054 {
+					/* GPIO0 ~ GPIO58 */
+					reg = <0xd401e054 0xec>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <0 0>;
+				};
+				range1: range at d401e280 {
+					/* GPIO59 ~ GPIO73 */
+					reg = <0xd401e280 0x40>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <59 0>;
+				};
+				range2: range at d401e170 {
+					/* GPIO74 ~ GPIO101 */
+					reg = <0xd401e170 0x70>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <74 0>;
+				};
+				range3: range at d401e000 {
+					/* GPIO102 ~ GPIO103 */
+					reg = <0xd401e000 0x08>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <0 1>;
+				};
+				range4: range at d401e1fc {
+					/* GPIO104 */
+					reg = <0xd401e1fc 0x04>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <104 1>;
+				};
+				range5: range at d401e1f8 {
+					/* GPIO105 */
+					reg = <0xd401e1f8 0x04>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <105 1>;
+				};
+				range6: range at d401e1f4 {
+					/* GPIO106 */
+					reg = <0xd401e1f4 0x04>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <106 1>;
+				};
+				range7: range at d401e1f0 {
+					/* GPIO107 */
+					reg = <0xd401e1f0 0x04>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <107 1>;
+				};
+				range8: range at d401e21c {
+					/* GPIO108 */
+					reg = <0xd401e21c 0x04>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <108 1>;
+				};
+				range9: range at d401e218 {
+					/* GPIO109 */
+					reg = <0xd401e218 0x04>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <109 1>;
+				};
+				range10: range at d401e214 {
+					/* GPIO110 */
+					reg = <0xd401e214 0x04>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <110 1>;
+				};
+				range11: range at d401e200 {
+					/* GPIO111 */
+					reg = <0xd401e200 0x04>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <111 1>;
+				};
+				range12: range at d401e244 {
+					/* GPIO112 */
+					reg = <0xd401e244 0x04>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <112 1>;
+				};
+				range13: range at d401e25c {
+					/* GPIO113 */
+					reg = <0xd401e25c 0x04>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <113 1>;
+				};
+				range14: range at d401e164 {
+					/* GPIO114 */
+					reg = <0xd401e164 0x04>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <114 0>;
+				};
+				range15: range at d401e260 {
+					/* GPIO115 ~ GPIO122 */
+					reg = <0xd401e260 0x20>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <115 0>;
+				};
+				range16: range at d401e148 {
+					/* GPIO123 */
+					reg = <0xd401e148 0x04>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <123 0>;
+				};
+				range17: range at d401e00c {
+					/* GPIO124 ~ GPIO141 */
+					reg = <0xd401e00c 0x48>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <124 0>;
+				};
+				range18: range at d401e008 {
+					/* GPIO142 */
+					reg = <0xd401e008 0x04>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <142 1>;
+				};
+				range19: range at d401e220 {
+					/* GPIO143 ~ GPIO151 */
+					reg = <0xd401e220 0x24>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <143 1>;
+				};
+				range20: range at d401e248 {
+					/* GPIO152 ~ GPIO153 */
+					reg = <0xd401e248 0x08>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <152 1>;
+				};
+				range21: range at d401e254 {
+					/* GPIO154 ~ GPIO155 */
+					reg = <0xd401e254 0x08>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <154 1>;
+				};
+				range22: range at d401e14c {
+					/* GPIO156 ~ GPIO159 */
+					reg = <0xd401e14c 0x10>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <156 1>;
+				};
+				range23: range at d401e250 {
+					/* GPIO160 */
+					reg = <0xd401e250 0x04>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <160 1>;
+				};
+				range24: range at d401e210 {
+					/* GPIO161 */
+					reg = <0xd401e210 0x04>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <161 1>;
+				};
+				range25: range at d401e20c {
+					/* GPIO162 */
+					reg = <0xd401e20c 0x04>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <162 1>;
+				};
+				range26: range at d401e208 {
+					/* GPIO163 */
+					reg = <0xd401e208 0x04>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <163 1>;
+				};
+				range27: range at d401e204 {
+					/* GPIO164 */
+					reg = <0xd401e204 0x04>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <164 1>;
+				};
+				range28: range at d401e1ec {
+					/* GPIO165 */
+					reg = <0xd401e1ec 0x04>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <165 1>;
+				};
+				range29: range at d401e1e8 {
+					/* GPIO166 */
+					reg = <0xd401e1e8 0x04>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <166 1>;
+				};
+				range30: range at d401e1e4 {
+					/* GPIO167 */
+					reg = <0xd401e1e4 0x04>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <167 1>;
+				};
+				range31: range at d401e1e0 {
+					/* GPIO168 */
+					reg = <0xd401e1e0 0x04>;
+					/* gpio base & gpio func */
+					pinctrl-single,gpio = <168 1>;
+				};
+			};
+
 			timer0: timer at d4014000 {
 				compatible = "mrvl,mmp-timer";
 				reg = <0xd4014000 0x100>;
-- 
1.7.10.4
