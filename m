From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Thu, 18 Feb 2016 15:01:06 +0530
Subject: [PATCH] arm64: dts: msm8996: Add #power-domain-cells property
Message-ID: <1455787866-22223-1-git-send-email-rnayak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add #power-domain-cells property for both the gcc and mmcc
clock controller nodes as they both supports power domains (gdsc's)

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
Andy, the gdsc support patches for 8996 are pulled into clk-next.
Can you please pull the dts changes in for 4.6?

 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 2c2736d..0506fb8 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -147,6 +147,7 @@
 			compatible = "qcom,gcc-msm8996";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
+			#power-domain-cells = <1>;
 			reg = <0x300000 0x90000>;
 		};
 
@@ -251,6 +252,7 @@
 			compatible = "qcom,mmcc-msm8996";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
+			#power-domain-cells = <1>;
 			reg = <0x8c0000 0x40000>;
 			assigned-clocks = <&mmcc MMPLL9_PLL>,
 					  <&mmcc MMPLL1_PLL>,
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
