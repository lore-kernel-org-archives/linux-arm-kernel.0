From: guodong.xu@linaro.org (Guodong Xu)
Date: Wed, 13 Apr 2016 07:55:41 +0800
Subject: [PATCH v4 05/16] arm64: dts: add Hi6220 pinctrl configuration nodes
In-Reply-To: <1460505352-13157-1-git-send-email-guodong.xu@linaro.org>
References: <1460505352-13157-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <1460505352-13157-6-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhong Kaihua <zhongkaihua@huawei.com>

Add Hi6220 pinctrl configuration nodes

Signed-off-by: Zhong Kaihua <zhongkaihua@huawei.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Haojian Zhuang <haojian.zhuang@linaro.org>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts   |   1 +
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi        |  77 +++
 arch/arm64/boot/dts/hisilicon/hikey-pinctrl.dtsi | 684 +++++++++++++++++++++++
 include/dt-bindings/pinctrl/hisi.h               |  59 ++
 4 files changed, 821 insertions(+)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hikey-pinctrl.dtsi
 create mode 100644 include/dt-bindings/pinctrl/hisi.h

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index 17bd793..3d9e8b2 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "hi6220.dtsi"
+#include "hikey-pinctrl.dtsi"
 
 / {
 	model = "HiKey Development Board";
diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 493bbb0..df56571 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -6,6 +6,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/hi6220-clock.h>
+#include <dt-bindings/pinctrl/hisi.h>
 
 / {
 	compatible = "hisilicon,hi6220";
@@ -252,6 +253,60 @@
 			clock-names = "timer1", "timer2", "apb_pclk";
 		};
 
+		pmx0: pinmux at f7010000 {
+			compatible = "pinctrl-single";
+			reg = <0x0 0xf7010000  0x0 0x27c>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#gpio-range-cells = <3>;
+			pinctrl-single,register-width = <32>;
+			pinctrl-single,function-mask = <7>;
+			pinctrl-single,gpio-range = <
+				&range  80  8 MUX_M0 /* gpio  3: [0..7] */
+				&range  88  8 MUX_M0 /* gpio  4: [0..7] */
+				&range  96  8 MUX_M0 /* gpio  5: [0..7] */
+				&range 104  8 MUX_M0 /* gpio  6: [0..7] */
+				&range 112  8 MUX_M0 /* gpio  7: [0..7] */
+				&range 120  2 MUX_M0 /* gpio  8: [0..1] */
+				&range   2  6 MUX_M1 /* gpio  8: [2..7] */
+				&range   8  8 MUX_M1 /* gpio  9: [0..7] */
+				&range   0  1 MUX_M1 /* gpio 10: [0]    */
+				&range  16  7 MUX_M1 /* gpio 10: [1..7] */
+				&range  23  3 MUX_M1 /* gpio 11: [0..2] */
+				&range  28  5 MUX_M1 /* gpio 11: [3..7] */
+				&range  33  3 MUX_M1 /* gpio 12: [0..2] */
+				&range  43  5 MUX_M1 /* gpio 12: [3..7] */
+				&range  48  8 MUX_M1 /* gpio 13: [0..7] */
+				&range  56  8 MUX_M1 /* gpio 14: [0..7] */
+				&range  74  6 MUX_M1 /* gpio 15: [0..5] */
+				&range 122  1 MUX_M1 /* gpio 15: [6]    */
+				&range 126  1 MUX_M1 /* gpio 15: [7]    */
+				&range 127  8 MUX_M1 /* gpio 16: [0..7] */
+				&range 135  8 MUX_M1 /* gpio 17: [0..7] */
+				&range 143  8 MUX_M1 /* gpio 18: [0..7] */
+				&range 151  8 MUX_M1 /* gpio 19: [0..7] */
+			>;
+			range: gpio-range {
+				#pinctrl-single,gpio-range-cells = <3>;
+			};
+		};
+
+		pmx1: pinmux at f7010800 {
+			compatible = "pinconf-single";
+			reg = <0x0 0xf7010800 0x0 0x28c>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			pinctrl-single,register-width = <32>;
+		};
+
+		pmx2: pinmux at f8001800 {
+			compatible = "pinconf-single";
+			reg = <0x0 0xf8001800 0x0 0x78>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			pinctrl-single,register-width = <32>;
+		};
+
 		gpio0: gpio at f8011000 {
 			compatible = "arm,pl061", "arm,primecell";
 			reg = <0x0 0xf8011000 0x0 0x1000>;
@@ -294,6 +349,7 @@
 			interrupts = <0 55 0x4>;
 			gpio-controller;
 			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 80 8>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			clocks = <&ao_ctrl 2>;
@@ -306,6 +362,7 @@
 			interrupts = <0 56 0x4>;
 			gpio-controller;
 			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 88 8>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			clocks = <&ao_ctrl 2>;
@@ -318,6 +375,7 @@
 			interrupts = <0 57 0x4>;
 			gpio-controller;
 			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 96 8>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			clocks = <&ao_ctrl 2>;
@@ -330,6 +388,7 @@
 			interrupts = <0 58 0x4>;
 			gpio-controller;
 			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 104 8>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			clocks = <&ao_ctrl 2>;
@@ -342,6 +401,7 @@
 			interrupts = <0 59 0x4>;
 			gpio-controller;
 			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 112 8>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			clocks = <&ao_ctrl 2>;
@@ -354,6 +414,7 @@
 			interrupts = <0 60 0x4>;
 			gpio-controller;
 			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 120 2 &pmx0 2 2 6>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			clocks = <&ao_ctrl 2>;
@@ -366,6 +427,7 @@
 			interrupts = <0 61 0x4>;
 			gpio-controller;
 			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 8 8>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			clocks = <&ao_ctrl 2>;
@@ -378,6 +440,7 @@
 			interrupts = <0 62 0x4>;
 			gpio-controller;
 			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 0 1 &pmx0 1 16 7>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			clocks = <&ao_ctrl 2>;
@@ -390,6 +453,7 @@
 			interrupts = <0 63 0x4>;
 			gpio-controller;
 			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 23 3 &pmx0 3 28 5>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			clocks = <&ao_ctrl 2>;
@@ -402,6 +466,7 @@
 			interrupts = <0 64 0x4>;
 			gpio-controller;
 			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 33 3 &pmx0 3 43 5>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			clocks = <&ao_ctrl 2>;
@@ -413,6 +478,8 @@
 			reg = <0x0 0xf7029000 0x0 0x1000>;
 			interrupts = <0 65 0x4>;
 			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 48 8>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			clocks = <&ao_ctrl 2>;
@@ -425,6 +492,7 @@
 			interrupts = <0 66 0x4>;
 			gpio-controller;
 			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 56 8>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			clocks = <&ao_ctrl 2>;
@@ -437,6 +505,11 @@
 			interrupts = <0 67 0x4>;
 			gpio-controller;
 			#gpio-cells = <2>;
+			gpio-ranges = <
+				&pmx0 0 74 6
+				&pmx0 6 122 1
+				&pmx0 7 126 1
+			>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			clocks = <&ao_ctrl 2>;
@@ -449,6 +522,7 @@
 			interrupts = <0 68 0x4>;
 			gpio-controller;
 			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 127 8>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			clocks = <&ao_ctrl 2>;
@@ -461,6 +535,7 @@
 			interrupts = <0 69 0x4>;
 			gpio-controller;
 			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 135 8>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			clocks = <&ao_ctrl 2>;
@@ -473,6 +548,7 @@
 			interrupts = <0 70 0x4>;
 			gpio-controller;
 			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 143 8>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			clocks = <&ao_ctrl 2>;
@@ -485,6 +561,7 @@
 			interrupts = <0 71 0x4>;
 			gpio-controller;
 			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 151 8>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			clocks = <&ao_ctrl 2>;
diff --git a/arch/arm64/boot/dts/hisilicon/hikey-pinctrl.dtsi b/arch/arm64/boot/dts/hisilicon/hikey-pinctrl.dtsi
new file mode 100644
index 0000000..28806df
--- /dev/null
+++ b/arch/arm64/boot/dts/hisilicon/hikey-pinctrl.dtsi
@@ -0,0 +1,684 @@
+/*
+ * pinctrl dts fils for Hislicon HiKey development board
+ *
+ */
+#include <dt-bindings/pinctrl/hisi.h>
+
+/ {
+	soc {
+		pmx0: pinmux at f7010000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <
+				&boot_sel_pmx_func
+				&hkadc_ssi_pmx_func
+				&codec_clk_pmx_func
+				&pwm_in_pmx_func
+				&bl_pwm_pmx_func
+				>;
+
+			boot_sel_pmx_func: boot_sel_pmx_func {
+				pinctrl-single,pins = <
+					0x0    MUX_M0	/* BOOT_SEL     (IOMG000) */
+				>;
+			};
+
+			emmc_pmx_func: emmc_pmx_func {
+				pinctrl-single,pins = <
+					0x100  MUX_M0	/* EMMC_CLK     (IOMG064) */
+					0x104  MUX_M0	/* EMMC_CMD     (IOMG065) */
+					0x108  MUX_M0	/* EMMC_DATA0   (IOMG066) */
+					0x10c  MUX_M0	/* EMMC_DATA1   (IOMG067) */
+					0x110  MUX_M0	/* EMMC_DATA2   (IOMG068) */
+					0x114  MUX_M0	/* EMMC_DATA3   (IOMG069) */
+					0x118  MUX_M0	/* EMMC_DATA4   (IOMG070) */
+					0x11c  MUX_M0	/* EMMC_DATA5   (IOMG071) */
+					0x120  MUX_M0	/* EMMC_DATA6   (IOMG072) */
+					0x124  MUX_M0	/* EMMC_DATA7   (IOMG073) */
+				>;
+			};
+
+			sd_pmx_func: sd_pmx_func {
+				pinctrl-single,pins = <
+					0xc    MUX_M0	/* SD_CLK       (IOMG003) */
+					0x10   MUX_M0	/* SD_CMD       (IOMG004) */
+					0x14   MUX_M0	/* SD_DATA0     (IOMG005) */
+					0x18   MUX_M0	/* SD_DATA1     (IOMG006) */
+					0x1c   MUX_M0	/* SD_DATA2     (IOMG007) */
+					0x20   MUX_M0	/* SD_DATA3     (IOMG008) */
+				>;
+			};
+			sd_pmx_idle: sd_pmx_idle {
+				pinctrl-single,pins = <
+					0xc    MUX_M1	/* SD_CLK       (IOMG003) */
+					0x10   MUX_M1	/* SD_CMD       (IOMG004) */
+					0x14   MUX_M1	/* SD_DATA0     (IOMG005) */
+					0x18   MUX_M1	/* SD_DATA1     (IOMG006) */
+					0x1c   MUX_M1	/* SD_DATA2     (IOMG007) */
+					0x20   MUX_M1	/* SD_DATA3     (IOMG008) */
+				>;
+			};
+
+			sdio_pmx_func: sdio_pmx_func {
+				pinctrl-single,pins = <
+					0x128  MUX_M0	/* SDIO_CLK     (IOMG074) */
+					0x12c  MUX_M0	/* SDIO_CMD     (IOMG075) */
+					0x130  MUX_M0	/* SDIO_DATA0   (IOMG076) */
+					0x134  MUX_M0	/* SDIO_DATA1   (IOMG077) */
+					0x138  MUX_M0	/* SDIO_DATA2   (IOMG078) */
+					0x13c  MUX_M0	/* SDIO_DATA3   (IOMG079) */
+				>;
+			};
+			sdio_pmx_idle: sdio_pmx_idle {
+				pinctrl-single,pins = <
+					0x128  MUX_M1	/* SDIO_CLK     (IOMG074) */
+					0x12c  MUX_M1	/* SDIO_CMD     (IOMG075) */
+					0x130  MUX_M1	/* SDIO_DATA0   (IOMG076) */
+					0x134  MUX_M1	/* SDIO_DATA1   (IOMG077) */
+					0x138  MUX_M1	/* SDIO_DATA2   (IOMG078) */
+					0x13c  MUX_M1	/* SDIO_DATA3   (IOMG079) */
+				>;
+			};
+
+			isp_pmx_func: isp_pmx_func {
+				pinctrl-single,pins = <
+					0x24   MUX_M0	/* ISP_PWDN0    (IOMG009) */
+					0x28   MUX_M0	/* ISP_PWDN1    (IOMG010) */
+					0x2c   MUX_M0	/* ISP_PWDN2    (IOMG011) */
+					0x30   MUX_M1	/* ISP_SHUTTER0 (IOMG012) */
+					0x34   MUX_M1	/* ISP_SHUTTER1 (IOMG013) */
+					0x38   MUX_M1	/* ISP_PWM      (IOMG014) */
+					0x3c   MUX_M0	/* ISP_CCLK0    (IOMG015) */
+					0x40   MUX_M0	/* ISP_CCLK1    (IOMG016) */
+					0x44   MUX_M0	/* ISP_RESETB0  (IOMG017) */
+					0x48   MUX_M0	/* ISP_RESETB1  (IOMG018) */
+					0x4c   MUX_M1	/* ISP_STROBE0  (IOMG019) */
+					0x50   MUX_M1	/* ISP_STROBE1  (IOMG020) */
+					0x54   MUX_M0	/* ISP_SDA0     (IOMG021) */
+					0x58   MUX_M0	/* ISP_SCL0     (IOMG022) */
+					0x5c   MUX_M0	/* ISP_SDA1     (IOMG023) */
+					0x60   MUX_M0	/* ISP_SCL1     (IOMG024) */
+				>;
+			};
+
+			hkadc_ssi_pmx_func: hkadc_ssi_pmx_func {
+				pinctrl-single,pins = <
+					0x68   MUX_M0	/* HKADC_SSI    (IOMG026) */
+				>;
+			};
+
+			codec_clk_pmx_func: codec_clk_pmx_func {
+				pinctrl-single,pins = <
+					0x6c   MUX_M0	/* CODEC_CLK    (IOMG027) */
+				>;
+			};
+
+			codec_pmx_func: codec_pmx_func {
+				pinctrl-single,pins = <
+					0x70   MUX_M1	/* DMIC_CLK     (IOMG028) */
+					0x74   MUX_M0	/* CODEC_SYNC   (IOMG029) */
+					0x78   MUX_M0	/* CODEC_DI     (IOMG030) */
+					0x7c   MUX_M0	/* CODEC_DO     (IOMG031) */
+				>;
+			};
+
+			fm_pmx_func: fm_pmx_func {
+				pinctrl-single,pins = <
+					0x80   MUX_M1	/* FM_XCLK      (IOMG032) */
+					0x84   MUX_M1	/* FM_XFS       (IOMG033) */
+					0x88   MUX_M1	/* FM_DI        (IOMG034) */
+					0x8c   MUX_M1	/* FM_DO        (IOMG035) */
+				>;
+			};
+
+			bt_pmx_func: bt_pmx_func {
+				pinctrl-single,pins = <
+					0x90   MUX_M0	/* BT_XCLK      (IOMG036) */
+					0x94   MUX_M0	/* BT_XFS       (IOMG037) */
+					0x98   MUX_M0	/* BT_DI        (IOMG038) */
+					0x9c   MUX_M0	/* BT_DO        (IOMG039) */
+				>;
+			};
+
+			pwm_in_pmx_func: pwm_in_pmx_func {
+				pinctrl-single,pins = <
+					0xb8   MUX_M1	/* PWM_IN       (IOMG046) */
+				>;
+			};
+
+			bl_pwm_pmx_func: bl_pwm_pmx_func {
+				pinctrl-single,pins = <
+					0xbc   MUX_M1	/* BL_PWM       (IOMG047) */
+				>;
+			};
+
+			uart0_pmx_func: uart0_pmx_func {
+				pinctrl-single,pins = <
+					0xc0   MUX_M0	/* UART0_RXD    (IOMG048) */
+					0xc4   MUX_M0	/* UART0_TXD    (IOMG049) */
+				>;
+			};
+
+			uart1_pmx_func: uart1_pmx_func {
+				pinctrl-single,pins = <
+					0xc8   MUX_M0	/* UART1_CTS_N  (IOMG050) */
+					0xcc   MUX_M0	/* UART1_RTS_N  (IOMG051) */
+					0xd0   MUX_M0	/* UART1_RXD    (IOMG052) */
+					0xd4   MUX_M0	/* UART1_TXD    (IOMG053) */
+				>;
+			};
+
+			uart2_pmx_func: uart2_pmx_func {
+				pinctrl-single,pins = <
+					0xd8   MUX_M0	/* UART2_CTS_N  (IOMG054) */
+					0xdc   MUX_M0	/* UART2_RTS_N  (IOMG055) */
+					0xe0   MUX_M0	/* UART2_RXD    (IOMG056) */
+					0xe4   MUX_M0	/* UART2_TXD    (IOMG057) */
+				>;
+			};
+
+			uart3_pmx_func: uart3_pmx_func {
+				pinctrl-single,pins = <
+					0x180  MUX_M1	/* UART3_CTS_N  (IOMG096) */
+					0x184  MUX_M1	/* UART3_RTS_N  (IOMG097) */
+					0x188  MUX_M1	/* UART3_RXD    (IOMG098) */
+					0x18c  MUX_M1	/* UART3_TXD    (IOMG099) */
+				>;
+			};
+
+			uart4_pmx_func: uart4_pmx_func {
+				pinctrl-single,pins = <
+					0x1d0  MUX_M1	/* UART4_CTS_N  (IOMG116) */
+					0x1d4  MUX_M1	/* UART4_RTS_N  (IOMG117) */
+					0x1d8  MUX_M1	/* UART4_RXD    (IOMG118) */
+					0x1dc  MUX_M1	/* UART4_TXD    (IOMG119) */
+				>;
+			};
+
+			uart5_pmx_func: uart5_pmx_func {
+				pinctrl-single,pins = <
+					0x1c8  MUX_M1	/* UART5_RXD    (IOMG114) */
+					0x1cc  MUX_M1	/* UART5_TXD    (IOMG115) */
+				>;
+			};
+
+			i2c0_pmx_func: i2c0_pmx_func {
+				pinctrl-single,pins = <
+					0xe8   MUX_M0	/* I2C0_SCL     (IOMG058) */
+					0xec   MUX_M0	/* I2C0_SDA     (IOMG059) */
+				>;
+			};
+
+			i2c1_pmx_func: i2c1_pmx_func {
+				pinctrl-single,pins = <
+					0xf0   MUX_M0	/* I2C1_SCL     (IOMG060) */
+					0xf4   MUX_M0	/* I2C1_SDA     (IOMG061) */
+				>;
+			};
+
+			i2c2_pmx_func: i2c2_pmx_func {
+				pinctrl-single,pins = <
+					0xf8   MUX_M0	/* I2C2_SCL     (IOMG062) */
+					0xfc   MUX_M0	/* I2C2_SDA     (IOMG063) */
+				>;
+			};
+		};
+
+		pmx1: pinmux at f7010800 {
+
+			pinctrl-names = "default";
+			pinctrl-0 = <
+				&boot_sel_cfg_func
+				&hkadc_ssi_cfg_func
+				&codec_clk_cfg_func
+				&pwm_in_cfg_func
+				&bl_pwm_cfg_func
+				>;
+
+			boot_sel_cfg_func: boot_sel_cfg_func {
+				pinctrl-single,pins = <
+					0x0    0x0	/* BOOT_SEL     (IOCFG000) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_UP   PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			hkadc_ssi_cfg_func: hkadc_ssi_cfg_func {
+				pinctrl-single,pins = <
+					0x6c   0x0	/* HKADC_SSI    (IOCFG027) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			emmc_clk_cfg_func: emmc_clk_cfg_func {
+				pinctrl-single,pins = <
+					0x104  0x0	/* EMMC_CLK     (IOCFG065) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_08MA DRIVE_MASK>;
+			};
+
+			emmc_cfg_func: emmc_cfg_func {
+				pinctrl-single,pins = <
+					0x108  0x0	/* EMMC_CMD     (IOCFG066) */
+					0x10c  0x0	/* EMMC_DATA0   (IOCFG067) */
+					0x110  0x0	/* EMMC_DATA1   (IOCFG068) */
+					0x114  0x0	/* EMMC_DATA2   (IOCFG069) */
+					0x118  0x0	/* EMMC_DATA3   (IOCFG070) */
+					0x11c  0x0	/* EMMC_DATA4   (IOCFG071) */
+					0x120  0x0	/* EMMC_DATA5   (IOCFG072) */
+					0x124  0x0	/* EMMC_DATA6   (IOCFG073) */
+					0x128  0x0	/* EMMC_DATA7   (IOCFG074) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_UP   PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_04MA DRIVE_MASK>;
+			};
+
+			emmc_rst_cfg_func: emmc_rst_cfg_func {
+				pinctrl-single,pins = <
+					0x12c  0x0	/* EMMC_RST_N   (IOCFG075) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_04MA DRIVE_MASK>;
+			};
+
+			sd_clk_cfg_func: sd_clk_cfg_func {
+				pinctrl-single,pins = <
+					0xc    0x0	/* SD_CLK       (IOCFG003) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_10MA DRIVE_MASK>;
+			};
+			sd_clk_cfg_idle: sd_clk_cfg_idle {
+				pinctrl-single,pins = <
+					0xc    0x0	/* SD_CLK       (IOCFG003) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DOWN PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			sd_cfg_func: sd_cfg_func {
+				pinctrl-single,pins = <
+					0x10   0x0	/* SD_CMD       (IOCFG004) */
+					0x14   0x0	/* SD_DATA0     (IOCFG005) */
+					0x18   0x0	/* SD_DATA1     (IOCFG006) */
+					0x1c   0x0	/* SD_DATA2     (IOCFG007) */
+					0x20   0x0	/* SD_DATA3     (IOCFG008) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_08MA DRIVE_MASK>;
+			};
+			sd_cfg_idle: sd_cfg_idle {
+				pinctrl-single,pins = <
+					0x10   0x0	/* SD_CMD       (IOCFG004) */
+					0x14   0x0	/* SD_DATA0     (IOCFG005) */
+					0x18   0x0	/* SD_DATA1     (IOCFG006) */
+					0x1c   0x0	/* SD_DATA2     (IOCFG007) */
+					0x20   0x0	/* SD_DATA3     (IOCFG008) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DOWN PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			sdio_clk_cfg_func: sdio_clk_cfg_func {
+				pinctrl-single,pins = <
+					0x134  0x0	/* SDIO_CLK     (IOCFG077) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_08MA DRIVE_MASK>;
+			};
+			sdio_clk_cfg_idle: sdio_clk_cfg_idle {
+				pinctrl-single,pins = <
+					0x134  0x0	/* SDIO_CLK     (IOCFG077) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DOWN PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			sdio_cfg_func: sdio_cfg_func {
+				pinctrl-single,pins = <
+					0x138  0x0	/* SDIO_CMD     (IOCFG078) */
+					0x13c  0x0	/* SDIO_DATA0   (IOCFG079) */
+					0x140  0x0	/* SDIO_DATA1   (IOCFG080) */
+					0x144  0x0	/* SDIO_DATA2   (IOCFG081) */
+					0x148  0x0	/* SDIO_DATA3   (IOCFG082) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_UP   PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_04MA DRIVE_MASK>;
+			};
+			sdio_cfg_idle: sdio_cfg_idle {
+				pinctrl-single,pins = <
+					0x138  0x0	/* SDIO_CMD     (IOCFG078) */
+					0x13c  0x0	/* SDIO_DATA0   (IOCFG079) */
+					0x140  0x0	/* SDIO_DATA1   (IOCFG080) */
+					0x144  0x0	/* SDIO_DATA2   (IOCFG081) */
+					0x148  0x0	/* SDIO_DATA3   (IOCFG082) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_UP   PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			isp_cfg_func1: isp_cfg_func1 {
+				pinctrl-single,pins = <
+					0x28   0x0	/* ISP_PWDN0    (IOCFG010) */
+					0x2c   0x0	/* ISP_PWDN1    (IOCFG011) */
+					0x30   0x0	/* ISP_PWDN2    (IOCFG012) */
+					0x34   0x0	/* ISP_SHUTTER0 (IOCFG013) */
+					0x38   0x0	/* ISP_SHUTTER1 (IOCFG014) */
+					0x3c   0x0	/* ISP_PWM      (IOCFG015) */
+					0x40   0x0	/* ISP_CCLK0    (IOCFG016) */
+					0x44   0x0	/* ISP_CCLK1    (IOCFG017) */
+					0x48   0x0	/* ISP_RESETB0  (IOCFG018) */
+					0x4c   0x0	/* ISP_RESETB1  (IOCFG019) */
+					0x50   0x0	/* ISP_STROBE0  (IOCFG020) */
+					0x58   0x0	/* ISP_SDA0     (IOCFG022) */
+					0x5c   0x0	/* ISP_SCL0     (IOCFG023) */
+					0x60   0x0	/* ISP_SDA1     (IOCFG024) */
+					0x64   0x0	/* ISP_SCL1     (IOCFG025) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_02MA DRIVE_MASK>;
+			};
+			isp_cfg_idle1: isp_cfg_idle1 {
+				pinctrl-single,pins = <
+					0x34   0x0	/* ISP_SHUTTER0 (IOCFG013) */
+					0x38   0x0	/* ISP_SHUTTER1 (IOCFG014) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DOWN PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			isp_cfg_func2: isp_cfg_func2 {
+				pinctrl-single,pins = <
+					0x54   0x0	/* ISP_STROBE1  (IOCFG021) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DOWN PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			codec_clk_cfg_func: codec_clk_cfg_func {
+				pinctrl-single,pins = <
+					0x70   0x0	/* CODEC_CLK    (IOCFG028) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_04MA DRIVE_MASK>;
+			};
+			codec_clk_cfg_idle: codec_clk_cfg_idle {
+				pinctrl-single,pins = <
+					0x70   0x0	/* CODEC_CLK    (IOCFG028) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			codec_cfg_func1: codec_cfg_func1 {
+				pinctrl-single,pins = <
+					0x74   0x0	/* DMIC_CLK     (IOCFG029) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DOWN PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			codec_cfg_func2: codec_cfg_func2 {
+				pinctrl-single,pins = <
+					0x78   0x0	/* CODEC_SYNC   (IOCFG030) */
+					0x7c   0x0	/* CODEC_DI     (IOCFG031) */
+					0x80   0x0	/* CODEC_DO     (IOCFG032) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_04MA DRIVE_MASK>;
+			};
+			codec_cfg_idle2: codec_cfg_idle2 {
+				pinctrl-single,pins = <
+					0x78   0x0	/* CODEC_SYNC   (IOCFG030) */
+					0x7c   0x0	/* CODEC_DI     (IOCFG031) */
+					0x80   0x0	/* CODEC_DO     (IOCFG032) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			fm_cfg_func: fm_cfg_func {
+				pinctrl-single,pins = <
+					0x84   0x0	/* FM_XCLK      (IOCFG033) */
+					0x88   0x0	/* FM_XFS       (IOCFG034) */
+					0x8c   0x0	/* FM_DI        (IOCFG035) */
+					0x90   0x0	/* FM_DO        (IOCFG036) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DOWN PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			bt_cfg_func: bt_cfg_func {
+				pinctrl-single,pins = <
+					0x94   0x0	/* BT_XCLK      (IOCFG037) */
+					0x98   0x0	/* BT_XFS       (IOCFG038) */
+					0x9c   0x0	/* BT_DI        (IOCFG039) */
+					0xa0   0x0	/* BT_DO        (IOCFG040) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_02MA DRIVE_MASK>;
+			};
+			bt_cfg_idle: bt_cfg_idle {
+				pinctrl-single,pins = <
+					0x94   0x0	/* BT_XCLK      (IOCFG037) */
+					0x98   0x0	/* BT_XFS       (IOCFG038) */
+					0x9c   0x0	/* BT_DI        (IOCFG039) */
+					0xa0   0x0	/* BT_DO        (IOCFG040) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DOWN PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			pwm_in_cfg_func: pwm_in_cfg_func {
+				pinctrl-single,pins = <
+					0xbc   0x0	/* PWM_IN       (IOCFG047) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DOWN PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			bl_pwm_cfg_func: bl_pwm_cfg_func {
+				pinctrl-single,pins = <
+					0xc0   0x0	/* BL_PWM       (IOCFG048) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DOWN PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			uart0_cfg_func1: uart0_cfg_func1 {
+				pinctrl-single,pins = <
+					0xc4   0x0	/* UART0_RXD    (IOCFG049) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_UP   PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			uart0_cfg_func2: uart0_cfg_func2 {
+				pinctrl-single,pins = <
+					0xc8   0x0	/* UART0_TXD    (IOCFG050) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_04MA DRIVE_MASK>;
+			};
+
+			uart1_cfg_func1: uart1_cfg_func1 {
+				pinctrl-single,pins = <
+					0xcc   0x0	/* UART1_CTS_N  (IOCFG051) */
+					0xd4   0x0	/* UART1_RXD    (IOCFG053) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_UP   PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			uart1_cfg_func2: uart1_cfg_func2 {
+				pinctrl-single,pins = <
+					0xd0   0x0	/* UART1_RTS_N  (IOCFG052) */
+					0xd8   0x0	/* UART1_TXD    (IOCFG054) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			uart2_cfg_func: uart2_cfg_func {
+				pinctrl-single,pins = <
+					0xdc   0x0	/* UART2_CTS_N  (IOCFG055) */
+					0xe0   0x0	/* UART2_RTS_N  (IOCFG056) */
+					0xe4   0x0	/* UART2_RXD    (IOCFG057) */
+					0xe8   0x0	/* UART2_TXD    (IOCFG058) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			uart3_cfg_func: uart3_cfg_func {
+				pinctrl-single,pins = <
+					0x190  0x0	/* UART3_CTS_N  (IOCFG100) */
+					0x194  0x0	/* UART3_RTS_N  (IOCFG101) */
+					0x198  0x0	/* UART3_RXD    (IOCFG102) */
+					0x19c  0x0	/* UART3_TXD    (IOCFG103) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DOWN PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			uart4_cfg_func: uart4_cfg_func {
+				pinctrl-single,pins = <
+					0x1e0  0x0	/* UART4_CTS_N  (IOCFG120) */
+					0x1e4  0x0	/* UART4_RTS_N  (IOCFG121) */
+					0x1e8  0x0	/* UART4_RXD    (IOCFG122) */
+					0x1ec  0x0	/* UART4_TXD    (IOCFG123) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DOWN PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			uart5_cfg_func: uart5_cfg_func {
+				pinctrl-single,pins = <
+					0x1d8  0x0	/* UART4_RXD    (IOCFG118) */
+					0x1dc  0x0	/* UART4_TXD    (IOCFG119) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DOWN PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			i2c0_cfg_func: i2c0_cfg_func {
+				pinctrl-single,pins = <
+					0xec   0x0	/* I2C0_SCL     (IOCFG059) */
+					0xf0   0x0	/* I2C0_SDA     (IOCFG060) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			i2c1_cfg_func: i2c1_cfg_func {
+				pinctrl-single,pins = <
+					0xf4   0x0	/* I2C1_SCL     (IOCFG061) */
+					0xf8   0x0	/* I2C1_SDA     (IOCFG062) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			i2c2_cfg_func: i2c2_cfg_func {
+				pinctrl-single,pins = <
+					0xfc   0x0	/* I2C2_SCL     (IOCFG063) */
+					0x100  0x0	/* I2C2_SDA     (IOCFG064) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_02MA DRIVE_MASK>;
+			};
+		};
+
+		pmx2: pinmux at f8001800 {
+
+			pinctrl-names = "default";
+			pinctrl-0 = <
+				&rstout_n_cfg_func
+				>;
+
+			rstout_n_cfg_func: rstout_n_cfg_func {
+				pinctrl-single,pins = <
+					0x0    0x0	/* RSTOUT_N     (IOCFG000) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			pmu_peri_en_cfg_func: pmu_peri_en_cfg_func {
+				pinctrl-single,pins = <
+					0x4    0x0	/* PMU_PERI_EN  (IOCFG001) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			sysclk0_en_cfg_func: sysclk0_en_cfg_func {
+				pinctrl-single,pins = <
+					0x8    0x0	/* SYSCLK0_EN   (IOCFG002) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			jtag_tdo_cfg_func: jtag_tdo_cfg_func {
+				pinctrl-single,pins = <
+					0xc    0x0	/* JTAG_TDO     (IOCFG003) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_08MA DRIVE_MASK>;
+			};
+
+			rf_reset_cfg_func: rf_reset_cfg_func {
+				pinctrl-single,pins = <
+					0x70   0x0	/* RF_RESET0    (IOCFG028) */
+					0x74   0x0	/* RF_RESET1    (IOCFG029) */
+				>;
+				pinctrl-single,bias-pulldown  = <PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    = <PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength = <DRIVE1_02MA DRIVE_MASK>;
+			};
+		};
+	};
+};
diff --git a/include/dt-bindings/pinctrl/hisi.h b/include/dt-bindings/pinctrl/hisi.h
new file mode 100644
index 0000000..38f1ea8
--- /dev/null
+++ b/include/dt-bindings/pinctrl/hisi.h
@@ -0,0 +1,59 @@
+/*
+ * This header provides constants for hisilicon pinctrl bindings.
+ *
+ * Copyright (c) 2015 Hisilicon Limited.
+ * Copyright (c) 2015 Linaro Limited.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _DT_BINDINGS_PINCTRL_HISI_H
+#define _DT_BINDINGS_PINCTRL_HISI_H
+
+/* iomg bit definition */
+#define MUX_M0		0
+#define MUX_M1		1
+#define MUX_M2		2
+#define MUX_M3		3
+#define MUX_M4		4
+#define MUX_M5		5
+#define MUX_M6		6
+#define MUX_M7		7
+
+/* iocg bit definition */
+#define PULL_MASK	(3)
+#define PULL_DIS	(0)
+#define PULL_UP		(1 << 0)
+#define PULL_DOWN	(1 << 1)
+
+/* drive strength definition */
+#define DRIVE_MASK	(7 << 4)
+#define DRIVE1_02MA	(0 << 4)
+#define DRIVE1_04MA	(1 << 4)
+#define DRIVE1_08MA	(2 << 4)
+#define DRIVE1_10MA	(3 << 4)
+#define DRIVE2_02MA	(0 << 4)
+#define DRIVE2_04MA	(1 << 4)
+#define DRIVE2_08MA	(2 << 4)
+#define DRIVE2_10MA	(3 << 4)
+#define DRIVE3_04MA	(0 << 4)
+#define DRIVE3_08MA	(1 << 4)
+#define DRIVE3_12MA	(2 << 4)
+#define DRIVE3_16MA	(3 << 4)
+#define DRIVE3_20MA	(4 << 4)
+#define DRIVE3_24MA	(5 << 4)
+#define DRIVE3_32MA	(6 << 4)
+#define DRIVE3_40MA	(7 << 4)
+#define DRIVE4_02MA	(0 << 4)
+#define DRIVE4_04MA	(2 << 4)
+#define DRIVE4_08MA	(4 << 4)
+#define DRIVE4_10MA	(6 << 4)
+
+#endif
-- 
1.9.1
