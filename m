From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Wed, 30 Aug 2017 15:41:19 +0100
Subject: [PATCH 3/4] arm: dts: exynos: add exynos5422 cpu capacity-dmips-mhz
 information
In-Reply-To: <20170830144120.9312-1-dietmar.eggemann@arm.com>
References: <20170830144120.9312-1-dietmar.eggemann@arm.com>
Message-ID: <20170830144120.9312-4-dietmar.eggemann@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

The following platforms are affected once cpu-invariant accounting
support is re-connected to the task scheduler:

odroidxu3, odroidxu3-lite, odroidxu4

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 arch/arm/boot/dts/exynos5422-cpus.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-cpus.dtsi b/arch/arm/boot/dts/exynos5422-cpus.dtsi
index bf3c6f1ec4ee..ec01d8020c2d 100644
--- a/arch/arm/boot/dts/exynos5422-cpus.dtsi
+++ b/arch/arm/boot/dts/exynos5422-cpus.dtsi
@@ -35,6 +35,7 @@
 			cooling-min-level = <0>;
 			cooling-max-level = <11>;
 			#cooling-cells = <2>; /* min followed by max */
+			capacity-dmips-mhz = <539>;
 		};
 
 		cpu1: cpu at 101 {
@@ -47,6 +48,7 @@
 			cooling-min-level = <0>;
 			cooling-max-level = <11>;
 			#cooling-cells = <2>; /* min followed by max */
+			capacity-dmips-mhz = <539>;
 		};
 
 		cpu2: cpu at 102 {
@@ -59,6 +61,7 @@
 			cooling-min-level = <0>;
 			cooling-max-level = <11>;
 			#cooling-cells = <2>; /* min followed by max */
+			capacity-dmips-mhz = <539>;
 		};
 
 		cpu3: cpu at 103 {
@@ -71,6 +74,7 @@
 			cooling-min-level = <0>;
 			cooling-max-level = <11>;
 			#cooling-cells = <2>; /* min followed by max */
+			capacity-dmips-mhz = <539>;
 		};
 
 		cpu4: cpu at 0 {
@@ -84,6 +88,7 @@
 			cooling-min-level = <0>;
 			cooling-max-level = <15>;
 			#cooling-cells = <2>; /* min followed by max */
+			capacity-dmips-mhz = <1024>;
 		};
 
 		cpu5: cpu at 1 {
@@ -96,6 +101,7 @@
 			cooling-min-level = <0>;
 			cooling-max-level = <15>;
 			#cooling-cells = <2>; /* min followed by max */
+			capacity-dmips-mhz = <1024>;
 		};
 
 		cpu6: cpu at 2 {
@@ -108,6 +114,7 @@
 			cooling-min-level = <0>;
 			cooling-max-level = <15>;
 			#cooling-cells = <2>; /* min followed by max */
+			capacity-dmips-mhz = <1024>;
 		};
 
 		cpu7: cpu at 3 {
@@ -120,6 +127,7 @@
 			cooling-min-level = <0>;
 			cooling-max-level = <15>;
 			#cooling-cells = <2>; /* min followed by max */
+			capacity-dmips-mhz = <1024>;
 		};
 	};
 };
-- 
2.11.0
