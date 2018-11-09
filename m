From: vkoul@kernel.org (Vinod Koul)
Date: Fri,  9 Nov 2018 15:14:06 +0530
Subject: [PATCH v5 07/18] arm64: dts: qcom: qcs404: Add TLMM pinctrl node
In-Reply-To: <20181109094417.12109-1-vkoul@kernel.org>
References: <20181109094417.12109-1-vkoul@kernel.org>
Message-ID: <20181109094417.12109-8-vkoul@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Add the QCS404 TLMM pinctrl node with its three tiles.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 133bcd36f926..d32b91480dc1 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -153,6 +153,20 @@
 			reg = <0x00060000 0x6000>;
 		};
 
+		tlmm: pinctrl at 1000000 {
+			compatible = "qcom,qcs404-pinctrl";
+			reg = <0x01000000 0x200000>,
+			      <0x01300000 0x200000>,
+			      <0x07b00000 0x200000>;
+			reg-names = "south", "north", "east";
+			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-ranges = <&tlmm 0 0 120>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
 		gcc: clock-controller at 1800000 {
 			compatible = "qcom,gcc-qcs404";
 			reg = <0x01800000 0x80000>;
-- 
2.14.4
