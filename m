From: ran.wang_1@nxp.com (Ran Wang)
Date: Thu, 8 Feb 2018 15:54:35 +0800
Subject: [PATCH 2/3] arm64: dts: ls1043a: add cpu idle support
In-Reply-To: <20180208075436.38443-1-ran.wang_1@nxp.com>
References: <20180208075436.38443-1-ran.wang_1@nxp.com>
Message-ID: <20180208075436.38443-2-ran.wang_1@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yuantian Tang <andy.tang@nxp.com>

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 380e7c7..18828b9 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -81,6 +81,7 @@
 			clocks = <&clockgen 1 0>;
 			next-level-cache = <&l2>;
 			#cooling-cells = <2>;
+			cpu-idle-states = <&CPU_PH20>;
 		};
 
 		cpu1: cpu at 1 {
@@ -89,6 +90,7 @@
 			reg = <0x1>;
 			clocks = <&clockgen 1 0>;
 			next-level-cache = <&l2>;
+			cpu-idle-states = <&CPU_PH20>;
 		};
 
 		cpu2: cpu at 2 {
@@ -97,6 +99,7 @@
 			reg = <0x2>;
 			clocks = <&clockgen 1 0>;
 			next-level-cache = <&l2>;
+			cpu-idle-states = <&CPU_PH20>;
 		};
 
 		cpu3: cpu at 3 {
@@ -105,6 +108,7 @@
 			reg = <0x3>;
 			clocks = <&clockgen 1 0>;
 			next-level-cache = <&l2>;
+			cpu-idle-states = <&CPU_PH20>;
 		};
 
 		l2: l2-cache {
@@ -112,6 +116,23 @@
 		};
 	};
 
+	idle-states {
+		/*
+		 * PSCI node is not added default, U-boot will add missing
+		 * parts if it determines to use PSCI.
+		 */
+		entry-method = "arm,psci";
+
+		CPU_PH20: cpu-ph20 {
+			compatible = "arm,idle-state";
+			idle-state-name = "PH20";
+			arm,psci-suspend-param = <0x00010000>;
+			entry-latency-us = <1000>;
+			exit-latency-us = <1000>;
+			min-residency-us = <3000>;
+		};
+	};
+
 	memory at 80000000 {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0 0x80000000>;
-- 
1.7.1
