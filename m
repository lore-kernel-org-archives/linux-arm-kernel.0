From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:15:28 +0200
Subject: [PATCH 066/102] arm64: dts: renesas: r8a77980: use SYSC power domain
 macros
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <1184ea3fd4c83a7bf6a8f51fcf73d620706557ce.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Now that the commit 7755b40d07a8 ("dt-bindings: power: add R8A77980 SYSC
power domain definitions") has hit Linus' tree, we can replace  the bare
numbers (we had to use to avoid a cross tree dependency) with these macro
definitions...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77980.dtsi | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77980.dtsi b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
index fddbaf250087..5c865fcd3986 100644
--- a/arch/arm64/boot/dts/renesas/r8a77980.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/clock/r8a77980-cpg-mssr.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/r8a77980-sysc.h>
 
 / {
 	compatible = "renesas,r8a77980";
@@ -24,14 +25,14 @@
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0>;
 			clocks = <&cpg CPG_CORE R8A77980_CLK_Z2>;
-			power-domains = <&sysc 5>;
+			power-domains = <&sysc R8A77980_PD_CA53_CPU0>;
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
 		};
 
 		L2_CA53: cache-controller {
 			compatible = "cache";
-			power-domains = <&sysc 21>;
+			power-domains = <&sysc R8A77980_PD_CA53_SCU>;
 			cache-unified;
 			cache-level = <2>;
 		};
@@ -110,7 +111,7 @@
 			dmas = <&dmac1 0x31>, <&dmac1 0x30>,
 			       <&dmac2 0x31>, <&dmac2 0x30>;
 			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
 			resets = <&cpg 520>;
 			status = "disabled";
 		};
@@ -128,7 +129,7 @@
 			dmas = <&dmac1 0x33>, <&dmac1 0x32>,
 			       <&dmac2 0x33>, <&dmac2 0x32>;
 			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
 			resets = <&cpg 519>;
 			status = "disabled";
 		};
@@ -146,7 +147,7 @@
 			dmas = <&dmac1 0x35>, <&dmac1 0x34>,
 			       <&dmac2 0x35>, <&dmac2 0x34>;
 			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
 			resets = <&cpg 518>;
 			status = "disabled";
 		};
@@ -164,7 +165,7 @@
 			dmas = <&dmac1 0x37>, <&dmac1 0x36>,
 			       <&dmac2 0x37>, <&dmac2 0x36>;
 			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
 			resets = <&cpg 517>;
 			status = "disabled";
 		};
@@ -206,7 +207,7 @@
 					  "ch20", "ch21", "ch22", "ch23",
 					  "ch24";
 			clocks = <&cpg CPG_MOD 812>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
 			resets = <&cpg 812>;
 			phy-mode = "rgmii";
 			#address-cells = <1>;
@@ -226,7 +227,7 @@
 			dmas = <&dmac1 0x51>, <&dmac1 0x50>,
 			       <&dmac2 0x51>, <&dmac2 0x50>;
 			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
 			resets = <&cpg 207>;
 			status = "disabled";
 		};
@@ -244,7 +245,7 @@
 			dmas = <&dmac1 0x53>, <&dmac1 0x52>,
 			       <&dmac2 0x53>, <&dmac2 0x52>;
 			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
 			resets = <&cpg 206>;
 			status = "disabled";
 		};
@@ -262,7 +263,7 @@
 			dmas = <&dmac1 0x57>, <&dmac1 0x56>,
 			       <&dmac2 0x57>, <&dmac2 0x56>;
 			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
 			resets = <&cpg 204>;
 			status = "disabled";
 		};
@@ -280,7 +281,7 @@
 			dmas = <&dmac1 0x59>, <&dmac1 0x58>,
 			       <&dmac2 0x59>, <&dmac2 0x58>;
 			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
 			resets = <&cpg 203>;
 			status = "disabled";
 		};
@@ -313,7 +314,7 @@
 					  "ch12", "ch13", "ch14", "ch15";
 			clocks = <&cpg CPG_MOD 218>;
 			clock-names = "fck";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
 			resets = <&cpg 218>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
@@ -347,7 +348,7 @@
 					  "ch12", "ch13", "ch14", "ch15";
 			clocks = <&cpg CPG_MOD 217>;
 			clock-names = "fck";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
 			resets = <&cpg 217>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
@@ -359,7 +360,7 @@
 			reg = <0 0xee140000 0 0x2000>;
 			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 314>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
 			resets = <&cpg 314>;
 			max-frequency = <200000000>;
 			status = "disabled";
@@ -378,7 +379,7 @@
 				      IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&cpg CPG_MOD 408>;
 			clock-names = "clk";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
 			resets = <&cpg 408>;
 		};
 
-- 
2.11.0
