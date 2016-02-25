From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 26 Feb 2016 08:53:01 +0900
Subject: [PATCH 12/19] ARM: dts: r8a7791: Add L2 cache-controller node
In-Reply-To: <cover.1456443769.git.horms+renesas@verge.net.au>
References: <cover.1456443769.git.horms+renesas@verge.net.au>
Message-ID: <8ffe93a5b2cb55d4da9c285d9277699bdb828b47.1456443769.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a device node for the L2 cache, and link the CPU nodes to it.

The L2 cache for the Cortex-A15 CPU cores is 1 MiB large (organized as
64 KiB x 16 ways).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index f1732dde114b..6439f0569fe2 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -51,6 +51,7 @@
 			voltage-tolerance = <1>; /* 1% */
 			clocks = <&cpg_clocks R8A7791_CLK_Z>;
 			clock-latency = <300000>; /* 300 us */
+			next-level-cache = <&L2_CA15>;
 
 			/* kHz - uV - OPPs unknown yet */
 			operating-points = <1500000 1000000>,
@@ -66,6 +67,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <1>;
 			clock-frequency = <1500000000>;
+			next-level-cache = <&L2_CA15>;
 		};
 	};
 
@@ -88,6 +90,12 @@
 		};
 	};
 
+	L2_CA15: cache-controller at 0 {
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
