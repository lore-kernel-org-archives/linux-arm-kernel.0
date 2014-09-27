From: lina.iyer@linaro.org (Lina Iyer)
Date: Fri, 26 Sep 2014 18:58:15 -0600
Subject: [PATCH v7 7/7] arm: dts: qcom: Add idle states device nodes for 8084
In-Reply-To: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org>
References: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1411779495-39724-8-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add allowable C-States for each cpu using the cpu-idle-states node.
ARM spec dictates WFI as the default idle state at 0. Support standalone
power collapse (power down that does not affect any SoC idle states) for
each cpu.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index 3dda230..a1ea1c0 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -19,6 +19,7 @@
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc0>;
 			qcom,saw = <&saw0>;
+			cpu-idle-states = <&CPU_WFI &CPU_SPC>;
 		};
 
 		cpu at 1 {
@@ -29,6 +30,7 @@
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc1>;
 			qcom,saw = <&saw1>;
+			cpu-idle-states = <&CPU_WFI &CPU_SPC>;
 		};
 
 		cpu at 2 {
@@ -39,6 +41,7 @@
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc2>;
 			qcom,saw = <&saw2>;
+			cpu-idle-states = <&CPU_WFI &CPU_SPC>;
 		};
 
 		cpu at 3 {
@@ -49,6 +52,7 @@
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc3>;
 			qcom,saw = <&saw3>;
+			cpu-idle-states = <&CPU_WFI &CPU_SPC>;
 		};
 
 		L2: l2-cache {
@@ -56,6 +60,22 @@
 			cache-level = <2>;
 			qcom,saw = <&saw_l2>;
 		};
+
+		idle-states {
+			CPU_WFI: wfi {
+				compatible = "qcom,idle-state-wfi", "arm,idle-state";
+				entry-latency-us = <1>;
+				exit-latency-us = <1>;
+				min-residency-us = <2>;
+			};
+
+			CPU_SPC: spc {
+				compatible = "qcom,idle-state-spc", "arm,idle-state";
+				entry-latency-us = <150>;
+				exit-latency-us = <200>;
+				min-residency-us = <2000>;
+			};
+		};
 	};
 
 	cpu-pmu {
-- 
1.9.1
