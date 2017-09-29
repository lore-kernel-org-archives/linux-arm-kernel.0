From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 Sep 2017 13:52:16 +0200
Subject: [PATCH 07/22] arm64: dts: renesas: r8a77995: Use r8a7795-sysc binding
 definitions
In-Reply-To: <cover.1506678250.git.horms+renesas@verge.net.au>
References: <cover.1506678250.git.horms+renesas@verge.net.au>
Message-ID: <9066b042b4502f711c5207662ec0d26be1732aff.1506678250.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Replace the hardcoded power domain indices by R8A77995_PD_* symbols.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77995.dtsi | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
index 72c303362b16..a5b769b840e9 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
@@ -11,6 +11,7 @@
 
 #include <dt-bindings/clock/renesas-cpg-mssr.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/r8a77995-sysc.h>
 
 / {
 	compatible = "renesas,r8a77995";
@@ -30,14 +31,14 @@
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x0>;
 			device_type = "cpu";
-			power-domains = <&sysc 5>;
+			power-domains = <&sysc R8A77995_PD_CA53_CPU0>;
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
 		};
 
 		L2_CA53: cache-controller-1 {
 			compatible = "cache";
-			power-domains = <&sysc 21>;
+			power-domains = <&sysc R8A77995_PD_CA53_SCU>;
 			cache-unified;
 			cache-level = <2>;
 		};
@@ -76,7 +77,7 @@
 					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&cpg CPG_MOD 408>;
 			clock-names = "clk";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
 			resets = <&cpg 408>;
 		};
 
@@ -97,7 +98,7 @@
 				     "renesas,rcar-gen3-wdt";
 			reg = <0 0xe6020000 0 0x0c>;
 			clocks = <&cpg CPG_MOD 402>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
 			resets = <&cpg 402>;
 			status = "disabled";
 		};
@@ -147,7 +148,7 @@
 				 <&cpg CPG_CORE 16>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
 			resets = <&cpg 310>;
 			status = "disabled";
 		};
-- 
2.1.4
