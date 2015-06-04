From: ivan.ivanov@linaro.org (Ivan T. Ivanov)
Date: Thu,  4 Jun 2015 12:19:01 +0300
Subject: [PATCH 2/7] arm64: dts: qcom: Add msm8916 BLSP device nodes
In-Reply-To: <1433409546-23995-1-git-send-email-ivan.ivanov@linaro.org>
References: <1433409546-23995-1-git-send-email-ivan.ivanov@linaro.org>
Message-ID: <1433409546-23995-3-git-send-email-ivan.ivanov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device nodes for SPI1, SPI2, SPI3, I2C4, SPI5, SPI6 and
BAM(DMA) engine connected to them.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 128 ++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 9ab9a92..6681c65 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -108,6 +108,134 @@
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
+		blsp_i2c4: i2c at 78b8000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x78b8000 0x1000>;
+			interrupts = <GIC_SPI 98 0>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
+				<&gcc GCC_BLSP1_QUP4_I2C_APPS_CLK>;
+			clock-names = "iface", "core";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&i2c4_default>;
+			pinctrl-1 = <&i2c4_sleep>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		intc: interrupt-controller at b000000 {
 			compatible = "qcom,msm-qgic2";
 			interrupt-controller;
--
1.9.1
