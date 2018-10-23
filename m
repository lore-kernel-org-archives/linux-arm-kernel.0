From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Wed, 24 Oct 2018 00:36:52 +0530
Subject: [PATCH 2/5] arm64: dts: hisilicon: hi3760: Add GPIO controller support
In-Reply-To: <20181023190655.12004-1-manivannan.sadhasivam@linaro.org>
References: <20181023190655.12004-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20181023190655.12004-3-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add GPIO controller support for HiSilicon HI3670 SoC based on ARM
Primecell PL061 GPIO controller.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../boot/dts/hisilicon/hi3670-hikey970.dts    |   1 +
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     | 379 ++++++++++++++++++
 2 files changed, 380 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
index 4f5118642024..8fdc1dfcb06c 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
@@ -10,6 +10,7 @@
 /dts-v1/;
 
 #include "hi3670.dtsi"
+#include "hikey970-pinctrl.dtsi"
 
 / {
 	model = "HiKey970";
diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index 34a2f0dbc6f7..b99f5e0fe577 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -196,5 +196,384 @@
 			clock-names = "uartclk", "apb_pclk";
 			status = "disabled";
 		};
+
+		gpio0: gpio at e8a0b000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a0b000 0x0 0x1000>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 1 0 1 &pmx0 3 1 5>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO0>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio1: gpio at e8a0c000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a0c000 0x0 0x1000>;
+			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO1>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio2: gpio at e8a0d000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a0d000 0x0 0x1000>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 1 6 7>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO2>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio3: gpio at e8a0e000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a0e000 0x0 0x1000>;
+			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges =  <&pmx0 0 13 4 &pmx0 7 17 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO3>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio4: gpio at e8a0f000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a0f000 0x0 0x1000>;
+			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 18 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO4>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio5: gpio at e8a10000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a10000 0x0 0x1000>;
+			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 26 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO5>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio6: gpio at e8a11000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a11000 0x0 0x1000>;
+			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 1 34 7>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO6>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio7: gpio at e8a12000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a12000 0x0 0x1000>;
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 41 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO7>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio8: gpio at e8a13000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a13000 0x0 0x1000>;
+			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 49 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO8>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio9: gpio at e8a14000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a14000 0x0 0x1000>;
+			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 57 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO9>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio10: gpio at e8a15000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a15000 0x0 0x1000>;
+			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 65 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO10>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio11: gpio at e8a16000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a16000 0x0 0x1000>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 73 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO11>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio12: gpio at e8a17000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a17000 0x0 0x1000>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 81 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO12>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio13: gpio at e8a18000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a18000 0x0 0x1000>;
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO13>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio14: gpio at e8a19000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a19000 0x0 0x1000>;
+			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO14>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio15: gpio at e8a1a000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a1a000 0x0 0x1000>;
+			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO15>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio16: gpio at e8a1b000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a1b000 0x0 0x1000>;
+			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx5 0 0 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO16>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio17: gpio at e8a1c000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a1c000 0x0 0x1000>;
+			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx5 0 8 2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO17>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio18: gpio at fff28000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xfff28000 0x0 0x1000>;
+			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx1 4 42 4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&sctrl HI3670_PCLK_GPIO18>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio19: gpio at fff29000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xfff29000 0x0 0x1000>;
+			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx1 0 61 2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&sctrl HI3670_PCLK_GPIO19>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio20: gpio at e8a1f000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a1f000 0x0 0x1000>;
+			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx7 0 0 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO20>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio21: gpio at e8a20000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xe8a20000 0x0 0x1000>;
+			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx7 0 8 4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&crg_ctrl HI3670_PCLK_GPIO21>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio22: gpio at fff0b000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xfff0b000 0x0 0x1000>;
+			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			/* GPIO176 */
+			gpio-ranges = <&pmx1 2 0 6>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&sctrl HI3670_PCLK_AO_GPIO0>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio23: gpio at fff0c000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xfff0c000 0x0 0x1000>;
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			/* GPIO184 */
+			gpio-ranges = <&pmx1 0 6 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&sctrl HI3670_PCLK_AO_GPIO1>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio24: gpio at fff0d000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xfff0d000 0x0 0x1000>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			/* GPIO192 */
+			gpio-ranges = <&pmx1 0 14 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&sctrl HI3670_PCLK_AO_GPIO2>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio25: gpio at fff0e000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xfff0e000 0x0 0x1000>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			/* GPIO200 */
+			gpio-ranges = <&pmx1 0 22 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&sctrl HI3670_PCLK_AO_GPIO3>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio26: gpio at fff0f000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xfff0f000 0x0 0x1000>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			/* GPIO208 */
+			gpio-ranges = <&pmx1 0 30 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&sctrl HI3670_PCLK_AO_GPIO4>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio27: gpio at fff10000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xfff10000 0x0 0x1000>;
+			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			/* GPIO216 */
+			gpio-ranges = <&pmx1 4 31 4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&sctrl HI3670_PCLK_AO_GPIO5>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio28: gpio at fff1d000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xfff1d000 0x0 0x1000>;
+			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx1 1 35 7>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&sctrl HI3670_PCLK_AO_GPIO6>;
+			clock-names = "apb_pclk";
+		};
 	};
 };
-- 
2.17.1
