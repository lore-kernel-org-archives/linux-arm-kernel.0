From: lina.iyer@linaro.org (Lina Iyer)
Date: Fri, 17 Apr 2015 17:49:08 -0600
Subject: [PATCH RFC 6/7] arm64: dts: Add cpu idle states for 8916
In-Reply-To: <1429314549-6730-1-git-send-email-lina.iyer@linaro.org>
References: <1429314549-6730-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1429314549-6730-7-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ARM common idle states device bindings for cpuidle support for 8916
SOC.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index a3232be..3c46898 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -52,6 +52,7 @@
 			qcom,acc = <&acc0>;
 			next-level-cache = <&L2_0>;
 			qcom,saw = <&saw0>;
+			cpu-idle-states = <&CPU_SPC>;
 			L2_0: l2-cache {
 			      compatible = "arm,arch-cache";
 			      cache-level = <2>;
@@ -67,6 +68,7 @@
 			qcom,acc = <&acc1>;
 			next-level-cache = <&L2_0>;
 			qcom,saw = <&saw1>;
+			cpu-idle-states = <&CPU_SPC>;
 		};
 
 		CPU2: cpu at 2 {
@@ -77,6 +79,7 @@
 			qcom,acc = <&acc2>;
 			next-level-cache = <&L2_0>;
 			qcom,saw = <&saw2>;
+			cpu-idle-states = <&CPU_SPC>;
 		};
 
 		CPU3: cpu at 3 {
@@ -87,6 +90,17 @@
 			qcom,acc = <&acc3>;
 			next-level-cache = <&L2_0>;
 			qcom,saw = <&saw3>;
+			cpu-idle-states = <&CPU_SPC>;
+		};
+
+		idle-states {
+			CPU_SPC: spc {
+				compatible = "qcom,idle-state-spc",
+						"arm,idle-state";
+				entry-latency-us = <130>;
+				exit-latency-us = <150>;
+				min-residency-us = <2000>;
+			};
 		};
 	};
 
-- 
2.1.0
