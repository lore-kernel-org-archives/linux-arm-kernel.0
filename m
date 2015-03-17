From: agross@codeaurora.org (Andy Gross)
Date: Tue, 17 Mar 2015 16:51:10 -0500
Subject: [PATCH 3/4] ARM: DT: msm8660: Add ADM device nodes
In-Reply-To: <1426629071-3541-1-git-send-email-agross@codeaurora.org>
References: <1426629071-3541-1-git-send-email-agross@codeaurora.org>
Message-ID: <1426629071-3541-4-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the ADM DMA on the MSM8660 SOC

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8660.dtsi |   42 +++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index 0affd61..8043c12 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -4,7 +4,9 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-msm8660.h>
+#include <dt-bindings/reset/qcom,gcc-msm8660.h>
 #include <dt-bindings/soc/qcom,gsbi.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
 	model = "Qualcomm MSM8660";
@@ -196,6 +198,46 @@
 				vmmc-supply = <&vsdcc_fixed>;
 			};
 		};
+
+		adm_dma0: dma at 18320000 {
+			compatible = "qcom,adm";
+			reg = <0x18320000 0x100000>;
+			interrupts = <GIC_SPI 171 IRQ_TYPE_NONE>;
+			#dma-cells = <1>;
+
+			clocks = <&gcc ADM0_CLK>, <&gcc ADM0_PBUS_CLK>;
+			clock-names = "core", "iface";
+
+			resets = <&gcc ADM0_RESET>,
+				 <&gcc ADM0_PBUS_RESET>,
+				 <&gcc ADM0_C0_RESET>,
+				 <&gcc ADM0_C1_RESET>,
+				 <&gcc ADM0_C2_RESET>;
+			reset-names = "clk", "pbus", "c0", "c1", "c2";
+			qcom,ee = <1>;
+
+			status = "disabled";
+		};
+
+		adm_dma1: dma at 18420000 {
+			compatible = "qcom,adm";
+			reg = <0x18420000 0xE0000>;
+			interrupts = <GIC_SPI 167 IRQ_TYPE_NONE>;
+			#dma-cells = <1>;
+
+			clocks = <&gcc ADM1_CLK>, <&gcc ADM1_PBUS_CLK>;
+			clock-names = "core", "iface";
+
+			resets = <&gcc ADM1_RESET>,
+				 <&gcc ADM1_PBUS_RESET>,
+				 <&gcc ADM1_C0_RESET>,
+				 <&gcc ADM1_C1_RESET>,
+				 <&gcc ADM1_C2_RESET>;
+			reset-names = "clk", "pbus", "c0", "c1", "c2";
+			qcom,ee = <1>;
+
+			status = "disabled";
+		};
 	};
 
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
