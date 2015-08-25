From: stanimir.varbanov@linaro.org (Stanimir Varbanov)
Date: Tue, 25 Aug 2015 18:37:42 +0300
Subject: [PATCH] arm64: dts: qcom: Add RNG device tree node
Message-ID: <1440517062-30313-1-git-send-email-stanimir.varbanov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds rng device tree node for msm8916 SoCs.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 0f49ebd0aa8b..060c6c53ff33 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -215,5 +215,12 @@
 			interrupt-controller;
 			#interrupt-cells = <4>;
 		};
+
+		rng at 22000 {
+			compatible = "qcom,prng";
+			reg = <0x00022000 0x200>;
+			clocks = <&gcc GCC_PRNG_AHB_CLK>;
+			clock-names = "core";
+		};
 	};
 };
-- 
1.7.9.5
