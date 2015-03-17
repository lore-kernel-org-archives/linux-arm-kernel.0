From: stanimir.varbanov@linaro.org (Stanimir Varbanov)
Date: Tue, 17 Mar 2015 18:25:31 +0200
Subject: [PATCH 1/2] DT: arm64: msm8916: add all SPI DT nodes
Message-ID: <1426609532-11996-1-git-send-email-stanimir.varbanov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SPI DT nodes for the SoC. Every SPI DT node has reference to
blsp dma node with relevant dma channels and appropriate pinctrl
nodes to configure SPI pins.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi |  317 +++++++++++++++++++++++++++++++++
 1 files changed, 317 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 8c8fd49..b5be833 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -96,6 +96,210 @@
 					bias-pull-down;
 				};
 			};
+
+			spi1_default: spi1_default {
+				pinmux {
+					function = "blsp_spi1";
+					pins = "gpio0", "gpio1", "gpio3";
+				};
+				pinmux_cs {
+					function = "gpio";
+					pins = "gpio2";
+				};
+				pinconf {
+					pins = "gpio0", "gpio1", "gpio3";
+					drive-strength = <12>;
+					bias-disable;
+				};
+				pinconf_cs {
+					pins = "gpio2";
+					drive-strength = <2>;
+					bias-disable;
+					output-high;
+				};
+			};
+
+			spi1_sleep: spi1_sleep {
+				pinmux {
+					function = "gpio";
+					pins = "gpio0", "gpio1", "gpio2", "gpio3";
+				};
+				pinconf {
+					pins = "gpio0", "gpio1", "gpio2", "gpio3";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+			};
+
+			spi2_default: spi2_default {
+				pinmux {
+					function = "blsp_spi2";
+					pins = "gpio4", "gpio5", "gpio7";
+				};
+				pinmux_cs {
+					function = "gpio";
+					pins = "gpio6";
+				};
+				pinconf {
+					pins = "gpio4", "gpio5", "gpio6", "gpio7";
+					drive-strength = <12>;
+					bias-disable;
+				};
+				pinconf_cs {
+					pins = "gpio6";
+					drive-strength = <2>;
+					bias-disable;
+					output-high;
+				};
+			};
+
+			spi2_sleep: spi2_sleep {
+				pinmux {
+					function = "gpio";
+					pins = "gpio4", "gpio5", "gpio6", "gpio7";
+				};
+				pinconf {
+					pins = "gpio4", "gpio5", "gpio6", "gpio7";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+			};
+
+			spi3_default: spi3_default {
+				pinmux {
+					function = "blsp_spi3";
+					pins = "gpio8", "gpio9", "gpio11";
+				};
+				pinmux_cs {
+					function = "gpio";
+					pins = "gpio10";
+				};
+				pinconf {
+					pins = "gpio8", "gpio9", "gpio10", "gpio11";
+					drive-strength = <12>;
+					bias-disable;
+				};
+				pinconf_cs {
+					pins = "gpio10";
+					drive-strength = <2>;
+					bias-disable;
+					output-high;
+				};
+			};
+
+			spi3_sleep: spi3_sleep {
+				pinmux {
+					function = "gpio";
+					pins = "gpio8", "gpio9", "gpio10", "gpio11";
+				};
+				pinconf {
+					pins = "gpio8", "gpio9", "gpio10", "gpio11";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+			};
+
+			spi4_default: spi4_default {
+				pinmux {
+					function = "blsp_spi4";
+					pins = "gpio12", "gpio13", "gpio15";
+				};
+				pinmux_cs {
+					function = "gpio";
+					pins = "gpio14";
+				};
+				pinconf {
+					pins = "gpio12", "gpio13", "gpio14", "gpio15";
+					drive-strength = <12>;
+					bias-disable;
+				};
+				pinconf_cs {
+					pins = "gpio14";
+					drive-strength = <2>;
+					bias-disable;
+					output-high;
+				};
+			};
+
+			spi4_sleep: spi4_sleep {
+				pinmux {
+					function = "gpio";
+					pins = "gpio12", "gpio13", "gpio14", "gpio15";
+				};
+				pinconf {
+					pins = "gpio12", "gpio13", "gpio14", "gpio15";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+			};
+
+			spi5_default: spi5_default {
+				pinmux {
+					function = "blsp_spi5";
+					pins = "gpio16", "gpio17", "gpio19";
+				};
+				pinmux_cs {
+					function = "gpio";
+					pins = "gpio18";
+				};
+				pinconf {
+					pins = "gpio16", "gpio17", "gpio18", "gpio19";
+					drive-strength = <12>;
+					bias-disable;
+				};
+				pinconf_cs {
+					pins = "gpio18";
+					drive-strength = <2>;
+					bias-disable;
+					output-high;
+				};
+			};
+
+			spi5_sleep: spi4_sleep {
+				pinmux {
+					function = "gpio";
+					pins = "gpio16", "gpio17", "gpio18", "gpio19";
+				};
+				pinconf {
+					pins = "gpio16", "gpio17", "gpio18", "gpio19";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+			};
+
+			spi6_default: spi6_default {
+				pinmux {
+					function = "blsp_spi6";
+					pins = "gpio20", "gpio21", "gpio23";
+				};
+				pinmux_cs {
+					function = "gpio";
+					pins = "gpio22";
+				};
+				pinconf {
+					pins = "gpio20", "gpio21", "gpio22", "gpio23";
+					drive-strength = <12>;
+					bias-disable;
+				};
+				pinconf_cs {
+					pins = "gpio22";
+					drive-strength = <2>;
+					bias-disable;
+					output-high;
+				};
+			};
+
+			spi6_sleep: spi6_sleep {
+				pinmux {
+					function = "gpio";
+					pins = "gpio20", "gpio21", "gpio22", "gpio23";
+				};
+				pinconf {
+					pins = "gpio20", "gpio21", "gpio22", "gpio23";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+			};
 		};
 
 		gcc: qcom,gcc at 1800000 {
@@ -114,6 +318,119 @@
 			status = "disabled";
 		};
 
+		blsp_dma: dma at 7884000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0x07884000 0x23000>;
+			interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "bam_clk";
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			status = "disabled";
+		};
+
+		blsp_spi1: spi at 78b5000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x078b5000 0x600>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp_dma 5>, <&blsp_dma 4>;
+			dma-names = "rx", "tx";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&spi1_default>;
+			pinctrl-1 = <&spi1_sleep>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp_spi2: spi at 78b6000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x078b6000 0x600>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP2_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp_dma 7>, <&blsp_dma 6>;
+			dma-names = "rx", "tx";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&spi2_default>;
+			pinctrl-1 = <&spi2_sleep>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp_spi3: spi at 78b7000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x078b7000 0x600>;
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP3_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp_dma 9>, <&blsp_dma 8>;
+			dma-names = "rx", "tx";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&spi3_default>;
+			pinctrl-1 = <&spi3_sleep>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp_spi4: spi at 78b8000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x078b8000 0x600>;
+			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP4_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp_dma 11>, <&blsp_dma 10>;
+			dma-names = "rx", "tx";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&spi4_default>;
+			pinctrl-1 = <&spi4_sleep>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp_spi5: spi at 78b9000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x078b9000 0x600>;
+			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP5_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp_dma 13>, <&blsp_dma 12>;
+			dma-names = "rx", "tx";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&spi5_default>;
+			pinctrl-1 = <&spi5_sleep>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp_spi6: spi at 78ba000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x078ba000 0x600>;
+			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP6_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp_dma 15>, <&blsp_dma 14>;
+			dma-names = "rx", "tx";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&spi6_default>;
+			pinctrl-1 = <&spi6_sleep>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		intc: interrupt-controller at b000000 {
 			compatible = "qcom,msm-qgic2";
 			interrupt-controller;
-- 
1.7.0.4
