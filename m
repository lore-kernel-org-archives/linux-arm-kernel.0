From: lina.iyer@linaro.org (Lina Iyer)
Date: Wed, 22 Jun 2016 13:36:49 -0600
Subject: [PATCH 14/14] ARM64: dts: Define CPU power domain for MSM8916
In-Reply-To: <1466624209-27432-1-git-send-email-lina.iyer@linaro.org>
References: <1466624209-27432-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1466624209-27432-15-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define power domain and the power states for the domain as defined by
the PSCI firmware. The 8916 firmware supports OS initiated method of
powering off the CPU clusters.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 3029773..208af00 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -64,6 +64,7 @@
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
+			power-domains = <&CPU_PD>;
 		};
 
 		CPU1: cpu at 1 {
@@ -73,6 +74,7 @@
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
+			power-domains = <&CPU_PD>;
 		};
 
 		CPU2: cpu at 2 {
@@ -82,6 +84,7 @@
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
+			power-domains = <&CPU_PD>;
 		};
 
 		CPU3: cpu at 3 {
@@ -91,6 +94,7 @@
 			next-level-cache = <&L2_0>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
+			power-domains = <&CPU_PD>;
 		};
 
 		L2_0: l2-cache {
@@ -110,6 +114,27 @@
 		};
 	};
 
+	CPU_PD: cpu-pd at 0 {
+		#power-domain-cells = <0>;
+		power-states = <&CLUSTER_RET>, <&CLUSTER_PWR_DWN>;
+	};
+
+	pd-power-states {
+		CLUSTER_RET: power-state at 1 {
+			state-param = <0x1000010>;
+			entry-latency-us = <500>;
+			exit-latency-us = <500>;
+			residency-us = <2000>;
+		 };
+
+		CLUSTER_PWR_DWN: power-state at 2 {
+			state-param = <0x1000030>;
+			entry-latency-us = <2000>;
+			exit-latency-us = <2000>;
+			residency-us = <6000>;
+		};
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
-- 
2.7.4
