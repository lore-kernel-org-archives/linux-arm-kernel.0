From: lina.iyer@linaro.org (Lina Iyer)
Date: Thu, 25 Aug 2016 13:51:45 -0600
Subject: [PATCH v4 15/16] ARM64: dts: Add PSCI cpuidle support for MSM8916
In-Reply-To: <1472154706-40119-1-git-send-email-lina.iyer@linaro.org>
References: <1472154706-40119-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1472154706-40119-16-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device bindings for CPUs to suspend using PSCI as the enable-method.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 9681200..3029773 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -62,6 +62,8 @@
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x0>;
 			next-level-cache = <&L2_0>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_SPC>;
 		};
 
 		CPU1: cpu at 1 {
@@ -69,6 +71,8 @@
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x1>;
 			next-level-cache = <&L2_0>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_SPC>;
 		};
 
 		CPU2: cpu at 2 {
@@ -76,6 +80,8 @@
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x2>;
 			next-level-cache = <&L2_0>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_SPC>;
 		};
 
 		CPU3: cpu at 3 {
@@ -83,12 +89,30 @@
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x3>;
 			next-level-cache = <&L2_0>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_SPC>;
 		};
 
 		L2_0: l2-cache {
 		      compatible = "cache";
 		      cache-level = <2>;
 		};
+
+		idle-states {
+			CPU_SPC: spc {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x40000002>;
+				entry-latency-us = <130>;
+				exit-latency-us = <150>;
+				min-residency-us = <2000>;
+				local-timer-stop;
+			};
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
 	};
 
 	timer {
-- 
2.7.4
