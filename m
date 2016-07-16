From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 15 Jul 2016 17:42:13 -0700
Subject: [PATCH 3/6] arm64: dts: qcom: msm8916: Make scm a reset-controller
In-Reply-To: <1468629736-7644-1-git-send-email-bjorn.andersson@linaro.org>
References: <1468629736-7644-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1468629736-7644-3-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On msm8916 SCM acts as a controller for the MSS_RESET found in the GCC,
update the DT node so that we can address this.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 4f2882605138..1e67acc19a9d 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -192,10 +192,11 @@
 	};
 
 	firmware {
-		scm {
+		scm: scm {
 			compatible = "qcom,scm";
 			clocks = <&gcc GCC_CRYPTO_CLK>, <&gcc GCC_CRYPTO_AXI_CLK>, <&gcc GCC_CRYPTO_AHB_CLK>;
 			clock-names = "core", "bus", "iface";
+			#reset-cells = <1>;
 		};
 	};
 
-- 
2.5.0
