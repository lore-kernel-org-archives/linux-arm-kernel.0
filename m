From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Thu, 24 May 2018 15:31:22 -0700
Subject: [PATCH] arm64: dts: qcom: msm8996: Use UFS_GDSC for UFS
Message-ID: <20180524223122.12601-1-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UFS host controller occationally (20%) fails to enable
gcc_ufs_axi_clk because the UFS GDSC is not enabled. In most cases it's
enabled through the UFS phy driver, but to make sure it's enabled let's
enable it directly from the UFS host controller directly as well.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 380e14591686..03c7904bda14 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -674,6 +674,8 @@
 			vccq-max-microamp = <450000>;
 			vccq2-max-microamp = <450000>;
 
+			power-domains = <&gcc UFS_GDSC>;
+
 			clock-names =
 				"core_clk_src",
 				"core_clk",
-- 
2.17.0
