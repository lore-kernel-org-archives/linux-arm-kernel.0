From: lina.iyer@linaro.org (Lina Iyer)
Date: Mon,  9 Mar 2015 09:16:45 -0600
Subject: [PATCH v15 10/11] ARM: dts: qcom: Add idle state device nodes for 8064
In-Reply-To: <1425914206-22295-1-git-send-email-lina.iyer@linaro.org>
References: <1425914206-22295-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1425914206-22295-11-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ARM common idle state device bindings for cpuidle support for APQ
8064.

Support Standby and Standalone power collapse (power down that does not
affect any SoC idle states) for each cpu.

Cc: Kumar Gala <galak@codeaurora.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 9fd24bc..08893fd 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -23,6 +23,7 @@
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc0>;
 			qcom,saw = <&saw0>;
+			cpu-idle-states = <&CPU_STBY &CPU_SPC>;
 		};
 
 		cpu at 1 {
@@ -33,6 +34,7 @@
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc1>;
 			qcom,saw = <&saw1>;
+			cpu-idle-states = <&CPU_STBY &CPU_SPC>;
 		};
 
 		cpu at 2 {
@@ -43,6 +45,7 @@
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc2>;
 			qcom,saw = <&saw2>;
+			cpu-idle-states = <&CPU_STBY &CPU_SPC>;
 		};
 
 		cpu at 3 {
@@ -53,12 +56,31 @@
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc3>;
 			qcom,saw = <&saw3>;
+			cpu-idle-states = <&CPU_STBY &CPU_SPC>;
 		};
 
 		L2: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
 		};
+
+		idle-states {
+			CPU_STBY: standby {
+				compatible = "qcom,idle-state-stby",
+						"arm,idle-state";
+				entry-latency-us = <1>;
+				exit-latency-us = <1>;
+				min-residency-us = <2>;
+			};
+
+			CPU_SPC: spc {
+				compatible = "qcom,idle-state-spc",
+						"arm,idle-state";
+				entry-latency-us = <400>;
+				exit-latency-us = <900>;
+				min-residency-us = <3000>;
+			};
+		};
 	};
 
 	cpu-pmu {
-- 
2.1.0
