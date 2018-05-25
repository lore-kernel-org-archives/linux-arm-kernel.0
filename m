From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 25 May 2018 11:45:25 -0700
Subject: [PATCH v2] arm64: dts: qcom: msm8996: Move UFS_GDSC to UFS HCD
In-Reply-To: <20180524223122.12601-1-bjorn.andersson@linaro.org>
Message-ID: <20180525184525.355-1-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UFS_GDSC backs the resources needed by the UFS HCD, rather than the
PHY. This results in the UFS HCD occationally failing to enable some of
its clocks.

Move the UFS_GDSC reference to the UFS HCD node instead, to correct
this.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Dropped UFS_GDSC from phy node

 arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 380e14591686..8c7f9ca25b53 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -654,8 +654,6 @@
 			clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
 				 <&gcc GCC_UFS_CLKREF_CLK>;
 			status = "disabled";
-
-			power-domains = <&gcc UFS_GDSC>;
 		};
 
 		ufshc at 624000 {
@@ -674,6 +672,8 @@
 			vccq-max-microamp = <450000>;
 			vccq2-max-microamp = <450000>;
 
+			power-domains = <&gcc UFS_GDSC>;
+
 			clock-names =
 				"core_clk_src",
 				"core_clk",
-- 
2.17.0
