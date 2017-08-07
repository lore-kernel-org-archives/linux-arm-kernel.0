From: andy.tang@nxp.com (andy.tang at nxp.com)
Date: Mon, 7 Aug 2017 09:54:39 +0800
Subject: [PATCH 2/2 v2] arm64: dts: ls208xa: add cpu idle support
In-Reply-To: <1502070879-14106-1-git-send-email-andy.tang@nxp.com>
References: <1502070879-14106-1-git-send-email-andy.tang@nxp.com>
Message-ID: <1502070879-14106-2-git-send-email-andy.tang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yuantian Tang <andy.tang@nxp.com>

ls208xa supports another cpu idle state which is pw20 which saves
more power when cpu is idle.
It was implemented through psci firmware.

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
---
v2:
  - add ls2080a support and update the commit message accordingly

 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 17 +++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi | 17 +++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi |  5 +++++
 3 files changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
index d789c68..8d73930 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
@@ -53,6 +53,7 @@
 		compatible = "arm,cortex-a57";
 		reg = <0x0>;
 		clocks = <&clockgen 1 0>;
+		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster0_l2>;
 		#cooling-cells = <2>;
 	};
@@ -62,6 +63,7 @@
 		compatible = "arm,cortex-a57";
 		reg = <0x1>;
 		clocks = <&clockgen 1 0>;
+		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster0_l2>;
 	};
 
@@ -70,6 +72,7 @@
 		compatible = "arm,cortex-a57";
 		reg = <0x100>;
 		clocks = <&clockgen 1 1>;
+		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster1_l2>;
 		#cooling-cells = <2>;
 	};
@@ -79,6 +82,7 @@
 		compatible = "arm,cortex-a57";
 		reg = <0x101>;
 		clocks = <&clockgen 1 1>;
+		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster1_l2>;
 	};
 
@@ -87,6 +91,7 @@
 		compatible = "arm,cortex-a57";
 		reg = <0x200>;
 		clocks = <&clockgen 1 2>;
+		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster2_l2>;
 		#cooling-cells = <2>;
 	};
@@ -96,6 +101,7 @@
 		compatible = "arm,cortex-a57";
 		reg = <0x201>;
 		clocks = <&clockgen 1 2>;
+		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster2_l2>;
 	};
 
@@ -105,6 +111,7 @@
 		reg = <0x300>;
 		clocks = <&clockgen 1 3>;
 		next-level-cache = <&cluster3_l2>;
+		cpu-idle-states = <&CPU_PW20>;
 		#cooling-cells = <2>;
 	};
 
@@ -113,6 +120,7 @@
 		compatible = "arm,cortex-a57";
 		reg = <0x301>;
 		clocks = <&clockgen 1 3>;
+		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster3_l2>;
 	};
 
@@ -131,6 +139,15 @@
 	cluster3_l2: l2-cache3 {
 		compatible = "cache";
 	};
+
+	CPU_PW20: cpu-pw20 {
+		compatible = "arm,idle-state";
+		idle-state-name = "PW20";
+		arm,psci-suspend-param = <0x00010000>;
+		entry-latency-us = <2000>;
+		exit-latency-us = <2000>;
+		min-residency-us = <6000>;
+	};
 };
 
 &pcie1 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
index 5c695c6..6aa319d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
@@ -53,6 +53,7 @@
 		compatible = "arm,cortex-a72";
 		reg = <0x0>;
 		clocks = <&clockgen 1 0>;
+		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster0_l2>;
 		#cooling-cells = <2>;
 	};
@@ -62,6 +63,7 @@
 		compatible = "arm,cortex-a72";
 		reg = <0x1>;
 		clocks = <&clockgen 1 0>;
+		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster0_l2>;
 	};
 
@@ -70,6 +72,7 @@
 		compatible = "arm,cortex-a72";
 		reg = <0x100>;
 		clocks = <&clockgen 1 1>;
+		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster1_l2>;
 		#cooling-cells = <2>;
 	};
@@ -79,6 +82,7 @@
 		compatible = "arm,cortex-a72";
 		reg = <0x101>;
 		clocks = <&clockgen 1 1>;
+		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster1_l2>;
 	};
 
@@ -88,6 +92,7 @@
 		reg = <0x200>;
 		clocks = <&clockgen 1 2>;
 		next-level-cache = <&cluster2_l2>;
+		cpu-idle-states = <&CPU_PW20>;
 		#cooling-cells = <2>;
 	};
 
@@ -96,6 +101,7 @@
 		compatible = "arm,cortex-a72";
 		reg = <0x201>;
 		clocks = <&clockgen 1 2>;
+		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster2_l2>;
 	};
 
@@ -104,6 +110,7 @@
 		compatible = "arm,cortex-a72";
 		reg = <0x300>;
 		clocks = <&clockgen 1 3>;
+		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster3_l2>;
 		#cooling-cells = <2>;
 	};
@@ -113,6 +120,7 @@
 		compatible = "arm,cortex-a72";
 		reg = <0x301>;
 		clocks = <&clockgen 1 3>;
+		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster3_l2>;
 	};
 
@@ -131,6 +139,15 @@
 	cluster3_l2: l2-cache3 {
 		compatible = "cache";
 	};
+
+	CPU_PW20: cpu-pw20 {
+		compatible = "arm,idle-state";
+		idle-state-name = "PW20";
+		arm,psci-suspend-param = <0x00010000>;
+		entry-latency-us = <2000>;
+		exit-latency-us = <2000>;
+		min-residency-us = <6000>;
+	};
 };
 
 &pcie1 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 94cdd30..205b7f7 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -118,6 +118,11 @@
 		interrupts = <1 7 0x8>; /* PMU PPI, Level low type */
 	};
 
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
-- 
2.1.0.27.g96db324
