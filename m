From: vkoul@kernel.org (Vinod Koul)
Date: Fri,  9 Nov 2018 15:14:09 +0530
Subject: [PATCH v5 10/18] arm64: dts: qcom: qcs404: add spmi node
In-Reply-To: <20181109094417.12109-1-vkoul@kernel.org>
References: <20181109094417.12109-1-vkoul@kernel.org>
Message-ID: <20181109094417.12109-11-vkoul@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PMS405 is used in QCS405-EVB so include that with SPMI nodes

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi |  1 +
 arch/arm64/boot/dts/qcom/qcs404.dtsi     | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index 358d6d5f7d85..db035fef67d9 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -2,6 +2,7 @@
 // Copyright (c) 2018, Linaro Limited
 
 #include "qcs404.dtsi"
+#include "pms405.dtsi"
 
 / {
 	aliases {
diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 1b3e21c1fed9..0101cd5896b3 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -181,6 +181,24 @@
 			reg = <0x01905000 0x20000>;
 		};
 
+		spmi_bus: spmi at 200f000 {
+			compatible = "qcom,spmi-pmic-arb";
+			reg = <0x0200f000 0x001000>,
+			      <0x02400000 0x800000>,
+			      <0x02c00000 0x800000>,
+			      <0x03800000 0x200000>,
+			      <0x0200a000 0x002100>;
+			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
+			interrupt-names = "periph_irq";
+			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,ee = <0>;
+			qcom,channel = <0>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+			interrupt-controller;
+			#interrupt-cells = <4>;
+		};
+
 		sdcc1: sdcc at 7804000 {
 			compatible = "qcom,sdhci-msm-v5";
 			reg = <0x07804000 0x1000>, <0x7805000 0x1000>;
-- 
2.14.4
