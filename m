From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Thu, 30 Nov 2017 21:27:32 -0800
Subject: [PATCH] arm64: dts: msm8916: Correct ipc references for smsm
Message-ID: <20171201052732.31996-1-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SMSM is not symmetrical, the incoming bits from WCNSS are available at
index 6, but the outgoing host id for WCNSS is 3. Further more, upstream
references the base of APCS (in contrast to downstream), so the register
offset of 8 must be included.

Fixes: 1fb47e0a9ba4 ("arm64: dts: qcom: msm8916: Add smsm and smp2p nodes")
Cc: stable at vger.kernel.org
Reported-by: Ramon Fried <rfried@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 9fb317853a5c..a8e1e3b4562c 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1437,8 +1437,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		qcom,ipc-1 = <&apcs 0 13>;
-		qcom,ipc-6 = <&apcs 0 19>;
+		qcom,ipc-1 = <&apcs 8 13>;
+		qcom,ipc-3 = <&apcs 8 19>;
 
 		apps_smsm: apps at 0 {
 			reg = <0>;
-- 
2.15.0
