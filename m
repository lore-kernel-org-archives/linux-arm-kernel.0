From: lina.iyer@linaro.org (Lina Iyer)
Date: Tue, 23 Sep 2014 17:51:21 -0600
Subject: [PATCH v6 5/5] arm: dts: qcom: Add idle states device nodes for 8974
In-Reply-To: <1411516281-58328-1-git-send-email-lina.iyer@linaro.org>
References: <1411516281-58328-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1411516281-58328-6-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add allowable C-States for each cpu using the cpu-idle-states node.
ARM spec dictates WFI as the default idle state at 0. Support standalone
power collapse (power down that does not affect any SoC idle states) for
each cpu.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 0580bc2..e87b24f 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -21,6 +21,7 @@
 			reg = <0>;
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc0>;
+			cpu-idle-states = <&CPU_WFI &CPU_SPC>;
 		};
 
 		CPU1: cpu at 1 {
@@ -30,6 +31,7 @@
 			reg = <1>;
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc1>;
+			cpu-idle-states = <&CPU_WFI &CPU_SPC>;
 		};
 
 		CPU2: cpu at 2 {
@@ -39,6 +41,7 @@
 			reg = <2>;
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc2>;
+			cpu-idle-states = <&CPU_WFI &CPU_SPC>;
 		};
 
 		CPU3: cpu at 3 {
@@ -48,6 +51,7 @@
 			reg = <3>;
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc3>;
+			cpu-idle-states = <&CPU_WFI &CPU_SPC>;
 		};
 
 		L2: l2-cache {
@@ -55,6 +59,22 @@
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
