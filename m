From: andy.tang@nxp.com (andy.tang at nxp.com)
Date: Mon, 7 Aug 2017 09:54:38 +0800
Subject: [PATCH 1/2 v2] arm64: dts: ls1088a: add cpu idle support
Message-ID: <1502070879-14106-1-git-send-email-andy.tang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yuantian Tang <andy.tang@nxp.com>

ls1088a supports another cpu idle state which is ph20 which saves
more power when cpu is idle.
It was implemented through psci firmware.

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
---
v2:
  -- no change

 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index c144d06..adc1ff5 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -62,6 +62,7 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x0>;
 			clocks = <&clockgen 1 0>;
+			cpu-idle-states = <&CPU_PH20>;
 			#cooling-cells = <2>;
 		};
 
@@ -70,6 +71,7 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x1>;
 			clocks = <&clockgen 1 0>;
+			cpu-idle-states = <&CPU_PH20>;
 		};
 
 		cpu2: cpu at 2 {
@@ -77,6 +79,7 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x2>;
 			clocks = <&clockgen 1 0>;
+			cpu-idle-states = <&CPU_PH20>;
 		};
 
 		cpu3: cpu at 3 {
@@ -84,6 +87,7 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x3>;
 			clocks = <&clockgen 1 0>;
+			cpu-idle-states = <&CPU_PH20>;
 		};
 
 		cpu4: cpu at 100 {
@@ -91,6 +95,7 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x100>;
 			clocks = <&clockgen 1 1>;
+			cpu-idle-states = <&CPU_PH20>;
 			#cooling-cells = <2>;
 		};
 
@@ -99,6 +104,7 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x101>;
 			clocks = <&clockgen 1 1>;
+			cpu-idle-states = <&CPU_PH20>;
 		};
 
 		cpu6: cpu at 102 {
@@ -106,6 +112,7 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x102>;
 			clocks = <&clockgen 1 1>;
+			cpu-idle-states = <&CPU_PH20>;
 		};
 
 		cpu7: cpu at 103 {
@@ -113,6 +120,16 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x103>;
 			clocks = <&clockgen 1 1>;
+			cpu-idle-states = <&CPU_PH20>;
+		};
+
+		CPU_PH20: cpu-ph20 {
+			compatible = "arm,idle-state";
+			idle-state-name = "PH20";
+			arm,psci-suspend-param = <0x00010000>;
+			entry-latency-us = <1000>;
+			exit-latency-us = <1000>;
+			min-residency-us = <3000>;
 		};
 	};
 
@@ -136,6 +153,11 @@
 			     <1 10 IRQ_TYPE_LEVEL_LOW>;/* Hypervisor PPI */
 	};
 
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
 	sysclk: sysclk {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-- 
2.1.0.27.g96db324
