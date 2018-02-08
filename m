From: ran.wang_1@nxp.com (Ran Wang)
Date: Thu, 8 Feb 2018 15:54:34 +0800
Subject: [PATCH 1/3] arm64: dts: ls1012a: add cpu idle support
Message-ID: <20180208075436.38443-1-ran.wang_1@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yuantian Tang <andy.tang@nxp.com>

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 82b272f..15421ef 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -70,6 +70,24 @@
 			reg = <0x0>;
 			clocks = <&clockgen 1 0>;
 			#cooling-cells = <2>;
+			cpu-idle-states = <&CPU_PH20>;
+		};
+	};
+
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
 		};
 	};
 
-- 
1.7.1
