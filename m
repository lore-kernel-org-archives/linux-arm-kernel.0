From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Jul 2018 14:05:11 +0200
Subject: [PATCH 3/9] ARM: dts: r8a77(43|9[013]): Add missing OPP properties
 for CPUs
In-Reply-To: <cover.1532086734.git.horms+renesas@verge.net.au>
References: <cover.1532086734.git.horms+renesas@verge.net.au>
Message-ID: <422ee8b4c445f4ff545857465514634d21f5d2b2.1532086734.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Viresh Kumar <viresh.kumar@linaro.org>

The OPP properties, like "operating-points", should either be present
for all the CPUs of a cluster or none. If these are present only for a
subset of CPUs of a cluster then things will start falling apart as soon
as the CPUs are brought online in a different order. For example, this
will happen because the operating system looks for such properties in
the CPU node it is trying to bring up, so that it can create an OPP
table.

Add such missing properties.

Fix other missing properties (like, clock latency, voltage tolerance,
etc) as well to make it all work.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7743.dtsi |  9 +++++++++
 arch/arm/boot/dts/r8a7790.dtsi | 34 ++++++++++++++++++++++++++++++++--
 arch/arm/boot/dts/r8a7791.dtsi | 14 ++++++++++++--
 arch/arm/boot/dts/r8a7793.dtsi | 15 +++++++++++++--
 4 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 142949d7066f..e4fb31c4f0ee 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -98,8 +98,17 @@
 			reg = <1>;
 			clock-frequency = <1500000000>;
 			clocks = <&cpg CPG_CORE R8A7743_CLK_Z>;
+			clock-latency = <300000>; /* 300 us */
 			power-domains = <&sysc R8A7743_PD_CA15_CPU1>;
 			next-level-cache = <&L2_CA15>;
+
+			/* kHz - uV - OPPs unknown yet */
+			operating-points = <1500000 1000000>,
+					   <1312500 1000000>,
+					   <1125000 1000000>,
+					   < 937500 1000000>,
+					   < 750000 1000000>,
+					   < 375000 1000000>;
 		};
 
 		L2_CA15: cache-controller-0 {
diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 4d06b154bd7e..c4324b1a2ec4 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -79,12 +79,12 @@
 			compatible = "arm,cortex-a15";
 			reg = <0>;
 			clock-frequency = <1300000000>;
-			voltage-tolerance = <1>; /* 1% */
 			clocks = <&cpg CPG_CORE R8A7790_CLK_Z>;
-			clock-latency = <300000>; /* 300 us */
 			power-domains = <&sysc R8A7790_PD_CA15_CPU0>;
 			next-level-cache = <&L2_CA15>;
 			capacity-dmips-mhz = <1024>;
+			voltage-tolerance = <1>; /* 1% */
+			clock-latency = <300000>; /* 300 us */
 
 			/* kHz - uV - OPPs unknown yet */
 			operating-points = <1400000 1000000>,
@@ -104,6 +104,16 @@
 			power-domains = <&sysc R8A7790_PD_CA15_CPU1>;
 			next-level-cache = <&L2_CA15>;
 			capacity-dmips-mhz = <1024>;
+			voltage-tolerance = <1>; /* 1% */
+			clock-latency = <300000>; /* 300 us */
+
+			/* kHz - uV - OPPs unknown yet */
+			operating-points = <1400000 1000000>,
+					   <1225000 1000000>,
+					   <1050000 1000000>,
+					   < 875000 1000000>,
+					   < 700000 1000000>,
+					   < 350000 1000000>;
 		};
 
 		cpu2: cpu at 2 {
@@ -115,6 +125,16 @@
 			power-domains = <&sysc R8A7790_PD_CA15_CPU2>;
 			next-level-cache = <&L2_CA15>;
 			capacity-dmips-mhz = <1024>;
+			voltage-tolerance = <1>; /* 1% */
+			clock-latency = <300000>; /* 300 us */
+
+			/* kHz - uV - OPPs unknown yet */
+			operating-points = <1400000 1000000>,
+					   <1225000 1000000>,
+					   <1050000 1000000>,
+					   < 875000 1000000>,
+					   < 700000 1000000>,
+					   < 350000 1000000>;
 		};
 
 		cpu3: cpu at 3 {
@@ -126,6 +146,16 @@
 			power-domains = <&sysc R8A7790_PD_CA15_CPU3>;
 			next-level-cache = <&L2_CA15>;
 			capacity-dmips-mhz = <1024>;
+			voltage-tolerance = <1>; /* 1% */
+			clock-latency = <300000>; /* 300 us */
+
+			/* kHz - uV - OPPs unknown yet */
+			operating-points = <1400000 1000000>,
+					   <1225000 1000000>,
+					   <1050000 1000000>,
+					   < 875000 1000000>,
+					   < 700000 1000000>,
+					   < 350000 1000000>;
 		};
 
 		cpu4: cpu at 100 {
diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 6e1dd7ad7bd6..d1d726a1364a 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -78,11 +78,11 @@
 			compatible = "arm,cortex-a15";
 			reg = <0>;
 			clock-frequency = <1500000000>;
-			voltage-tolerance = <1>; /* 1% */
 			clocks = <&cpg CPG_CORE R8A7791_CLK_Z>;
-			clock-latency = <300000>; /* 300 us */
 			power-domains = <&sysc R8A7791_PD_CA15_CPU0>;
 			next-level-cache = <&L2_CA15>;
+			voltage-tolerance = <1>; /* 1% */
+			clock-latency = <300000>; /* 300 us */
 
 			/* kHz - uV - OPPs unknown yet */
 			operating-points = <1500000 1000000>,
@@ -101,6 +101,16 @@
 			clocks = <&cpg CPG_CORE R8A7791_CLK_Z>;
 			power-domains = <&sysc R8A7791_PD_CA15_CPU1>;
 			next-level-cache = <&L2_CA15>;
+			voltage-tolerance = <1>; /* 1% */
+			clock-latency = <300000>; /* 300 us */
+
+			/* kHz - uV - OPPs unknown yet */
+			operating-points = <1500000 1000000>,
+					   <1312500 1000000>,
+					   <1125000 1000000>,
+					   < 937500 1000000>,
+					   < 750000 1000000>,
+					   < 375000 1000000>;
 		};
 
 		L2_CA15: cache-controller-0 {
diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 4abecfc0ca98..1e6439b85a6b 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -70,10 +70,10 @@
 			compatible = "arm,cortex-a15";
 			reg = <0>;
 			clock-frequency = <1500000000>;
-			voltage-tolerance = <1>; /* 1% */
 			clocks = <&cpg CPG_CORE R8A7793_CLK_Z>;
-			clock-latency = <300000>; /* 300 us */
 			power-domains = <&sysc R8A7793_PD_CA15_CPU0>;
+			voltage-tolerance = <1>; /* 1% */
+			clock-latency = <300000>; /* 300 us */
 
 			/* kHz - uV - OPPs unknown yet */
 			operating-points = <1500000 1000000>,
@@ -92,6 +92,17 @@
 			clock-frequency = <1500000000>;
 			clocks = <&cpg CPG_CORE R8A7793_CLK_Z>;
 			power-domains = <&sysc R8A7793_PD_CA15_CPU1>;
+			voltage-tolerance = <1>; /* 1% */
+			clock-latency = <300000>; /* 300 us */
+
+			/* kHz - uV - OPPs unknown yet */
+			operating-points = <1500000 1000000>,
+					   <1312500 1000000>,
+					   <1125000 1000000>,
+					   < 937500 1000000>,
+					   < 750000 1000000>,
+					   < 375000 1000000>;
+			next-level-cache = <&L2_CA15>;
 		};
 
 		L2_CA15: cache-controller-0 {
-- 
2.11.0
