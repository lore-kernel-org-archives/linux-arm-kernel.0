From: lina.iyer@linaro.org (Lina Iyer)
Date: Tue, 17 Mar 2015 16:33:48 -0600
Subject: [PATCH v16 08/11] ARM: dts: qcom: Add idle states device nodes for
 8974/8074
In-Reply-To: <1426631631-56937-1-git-send-email-lina.iyer@linaro.org>
References: <1426631631-56937-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1426631631-56937-9-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ARM common idle states device bindings for cpuidle support for APQ
8974/8074.

Support Standalone power collapse (SPC) idle state (power down that does
not affect any SoC idle states) for each cpu.

Cc: Kumar Gala <galak@codeaurora.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 5a41f44..1c28f0f 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -22,6 +22,7 @@
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc0>;
 			qcom,saw = <&saw0>;
+			cpu-idle-states = <&CPU_SPC>;
 		};
 
 		cpu at 1 {
@@ -32,6 +33,7 @@
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc1>;
 			qcom,saw = <&saw1>;
+			cpu-idle-states = <&CPU_SPC>;
 		};
 
 		cpu at 2 {
@@ -42,6 +44,7 @@
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc2>;
 			qcom,saw = <&saw2>;
+			cpu-idle-states = <&CPU_SPC>;
 		};
 
 		cpu at 3 {
@@ -52,6 +55,7 @@
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc3>;
 			qcom,saw = <&saw3>;
+			cpu-idle-states = <&CPU_SPC>;
 		};
 
 		L2: l2-cache {
@@ -59,6 +63,16 @@
 			cache-level = <2>;
 			qcom,saw = <&saw_l2>;
 		};
+
+		idle-states {
+			CPU_SPC: spc {
+				compatible = "qcom,idle-state-spc",
+						"arm,idle-state";
+				entry-latency-us = <150>;
+				exit-latency-us = <200>;
+				min-residency-us = <2000>;
+			};
+		};
 	};
 
 	cpu-pmu {
-- 
2.1.0
