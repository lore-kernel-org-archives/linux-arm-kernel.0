From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Tue, 17 Jan 2017 11:47:55 -0800
Subject: [PATCH] arm64: dts: qcom: Replace PMU compatible with a53 specific one
Message-ID: <20170117194755.2061-1-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PMU on msm8916 is for the cortex-a53 type CPU. Update the
compatible to the more specific one so we can get the a53
specific events out of the PMU.

Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 466ca5705c99..572d1a58844f 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -156,7 +156,7 @@
 	};
 
 	pmu {
-		compatible = "arm,armv8-pmuv3";
+		compatible = "arm,cortex-a53-pmu";
 		interrupts = <GIC_PPI 7 GIC_CPU_MASK_SIMPLE(4)>;
 	};
 
-- 
2.10.0.297.gf6727b0
