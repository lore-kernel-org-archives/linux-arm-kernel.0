From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 15 Jul 2016 17:42:14 -0700
Subject: [PATCH 4/6] arm64: dts: qcom: msm8916: Add tcsr syscon
In-Reply-To: <1468629736-7644-1-git-send-email-bjorn.andersson@linaro.org>
References: <1468629736-7644-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1468629736-7644-4-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The TCSR memory segment includes various functionality, among other
things the halt-registers for the Hexagon.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 1e67acc19a9d..64f85f82602c 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -234,6 +234,11 @@
 			reg = <0x1905000 0x20000>;
 		};
 
+		tcsr: syscon at 1937000 {
+			compatible = "qcom,tcsr-msm8916", "syscon";
+			reg = <0x1937000 0x30000>;
+		};
+
 		tcsr_mutex: hwlock {
 			compatible = "qcom,tcsr-mutex";
 			syscon = <&tcsr_mutex_regs 0 0x1000>;
-- 
2.5.0
