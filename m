From: xuejiancheng@hisilicon.com (Jiancheng Xue)
Date: Wed, 18 Oct 2017 07:22:07 -0400
Subject: [PATCH 2/3] arm64: dts: hisilicon: add pinctrl nodes for
 hi3798cv200-poplar board
In-Reply-To: <1508325728-55823-1-git-send-email-xuejiancheng@hisilicon.com>
References: <1508325728-55823-1-git-send-email-xuejiancheng@hisilicon.com>
Message-ID: <1508325728-55823-3-git-send-email-xuejiancheng@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Younian Wang <wangyounian@hisilicon.com>

Add pinctrl nodes for hi3798cv200-poplar board

Signed-off-by: Younian Wang <wangyounian@hisilicon.com>
Signed-off-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
---
 .../boot/dts/hisilicon/hi3798cv200-poplar.dts      |   1 +
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi     |  71 +++
 arch/arm64/boot/dts/hisilicon/poplar-pinctrl.dtsi  | 651 +++++++++++++++++++++
 3 files changed, 723 insertions(+)
 create mode 100644 arch/arm64/boot/dts/hisilicon/poplar-pinctrl.dtsi

diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
index b914287..6a0b7e9 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
@@ -11,6 +11,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include "hi3798cv200.dtsi"
+#include "poplar-pinctrl.dtsi"
 
 / {
 	model = "HiSilicon Poplar Development Board";
diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
index 0d11dc7..5a73c68 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
@@ -106,6 +106,54 @@
 			#reset-cells = <2>;
 		};
 
+		pmx0: pinconf at 8a21000 {
+			compatible = "pinconf-single";
+			reg = <0x8a21000 0x180>;
+			pinctrl-single,register-width = <32>;
+			pinctrl-single,function-mask = <7>;
+			pinctrl-single,gpio-range = <
+				&range 0  8 2  /* GPIO 0 */
+				&range 8  1 0  /* GPIO 1 */
+				&range 9  4 2
+				&range 13 1 0
+				&range 14 1 1
+				&range 15 1 0
+				&range 16 5 0  /* GPIO 2 */
+				&range 21 3 1
+				&range 24 4 1  /* GPIO 3 */
+				&range 28 2 2
+				&range 86 1 1
+				&range 87 1 0
+				&range 30 4 2  /* GPIO 4 */
+				&range 34 3 0
+				&range 37 1 2
+				&range 38 3 2  /* GPIO 6 */
+				&range 41 5 0
+				&range 46 8 1  /* GPIO 7 */
+				&range 54 8 1  /* GPIO 8 */
+				&range 64 7 1  /* GPIO 9 */
+				&range 71 1 0
+				&range 72 6 1  /* GPIO 10 */
+				&range 78 1 0
+				&range 79 1 1
+				&range 80 6 1  /* GPIO 11 */
+				&range 70 2 1
+				&range 88 8 0  /* GPIO 12 */
+			>;
+
+			range: gpio-range {
+				#pinctrl-single,gpio-range-cells = <3>;
+			};
+		};
+
+		pmx1: pinconf at 8000044 {
+			compatible = "pinctrl-single";
+			reg = <0x8000044 4>;
+			pinctrl-single,register-width = <32>;
+			pinctrl-single,function-mask = <1>;
+			pinctrl-single,bit-per-mux;
+		};
+
 		uart0: serial at 8b00000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x8b00000 0x1000>;
@@ -209,6 +257,7 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			gpio-ranges = <&pmx0 0 0 8>;
 			clocks = <&crg HISTB_APB_CLK>;
 			clock-names = "apb_pclk";
 			status = "disabled";
@@ -222,6 +271,13 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			gpio-ranges = <
+				&pmx0 0 8 1
+				&pmx0 1 9 4
+				&pmx0 5 13 1
+				&pmx0 6 14 1
+				&pmx0 7 15 1
+			>;
 			clocks = <&crg HISTB_APB_CLK>;
 			clock-names = "apb_pclk";
 			status = "disabled";
@@ -235,6 +291,7 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			gpio-ranges = <&pmx0 0 16 5 &pmx0 5 21 3>;
 			clocks = <&crg HISTB_APB_CLK>;
 			clock-names = "apb_pclk";
 			status = "disabled";
@@ -248,6 +305,12 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			gpio-ranges = <
+				&pmx0 0 24 4
+				&pmx0 4 28 2
+				&pmx0 6 86 1
+				&pmx0 7 87 1
+			>;
 			clocks = <&crg HISTB_APB_CLK>;
 			clock-names = "apb_pclk";
 			status = "disabled";
@@ -261,6 +324,7 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			gpio-ranges = <&pmx0 0 30 4 &pmx0 4 34 3 &pmx0 7 37 1>;
 			clocks = <&crg HISTB_APB_CLK>;
 			clock-names = "apb_pclk";
 			status = "disabled";
@@ -287,6 +351,7 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			gpio-ranges = <&pmx0 0 38 3 &pmx0 0 41 5>;
 			clocks = <&crg HISTB_APB_CLK>;
 			clock-names = "apb_pclk";
 			status = "disabled";
@@ -300,6 +365,7 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			gpio-ranges = <&pmx0 0 46 8>;
 			clocks = <&crg HISTB_APB_CLK>;
 			clock-names = "apb_pclk";
 			status = "disabled";
@@ -313,6 +379,7 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			gpio-ranges = <&pmx0 0 54 8>;
 			clocks = <&crg HISTB_APB_CLK>;
 			clock-names = "apb_pclk";
 			status = "disabled";
@@ -326,6 +393,7 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			gpio-ranges = <&pmx0 0 64 7 &pmx0 71 1>;
 			clocks = <&crg HISTB_APB_CLK>;
 			clock-names = "apb_pclk";
 			status = "disabled";
@@ -339,6 +407,7 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			gpio-ranges = <&pmx0 0 72 6 &pmx0 6 78 1 &pmx0 7 79 1>;
 			clocks = <&crg HISTB_APB_CLK>;
 			clock-names = "apb_pclk";
 			status = "disabled";
@@ -352,6 +421,7 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			gpio-ranges = <&pmx0 0 80 6 &pmx0 6 70 2>;
 			clocks = <&crg HISTB_APB_CLK>;
 			clock-names = "apb_pclk";
 			status = "disabled";
@@ -365,6 +435,7 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			gpio-ranges = <&pmx0 0 88 8>;
 			clocks = <&crg HISTB_APB_CLK>;
 			clock-names = "apb_pclk";
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/hisilicon/poplar-pinctrl.dtsi b/arch/arm64/boot/dts/hisilicon/poplar-pinctrl.dtsi
new file mode 100644
index 0000000..5a87a0e
--- /dev/null
+++ b/arch/arm64/boot/dts/hisilicon/poplar-pinctrl.dtsi
@@ -0,0 +1,651 @@
+/*
+ * pinctrl dts file for HiSilicon poplar board
+ *
+ * Copyright (c) 2016-2017 HiSilicon Technologies Co., Ltd.
+ *
+ * Released under the GPLv2 only.
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include <dt-bindings/pinctrl/hisi.h>
+
+/* value, enable bits, disable bits, mask */
+#define PINCTRL_PULLDOWN(value, enable, disable, mask) \
+	(value << 13) (enable << 13) (disable << 13) (mask << 13)
+#define PINCTRL_PULLUP(value, enable, disable, mask) \
+	(value << 12) (enable << 12) (disable << 12) (mask << 12)
+#define PINCTRL_SLEW_RATE(value, mask)	  (value << 8) (mask << 8)
+#define PINCTRL_DRV_STRENGTH(value, mask) (value << 4) (mask << 4)
+#define GPIO5_MUX_CFG(offset, value, bit) (offset) (value << bit) (1 << bit)
+
+&pmx0 {
+	pinctrl-names = "default";
+		pinctrl-0 = <
+			&emmc_p1_pmx_cfg
+			&emmc_p2_pmx_cfg
+			&emmc_p3_pmx_cfg
+			&emmc_p4_pmx_cfg
+			&gpu_pmx_cfg
+			&sim0_p1_pmx_cfg
+			&sim0_p2_pmx_cfg
+			&i2c0_pmx_cfg
+			&gpio_pmx_cfg
+			&bt_uart2_p1_pmx_cfg
+			&bt_uart2_p2_pmx_cfg
+			&pcm_pmx_cfg
+			&spi0_p1_pmx_cfg
+			&spi0_p2_pmx_cfg
+			&tsi0_p1_pmx_cfg
+			&tsi0_p2_pmx_cfg
+			&tsi0_p3_pmx_cfg
+			&tsi0_p4_pmx_cfg
+			&i2c2_p1_pmx_cfg
+			&i2c2_p2_pmx_cfg
+			&mute_pmx_cfg
+			&spdif_pmx_cfg
+			&rgmii1_p1_pmx_cfg
+			&rgmii1_p2_pmx_cfg
+			&rgmii1_p3_pmx_cfg
+			&sdio0_p1_pmx0_cfg
+			&sdio0_p2_pmx0_cfg
+			&sdio0_p3_pmx0_cfg
+		>;
+
+	emmc_p1_pmx_cfg: emmc_p1_pmx_cfg {
+		pinctrl-single,pins = <
+			0x000 MUX_M2
+			0x004 MUX_M2
+			0x008 MUX_M2
+			0x00c MUX_M2
+			0x010 MUX_M2
+			0x014 MUX_M2
+			0x018 MUX_M2
+			0x01c MUX_M2
+			0x024 MUX_M2
+		>;
+		pinctrl-single,bias-pulldown	= <
+			PINCTRL_PULLDOWN(0, 1, 0, 1)
+		>;
+		pinctrl-single,bias-pullup	= <
+			PINCTRL_PULLUP(0, 1, 0, 1)
+		>;
+		pinctrl-single,slew-rate	= <
+			PINCTRL_SLEW_RATE(1, 1)
+		>;
+		pinctrl-single,drive-strength	= <
+			PINCTRL_DRV_STRENGTH(0xb, 0xf)
+		>;
+	};
+
+	emmc_p2_pmx_cfg: emmc_p2_pmx_cfg {
+		pinctrl-single,pins = <
+			0x028 MUX_M2
+		>;
+		pinctrl-single,bias-pulldown	= <
+			PINCTRL_PULLDOWN(0, 1, 0, 1)
+		>;
+		pinctrl-single,bias-pullup	= <
+			PINCTRL_PULLUP(0, 1, 0, 1)
+		>;
+		pinctrl-single,slew-rate	= <
+			PINCTRL_SLEW_RATE(1, 1)
+		>;
+		pinctrl-single,drive-strength	= <
+			PINCTRL_DRV_STRENGTH(0x9, 0xf)
+		>;
+	};
+
+	emmc_p3_pmx_cfg:emmc_p3_pmx_cfg {
+		pinctrl-single,pins = <
+			0x02c MUX_M2
+		>;
+		pinctrl-single,bias-pulldown	= <
+			PINCTRL_PULLDOWN(0, 1, 0, 1)
+		>;
+		pinctrl-single,bias-pullup	= <
+			PINCTRL_PULLUP(0, 1, 0, 1)
+		>;
+		pinctrl-single,slew-rate	= <
+			PINCTRL_SLEW_RATE(1, 1)
+		>;
+		pinctrl-single,drive-strength	= <
+			PINCTRL_DRV_STRENGTH(3, 3)
+		>;
+	};
+
+	emmc_p4_pmx_cfg:emmc_p4_pmx_cfg {
+		pinctrl-single,pins = <
+			0x030 MUX_M2
+		>;
+		pinctrl-single,bias-pulldown	= <
+			PINCTRL_PULLDOWN(1, 1, 0, 1)
+		>;
+		pinctrl-single,bias-pullup	= <
+			PINCTRL_PULLUP(0, 1, 0, 1)
+		>;
+		pinctrl-single,slew-rate	= <
+			PINCTRL_SLEW_RATE(1, 1)
+		>;
+		pinctrl-single,drive-strength	= <
+			PINCTRL_DRV_STRENGTH(3, 3)
+		>;
+	};
+
+	gpu_pmx_cfg: gpu_pmx_cfg {
+		pinctrl-single,pins = <
+			0x038 MUX_M1
+		>;
+		pinctrl-single,bias-pulldown	= <
+			PINCTRL_PULLDOWN(0, 1, 0, 1)
+		>;
+		pinctrl-single,bias-pullup	= <
+			PINCTRL_PULLUP(0, 1, 0, 1)
+		>;
+		pinctrl-single,slew-rate	= <
+			PINCTRL_SLEW_RATE(1, 1)
+		>;
+		pinctrl-single,drive-strength	= <
+			PINCTRL_DRV_STRENGTH(3, 3)
+		>;
+	};
+
+	sim0_p1_pmx_cfg: sim0_p1_pmx_cfg {
+		pinctrl-single,pins = <
+			0x054 MUX_M1
+			0x058 MUX_M1
+			0x05c MUX_M1
+			0x064 MUX_M1
+		>;
+		pinctrl-single,bias-pulldown	= <
+			PINCTRL_PULLDOWN(0, 1, 0, 1)
+		>;
+		pinctrl-single,bias-pullup	= <
+			PINCTRL_PULLUP(0, 1, 0, 1)
+		>;
+		pinctrl-single,slew-rate	= <
+			PINCTRL_SLEW_RATE(1, 1)
+		>;
+		pinctrl-single,drive-strength	= <
+			PINCTRL_DRV_STRENGTH(3, 3)
+		>;
+	};
+
+	sim0_p2_pmx_cfg: sim0_p2_pmx_cfg {
+		pinctrl-single,pins = <
+			0x060 MUX_M1
+		>;
+		pinctrl-single,bias-pulldown	= <
+			PINCTRL_PULLDOWN(0, 1, 0, 1)
+		>;
+		pinctrl-single,bias-pullup	= <
+			PINCTRL_PULLUP(0, 1, 0, 1)
+		>;
+		pinctrl-single,slew-rate	= <
+			PINCTRL_SLEW_RATE(1, 1)
+		>;
+		pinctrl-single,drive-strength	= <
+			PINCTRL_DRV_STRENGTH(2, 3)
+		>;
+	};
+
+	i2c0_pmx_cfg: i2c0_pmx_cfg {
+		pinctrl-single,pins = <
+			0x068 MUX_M1
+			0x06c MUX_M1
+		>;
+		pinctrl-single,bias-pulldown	= <
+			PINCTRL_PULLDOWN(0, 1, 0, 1)
+		>;
+		pinctrl-single,bias-pullup	= <
+			PINCTRL_PULLUP(0, 1, 0, 1)
+		>;
+		pinctrl-single,slew-rate	= <
+			PINCTRL_SLEW_RATE(1, 1)
+		>;
+		pinctrl-single,drive-strength	= <
+			PINCTRL_DRV_STRENGTH(3, 3)
+		>;
+	};
+
+	gpio_pmx_cfg: gpio_pmx_cfg {
+		pinctrl-single,pins = <
+			0x070 MUX_M2
+			0x074 MUX_M2
+		>;
+		pinctrl-single,bias-pulldown	= <
+			PINCTRL_PULLDOWN(0, 1, 0, 1)
+		>;
+		pinctrl-single,bias-pullup	= <
+			PINCTRL_PULLUP(0, 1, 0, 1)
+		>;
+		pinctrl-single,slew-rate	= <
+			PINCTRL_SLEW_RATE(1, 1)
+		>;
+		pinctrl-single,drive-strength	= <
+			PINCTRL_DRV_STRENGTH(3, 3)
+		>;
+	};
+
+	bt_uart2_p1_pmx_cfg: bt_uart2_p1_pmx_cfg {
+		pinctrl-single,pins = <
+			0x078 MUX_M2
+			0x07c MUX_M2
+			0x080 MUX_M2
+		>;
+		pinctrl-single,bias-pulldown	= <
+			PINCTRL_PULLDOWN(0, 1, 0, 1)
+		>;
+		pinctrl-single,bias-pullup	= <
+			PINCTRL_PULLUP(0, 1, 0, 1)
+		>;
+		pinctrl-single,slew-rate	= <
+			PINCTRL_SLEW_RATE(1, 1)
+		>;
+		pinctrl-single,drive-strength	= <
+			PINCTRL_DRV_STRENGTH(3, 3)
+		>;
+	};
+
+	bt_uart2_p2_pmx_cfg: bt_uart2_p2_pmx_cfg {
+		pinctrl-single,pins = <
+			0x084 MUX_M2
+		>;
+		pinctrl-single,bias-pulldown	= <
+			PINCTRL_PULLDOWN(0, 1, 0, 1)
+		>;
+		pinctrl-single,bias-pullup	= <
+			PINCTRL_PULLUP(0, 1, 0, 1)
+		>;
+		pinctrl-single,slew-rate	= <
+			PINCTRL_SLEW_RATE(1, 1)
+		>;
+		pinctrl-single,drive-strength	= <
+			PINCTRL_DRV_STRENGTH(7, 7)
+		>;
+	};
+
+	pcm_pmx_cfg: pcm_pmx_cfg {
+		pinctrl-single,pins = <
+			0x094 MUX_M2
+			0x098 MUX_M2
+			0x09c MUX_M2
+			0x0a0 MUX_M2
+		>;
+		pinctrl-single,bias-pulldown	= <
+			PINCTRL_PULLDOWN(0, 1, 0, 1)
+		>;
+		pinctrl-single,bias-pullup	= <
+			PINCTRL_PULLUP(0, 1, 0, 1)
+		>;
+		pinctrl-single,slew-rate	= <
+			PINCTRL_SLEW_RATE(1, 1)
+		>;
+		pinctrl-single,drive-strength	= <
+			PINCTRL_DRV_STRENGTH(7, 7)
+		>;
+	};
+
+	spi0_p1_pmx_cfg: spi0_p1_pmx_cfg {
+		pinctrl-single,pins = <
+			0x0b8 MUX_M1
+			0x0bc MUX_M1
+			0x0c0 MUX_M1
+		>;
+		pinctrl-single,bias-pulldown	= <
+			PINCTRL_PULLDOWN(0, 1, 0, 1)
+		>;
+		pinctrl-single,bias-pullup	= <
+			PINCTRL_PULLUP(0, 1, 0, 1)
+		>;
+		pinctrl-single,slew-rate	= <
+			PINCTRL_SLEW_RATE(1, 1)
+		>;
+		pinctrl-single,drive-strength	= <
+			PINCTRL_DRV_STRENGTH(7, 7)
+		>;
+	};
+
+	spi0_p2_pmx_cfg: spi0_p2_pmx_cfg {
+		pinctrl-single,pins = <
+			0x0c4 MUX_M1
+		>;
+		pinctrl-single,bias-pulldown	= <
+			PINCTRL_PULLDOWN(0, 1, 0, 1)
+		>;
+		pinctrl-single,bias-pullup	= <
+			PINCTRL_PULLUP(0, 1, 0, 1)
+		>;
+		pinctrl-single,slew-rate	= <
+			PINCTRL_SLEW_RATE(1, 1)
+		>;
+		pinctrl-single,drive-strength	= <
+			PINCTRL_DRV_STRENGTH(3, 3)
+		>;
+	};
+
+	tsi0_p1_pmx_cfg: tsi0_p1_pmx_cfg {
+		pinctrl-single,pins = <
+			0x0c8 MUX_M1
+			0x0cc MUX_M1
+			0x0d0 MUX_M1
+			0x0d8 MUX_M1
+			0x0dc MUX_M1
+			0x0e0 MUX_M1
+			0x0e4 MUX_M1
+			0x0e8 MUX_M1
+		>;
+		pinctrl-single,bias-pulldown	= <
+			PINCTRL_PULLDOWN(0, 1, 0, 1)
+		>;
+		pinctrl-single,bias-pullup	= <
+			PINCTRL_PULLUP(0, 1, 0, 1)
+		>;
+		pinctrl-single,slew-rate	= <
+			PINCTRL_SLEW_RATE(1, 1)
+		>;
+		pinctrl-single,drive-strength	= <
+			PINCTRL_DRV_STRENGTH(3, 3)
+		>;
+	};
+
+	tsi0_p2_pmx_cfg: tsi0_p2_pmx_cfg {
+		pinctrl-single,pins = <
+			0x0d4 MUX_M1
+		>;
+		pinctrl-single,bias-pulldown	= <
+			PINCTRL_PULLDOWN(0, 1, 0, 1)
+		>;
+		pinctrl-single,bias-pullup	= <
+			PINCTRL_PULLUP(0, 1, 0, 1)
+		>;
+		pinctrl-single,slew-rate	= <
+			PINCTRL_SLEW_RATE(1, 1)
+		>;
+		pinctrl-single,drive-strength	= <
+			PINCTRL_DRV_STRENGTH(7, 7)
+		>;
+	};
+
+	tsi0_p3_pmx_cfg: tsi0_p3_pmx_cfg {
+		pinctrl-single,pins = <
+			0x0ec MUX_M1
+		>;
+		pinctrl-single,bias-pulldown	= <
+			PINCTRL_PULLDOWN(1, 1, 0, 1)
+		>;
+		pinctrl-single,bias-pullup	= <
+			PINCTRL_PULLUP(0, 1, 0, 1)
+		>;
+		pinctrl-single,slew-rate	= <
+			PINCTRL_SLEW_RATE(1, 1)
+		>;
+		pinctrl-single,drive-strength	= <
+			PINCTRL_DRV_STRENGTH(3, 3)
+		>;
+	};
+
+	tsi0_p4_pmx_cfg: tsi0_p4_pmx_cfg  {
+		pinctrl-single,pins = <
+			0x0f0 MUX_M1
+		>;
+		pinctrl-single,bias-pulldown	= <
+			PINCTRL_PULLDOWN(0, 1, 0, 1)
+		>;
+		pinctrl-single,bias-pullup	= <
+			PINCTRL_PULLUP(1, 1, 0, 1)
+		>;
+		pinctrl-single,slew-rate	= <
+			PINCTRL_SLEW_RATE(1, 1)
+		>;
+		pinctrl-single,drive-strength	= <
+			PINCTRL_DRV_STRENGTH(3, 3)
+		>;
+	};
+
+	i2c2_p1_pmx_cfg: i2c2_p1_pmx_cfg {
+		pinctrl-single,pins = <
+			0x0f4 MUX_M1
+		>;
+		pinctrl-single,bias-pulldown   = <
+			PINCTRL_PULLDOWN(0, 1, 0, 1)
+		>;
+		pinctrl-single,bias-pullup  = <
+			PINCTRL_PULLUP(1, 1, 0, 1)
+		>;
+		pinctrl-single,slew-rate    = <
+			PINCTRL_SLEW_RATE(1, 1)
+		>;
+		pinctrl-single,drive-strength   = <
+			PINCTRL_DRV_STRENGTH(3, 3)
+		>;
+	};
+
+	i2c2_p2_pmx_cfg: i2c2_p2_pmx_cfg {
+		pinctrl-single,pins = <
+			0x0f8 MUX_M1
+		>;
+		pinctrl-single,bias-pulldown   = <
+			PINCTRL_PULLDOWN(1, 1, 0, 1)
+		>;
+		pinctrl-single,bias-pullup  = <
+			PINCTRL_PULLUP(0, 1, 0, 1)
+		>;
+		pinctrl-single,slew-rate    = <
+			PINCTRL_SLEW_RATE(1, 1)
+		>;
+		pinctrl-single,drive-strength   = <
+			PINCTRL_DRV_STRENGTH(3, 3)
+		>;
+	};
+
+	mute_pmx_cfg: mute_pmx_cfg {
+		pinctrl-single,pins = <
+			0x100 MUX_M1
+		>;
+		pinctrl-single,bias-pulldown   = <
+			PINCTRL_PULLDOWN(1, 1, 0, 1)
+		>;
+		pinctrl-single,bias-pullup  = <
+			PINCTRL_PULLUP(0, 1, 0, 1)
+		>;
+		pinctrl-single,slew-rate    = <
+			PINCTRL_SLEW_RATE(1, 1)
+		>;
+		pinctrl-single,drive-strength   = <
+			PINCTRL_DRV_STRENGTH(3, 3)
+		>;
+	};
+
+	spdif_pmx_cfg: spdif_pmx_cfg {
+		pinctrl-single,pins = <
+			0x104 MUX_M1
+		>;
+		pinctrl-single,bias-pulldown   = <
+			PINCTRL_PULLDOWN(0, 1, 0, 1)
+		>;
+		pinctrl-single,bias-pullup  = <
+			PINCTRL_PULLUP(0, 1, 0, 1)
+		>;
+		pinctrl-single,slew-rate    = <
+			PINCTRL_SLEW_RATE(1, 1)
+		>;
+		pinctrl-single,drive-strength   = <
+			PINCTRL_DRV_STRENGTH(3, 3)
+		>;
+	};
+
+	rgmii1_p1_pmx_cfg: rgmii1_p1_pmx_cfg {
+		pinctrl-single,pins = <
+			0x118 MUX_M1
+			0x11c MUX_M1
+			0x120 MUX_M1
+			0x144 MUX_M1
+			0x148 MUX_M1
+			0x14c MUX_M1
+			0x150 MUX_M1
+			0x154 MUX_M1
+		>;
+		pinctrl-single,bias-pulldown    = <
+			PINCTRL_PULLDOWN(0, 1, 0, 1)
+		>;
+		pinctrl-single,bias-pullup  = <
+			PINCTRL_PULLUP(0, 1, 0, 1)
+		>;
+		pinctrl-single,slew-rate    = <
+			PINCTRL_SLEW_RATE(1, 1)
+		>;
+		pinctrl-single,drive-strength   = <
+			PINCTRL_DRV_STRENGTH(3, 3)
+		>;
+	};
+
+	rgmii1_p2_pmx_cfg: rgmii1_p2_pmx_cfg {
+		pinctrl-single,pins = <
+			0x124 MUX_M1
+			0x128 MUX_M1
+			0x12c MUX_M1
+			0x130 MUX_M1
+			0x134 MUX_M1
+			0x13c MUX_M1
+		>;
+		pinctrl-single,bias-pulldown    = <
+			PINCTRL_PULLDOWN(0, 1, 0, 1)
+		>;
+		pinctrl-single,bias-pullup   = <
+			PINCTRL_PULLUP(0, 1, 0, 1)
+		>;
+		pinctrl-single,slew-rate    = <
+			PINCTRL_SLEW_RATE(1, 1)
+		>;
+		pinctrl-single,drive-strength   = <
+			PINCTRL_DRV_STRENGTH(6, 7)
+		>;
+	};
+
+	rgmii1_p3_pmx_cfg: rgmii1_p3_pmx_cfg {
+		pinctrl-single,pins = <
+			0x140 MUX_M1
+		>;
+		pinctrl-single,bias-pulldown    = <
+			PINCTRL_PULLDOWN(0, 1, 0, 1)
+		>;
+		pinctrl-single,bias-pullup   = <
+			PINCTRL_PULLUP(0, 1, 0, 1)
+		>;
+		pinctrl-single,slew-rate    = <
+			PINCTRL_SLEW_RATE(1, 1)
+		>;
+		pinctrl-single,drive-strength   = <
+			PINCTRL_DRV_STRENGTH(7, 7)
+		>;
+	};
+
+	sdio0_p1_pmx0_cfg: sdio0_p1_pmx0_cfg {
+		pinctrl-single,pins = <
+			0x158 MUX_M1
+			0x178 MUX_M1
+		>;
+		pinctrl-single,bias-pulldown    = <
+			PINCTRL_PULLDOWN(0, 1, 0, 1)
+		>;
+		pinctrl-single,bias-pullup   = <
+			PINCTRL_PULLUP(0, 1, 0, 1)
+		>;
+		pinctrl-single,slew-rate    = <
+			PINCTRL_SLEW_RATE(1, 1)
+		>;
+		pinctrl-single,drive-strength   = <
+			PINCTRL_DRV_STRENGTH(3, 3)
+		>;
+	};
+
+	sdio0_p2_pmx0_cfg: sdio0_p2_pmx0_cfg {
+		pinctrl-single,pins = <
+			0x160 MUX_M1
+			0x164 MUX_M1
+			0x16c MUX_M1
+			0x170 MUX_M1
+			0x174 MUX_M1
+		>;
+		pinctrl-single,bias-pulldown    = <
+			PINCTRL_PULLDOWN(0, 1, 0, 1)
+		>;
+		pinctrl-single,bias-pullup   = <
+			PINCTRL_PULLUP(0, 1, 0, 1)
+		>;
+		pinctrl-single,slew-rate    = <
+			PINCTRL_SLEW_RATE(1, 1)
+		>;
+		pinctrl-single,drive-strength   = <
+			PINCTRL_DRV_STRENGTH(5, 7)
+		>;
+	};
+
+	sdio0_p3_pmx0_cfg: sdio0_p3_pmx0_cfg {
+		pinctrl-single,pins = <
+			0x168 MUX_M1
+		>;
+		pinctrl-single,bias-pulldown    = <
+			PINCTRL_PULLDOWN(0, 1, 0, 1)
+		>;
+		pinctrl-single,bias-pullup   = <
+			PINCTRL_PULLUP(0, 1, 0, 1)
+		>;
+		pinctrl-single,slew-rate    = <
+			PINCTRL_SLEW_RATE(1, 1)
+		>;
+		pinctrl-single,drive-strength   = <
+			PINCTRL_DRV_STRENGTH(0xc, 0xf)
+		>;
+	};
+};
+
+&pmx1{
+	pinctrl-names = "default";
+	pinctrl-0 = <
+		&uart0_pmx
+		&lowspeed_gpio_pmx
+		&bt_led_pmx
+		&user_led_pmx
+		&ir_pmx
+		&stb_key_pmx
+	>;
+
+	uart0_pmx: uart0_pmx {
+		pinctrl-single,bits = <
+			GPIO5_MUX_CFG(0, 0, 0)
+			GPIO5_MUX_CFG(0, 0, 1)
+		>;
+	};
+
+	lowspeed_gpio_pmx: lowspeed_gpio_pmx {
+		pinctrl-single,bits = <
+			GPIO5_MUX_CFG(0, 0, 4)
+		>;
+	};
+
+	bt_led_pmx: bt_led_pmx {
+		pinctrl-single,bits = <
+			GPIO5_MUX_CFG(0, 1, 7)
+		>;
+	};
+
+	user_led_pmx: user_led_pmx {
+		pinctrl-single,bits = <
+			GPIO5_MUX_CFG(0, 0, 3)
+			GPIO5_MUX_CFG(0, 0, 6)
+		>;
+	};
+
+	ir_pmx: ir_pmx {
+		pinctrl-single,bits = <
+			GPIO5_MUX_CFG(0, 0, 5)
+		>;
+	};
+
+	stb_key_pmx:stb_key_pmx {
+		pinctrl-single,bits = <
+			GPIO5_MUX_CFG(0, 0, 2)
+		>;
+	};
+};
-- 
2.7.4
