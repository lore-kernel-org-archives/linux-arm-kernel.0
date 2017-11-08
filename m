From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue,  7 Nov 2017 19:45:01 -0800
Subject: [PATCH] arm64: dts: msm8916: Add missing #phy-cells
Message-ID: <20171108034501.2994-1-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a missing #phy-cells to the dsi-phy, to silence dtc warning.

Cc: Archit Taneja <architt@codeaurora.org>
Fixes: 305410ffd1b2 ("arm64: dts: msm8916: Add display support")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 6b2127a6ced1..09ac5c43807e 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -906,6 +906,7 @@
 					    "dsi_phy_regulator";
 
 				#clock-cells = <1>;
+				#phy-cells = <0>;
 
 				clocks = <&gcc GCC_MDSS_AHB_CLK>;
 				clock-names = "iface_clk";
-- 
2.15.0
