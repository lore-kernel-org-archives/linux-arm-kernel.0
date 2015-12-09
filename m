From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Wed, 09 Dec 2015 09:40:53 +0000
Subject: [PATCH v3] arm64: dts: juno: Add idle-states to device tree
Message-ID: <1449654053.2818.6.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds idle-states bindings data collected through a set of
benchmarking experiments (latency and energy consumption) on Juno
boards. Latencies data represents the worst case scenarios as required
by the DT idle-states bindings.

Signed-off-by: Jon Medhurst <tixy@linaro.org>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---

I don't know if this needs any other Ack or can finally go in (through
arm soc tree?)

Changes since v2:
- Updated commit message to Lorenzo's suggested text.

Changes since v1:
- Updated latency times to those provided by Lorenzo
- Included Juno r1 dt

 arch/arm64/boot/dts/arm/juno-r1.dts | 28 ++++++++++++++++++++++++++++
 arch/arm64/boot/dts/arm/juno.dts    | 28 ++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
index 93bc3d7..8826f83 100644
--- a/arch/arm64/boot/dts/arm/juno-r1.dts
+++ b/arch/arm64/boot/dts/arm/juno-r1.dts
@@ -60,6 +60,28 @@
 			};
 		};
 
+		idle-states {
+			entry-method = "arm,psci";
+
+			CPU_SLEEP_0: cpu-sleep-0 {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x0010000>;
+				local-timer-stop;
+				entry-latency-us = <300>;
+				exit-latency-us = <1200>;
+				min-residency-us = <2000>;
+			};
+
+			CLUSTER_SLEEP_0: cluster-sleep-0 {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x1010000>;
+				local-timer-stop;
+				entry-latency-us = <300>;
+				exit-latency-us = <1200>;
+				min-residency-us = <2500>;
+			};
+		};
+
 		A57_0: cpu at 0 {
 			compatible = "arm,cortex-a57","arm,armv8";
 			reg = <0x0 0x0>;
@@ -67,6 +89,7 @@
 			enable-method = "psci";
 			next-level-cache = <&A57_L2>;
 			clocks = <&scpi_dvfs 0>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 		};
 
 		A57_1: cpu at 1 {
@@ -76,6 +99,7 @@
 			enable-method = "psci";
 			next-level-cache = <&A57_L2>;
 			clocks = <&scpi_dvfs 0>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 		};
 
 		A53_0: cpu at 100 {
@@ -85,6 +109,7 @@
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 		};
 
 		A53_1: cpu at 101 {
@@ -94,6 +119,7 @@
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 		};
 
 		A53_2: cpu at 102 {
@@ -103,6 +129,7 @@
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 		};
 
 		A53_3: cpu at 103 {
@@ -112,6 +139,7 @@
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 		};
 
 		A57_L2: l2-cache0 {
diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index 53442b5..dcfcf15 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -60,6 +60,28 @@
 			};
 		};
 
+		idle-states {
+			entry-method = "arm,psci";
+
+			CPU_SLEEP_0: cpu-sleep-0 {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x0010000>;
+				local-timer-stop;
+				entry-latency-us = <300>;
+				exit-latency-us = <1200>;
+				min-residency-us = <2000>;
+			};
+
+			CLUSTER_SLEEP_0: cluster-sleep-0 {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x1010000>;
+				local-timer-stop;
+				entry-latency-us = <300>;
+				exit-latency-us = <1200>;
+				min-residency-us = <2500>;
+			};
+		};
+
 		A57_0: cpu at 0 {
 			compatible = "arm,cortex-a57","arm,armv8";
 			reg = <0x0 0x0>;
@@ -67,6 +89,7 @@
 			enable-method = "psci";
 			next-level-cache = <&A57_L2>;
 			clocks = <&scpi_dvfs 0>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 		};
 
 		A57_1: cpu at 1 {
@@ -76,6 +99,7 @@
 			enable-method = "psci";
 			next-level-cache = <&A57_L2>;
 			clocks = <&scpi_dvfs 0>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 		};
 
 		A53_0: cpu at 100 {
@@ -85,6 +109,7 @@
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 		};
 
 		A53_1: cpu at 101 {
@@ -94,6 +119,7 @@
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 		};
 
 		A53_2: cpu at 102 {
@@ -103,6 +129,7 @@
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 		};
 
 		A53_3: cpu at 103 {
@@ -112,6 +139,7 @@
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 		};
 
 		A57_L2: l2-cache0 {
-- 
2.1.4
