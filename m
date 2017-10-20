From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Oct 2017 12:28:36 +0200
Subject: [PATCH 09/42] ARM: dts: r8a7790: add cpu capacity-dmips-mhz
 information
In-Reply-To: <cover.1508493785.git.horms+renesas@verge.net.au>
References: <cover.1508493785.git.horms+renesas@verge.net.au>
Message-ID: <5bdc81259bb0efd5bd71820ef15757b70beae751.1508493785.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

The following 'capacity-dmips-mhz' dt property values are used:

Cortex-A15: 1024, Cortex-A7: 539

They have been derived form the cpu_efficiency values:

Cortex-A15: 3891, Cortex-A7: 2048

by scaling them so that the Cortex-A15s (big cores) use 1024.

The cpu_efficiency values were originally derived from the "Big.LITTLE
Processing with ARM Cortex?-A15 & Cortex-A7" white paper
(http://www.cl.cam.ac.uk/~rdm34/big.LITTLE.pdf). Table 1 lists 1.9x
(3891/2048) as the Cortex-A15 vs Cortex-A7 performance ratio for the
Dhrystone benchmark.

The following platform is affected once cpu-invariant accounting
support is re-connected to the task scheduler:

r8a7790-lager

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 17a48199b7a9..92b7f3bd8b69 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -56,6 +56,7 @@
 			clock-latency = <300000>; /* 300 us */
 			power-domains = <&sysc R8A7790_PD_CA15_CPU0>;
 			next-level-cache = <&L2_CA15>;
+			capacity-dmips-mhz = <1024>;
 
 			/* kHz - uV - OPPs unknown yet */
 			operating-points = <1400000 1000000>,
@@ -73,6 +74,7 @@
 			clock-frequency = <1300000000>;
 			power-domains = <&sysc R8A7790_PD_CA15_CPU1>;
 			next-level-cache = <&L2_CA15>;
+			capacity-dmips-mhz = <1024>;
 		};
 
 		cpu2: cpu at 2 {
@@ -82,6 +84,7 @@
 			clock-frequency = <1300000000>;
 			power-domains = <&sysc R8A7790_PD_CA15_CPU2>;
 			next-level-cache = <&L2_CA15>;
+			capacity-dmips-mhz = <1024>;
 		};
 
 		cpu3: cpu at 3 {
@@ -91,6 +94,7 @@
 			clock-frequency = <1300000000>;
 			power-domains = <&sysc R8A7790_PD_CA15_CPU3>;
 			next-level-cache = <&L2_CA15>;
+			capacity-dmips-mhz = <1024>;
 		};
 
 		cpu4: cpu at 100 {
@@ -100,6 +104,7 @@
 			clock-frequency = <780000000>;
 			power-domains = <&sysc R8A7790_PD_CA7_CPU0>;
 			next-level-cache = <&L2_CA7>;
+			capacity-dmips-mhz = <539>;
 		};
 
 		cpu5: cpu at 101 {
@@ -109,6 +114,7 @@
 			clock-frequency = <780000000>;
 			power-domains = <&sysc R8A7790_PD_CA7_CPU1>;
 			next-level-cache = <&L2_CA7>;
+			capacity-dmips-mhz = <539>;
 		};
 
 		cpu6: cpu at 102 {
@@ -118,6 +124,7 @@
 			clock-frequency = <780000000>;
 			power-domains = <&sysc R8A7790_PD_CA7_CPU2>;
 			next-level-cache = <&L2_CA7>;
+			capacity-dmips-mhz = <539>;
 		};
 
 		cpu7: cpu at 103 {
@@ -127,6 +134,7 @@
 			clock-frequency = <780000000>;
 			power-domains = <&sysc R8A7790_PD_CA7_CPU3>;
 			next-level-cache = <&L2_CA7>;
+			capacity-dmips-mhz = <539>;
 		};
 
 		L2_CA15: cache-controller-0 {
-- 
2.11.0
