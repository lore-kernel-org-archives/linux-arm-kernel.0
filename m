From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 18 Nov 2016 12:06:49 -0800
Subject: [PATCH] arm64: dts: qcom: msm8996: Fixup smp2p node
Message-ID: <1479499609-13336-1-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SMEM state property name changes between the integration branch and
mainline, update to use the correct one.

Fixes: 2f45d9fcd531 ("arm64: dts: msm8996: Add SMP2P and APCS nodes")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Seems we're still carrying this discrepancy somewhere and I missed it in my
review, sorry about that.

 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index cde4114bae5a..712d5d043105 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -530,7 +530,7 @@
 
 		adsp_smp2p_out: master-kernel {
 			qcom,entry-name = "master-kernel";
-			#qcom,state-cells = <1>;
+			#qcom,smem-state-cells = <1>;
 		};
 
 		adsp_smp2p_in: slave-kernel {
-- 
2.5.0
