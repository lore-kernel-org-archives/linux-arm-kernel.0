From: lina.iyer@linaro.org (Lina Iyer)
Date: Tue,  1 Mar 2016 14:15:31 -0700
Subject: [RFC v3 12/12] ARM64: dts: Define CPU power domain for MSM8916
In-Reply-To: <1456866931-37851-1-git-send-email-lina.iyer@linaro.org>
References: <1456866931-37851-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1456866931-37851-14-git-send-email-lina.iyer@linaro.org>
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
index b7839a8..62dade8 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -63,6 +63,7 @@
 			reg = <0x0>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
+			power-domains = <&CPU_PD>;
 		};
 
 		CPU1: cpu at 1 {
@@ -71,6 +72,7 @@
 			reg = <0x1>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
+			power-domains = <&CPU_PD>;
 		};
 
 		CPU2: cpu at 2 {
@@ -79,6 +81,7 @@
 			reg = <0x2>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
+			power-domains = <&CPU_PD>;
 		};
 
 		CPU3: cpu at 3 {
@@ -87,6 +90,7 @@
 			reg = <0x3>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SPC>;
+			power-domains = <&CPU_PD>;
 		};
 
 		idle-states {
@@ -101,6 +105,27 @@
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
2.1.4
