From: vkoul@kernel.org (Vinod Koul)
Date: Fri,  9 Nov 2018 15:14:15 +0530
Subject: [PATCH v5 16/18] arm64: dts: qcom: qcs404: Add BAM DMA node
In-Reply-To: <20181109094417.12109-1-vkoul@kernel.org>
References: <20181109094417.12109-1-vkoul@kernel.org>
Message-ID: <20181109094417.12109-17-vkoul@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the BAM DMA instance found in BLSP1 node of the QCS404

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index c58774bb9698..ef2c4cdc6d27 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -323,6 +323,18 @@
 			status = "disabled";
 		};
 
+		blsp1_dma: dma at 7884000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0x07884000 0x25000>;
+			interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "bam_clk";
+			#dma-cells = <1>;
+			qcom,controlled-remotely = <1>;
+			qcom,ee = <0>;
+			status = "okay";
+		};
+
 		blsp1_uart2: serial at 78b1000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0x078b1000 0x200>;
-- 
2.14.4
