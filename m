From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 26 Feb 2016 08:53:00 +0900
Subject: [PATCH 11/19] ARM: dts: r8a7790: Add L2 cache-controller nodes
In-Reply-To: <cover.1456443769.git.horms+renesas@verge.net.au>
References: <cover.1456443769.git.horms+renesas@verge.net.au>
Message-ID: <fb1cecd40690e61e122d7249e7499c8d799feffb.1456443769.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add device nodes for the L2 caches, and link the CPU nodes to them.

The L2 cache for the Cortex-A15 CPU cores is 2 MiB large (organized as
128 KiB x 16 ways).

The L2 cache for the Cortex-A7 CPU cores is 512 KiB large (organized as
64 KiB x 8 ways).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 24b773ae133a..ba4c2530d79f 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -52,6 +52,7 @@
 			voltage-tolerance = <1>; /* 1% */
 			clocks = <&cpg_clocks R8A7790_CLK_Z>;
 			clock-latency = <300000>; /* 300 us */
+			next-level-cache = <&L2_CA15>;
 
 			/* kHz - uV - OPPs unknown yet */
 			operating-points = <1400000 1000000>,
@@ -67,6 +68,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <1>;
 			clock-frequency = <1300000000>;
+			next-level-cache = <&L2_CA15>;
 		};
 
 		cpu2: cpu at 2 {
@@ -74,6 +76,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <2>;
 			clock-frequency = <1300000000>;
+			next-level-cache = <&L2_CA15>;
 		};
 
 		cpu3: cpu at 3 {
@@ -81,6 +84,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <3>;
 			clock-frequency = <1300000000>;
+			next-level-cache = <&L2_CA15>;
 		};
 
 		cpu4: cpu at 4 {
@@ -88,6 +92,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x100>;
 			clock-frequency = <780000000>;
+			next-level-cache = <&L2_CA7>;
 		};
 
 		cpu5: cpu at 5 {
@@ -95,6 +100,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x101>;
 			clock-frequency = <780000000>;
+			next-level-cache = <&L2_CA7>;
 		};
 
 		cpu6: cpu at 6 {
@@ -102,6 +108,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x102>;
 			clock-frequency = <780000000>;
+			next-level-cache = <&L2_CA7>;
 		};
 
 		cpu7: cpu at 7 {
@@ -109,6 +116,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x103>;
 			clock-frequency = <780000000>;
+			next-level-cache = <&L2_CA7>;
 		};
 	};
 
@@ -131,6 +139,18 @@
 		};
 	};
 
+	L2_CA15: cache-controller at 0 {
+		compatible = "cache";
+		cache-unified;
+		cache-level = <2>;
+	};
+
+	L2_CA7: cache-controller at 1 {
+		compatible = "cache";
+		cache-unified;
+		cache-level = <2>;
+	};
+
 	gic: interrupt-controller at f1001000 {
 		compatible = "arm,gic-400";
 		#interrupt-cells = <3>;
-- 
2.7.0.rc3.207.g0ac5344
