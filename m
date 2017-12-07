From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  7 Dec 2017 10:53:57 +0100
Subject: [PATCH 54/54] arm64: dts: renesas: r8a77970: use SYSC power domain
 macros
In-Reply-To: <cover.1512640145.git.horms+renesas@verge.net.au>
References: <cover.1512640145.git.horms+renesas@verge.net.au>
Message-ID: <8aba250d7800702bbd2f6a91174e01b9a84ed2dd.1512640145.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Now that the commit 833bdb47c826 ("dt-bindings: power: add R8A77970 SYSC
power domain definitions") has hit Linus' tree, we can replace the  bare
numbers  (we had to use to avoid a cross tree dependency) with these macro
definitions...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77970.dtsi | 32 +++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77970.dtsi b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
index 7bb224595c95..c35a117fc447 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -33,14 +33,14 @@
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0>;
 			clocks = <&cpg CPG_CORE R8A77970_CLK_Z2>;
-			power-domains = <&sysc 5>;
+			power-domains = <&sysc R8A77970_PD_CA53_CPU0>;
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
 		};
 
 		L2_CA53: cache-controller {
 			compatible = "cache";
-			power-domains = <&sysc 21>;
+			power-domains = <&sysc R8A77970_PD_CA53_SCU>;
 			cache-unified;
 			cache-level = <2>;
 		};
@@ -88,7 +88,7 @@
 				      IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&cpg CPG_MOD 408>;
 			clock-names = "clk";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
 			resets = <&cpg 408>;
 		};
 
@@ -109,7 +109,7 @@
 				     "renesas,rcar-gen3-wdt";
 			reg = <0 0xe6020000 0 0x0c>;
 			clocks = <&cpg CPG_MOD 402>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
 			resets = <&cpg 402>;
 			status = "disabled";
 		};
@@ -190,7 +190,7 @@
 				      GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH
 				      GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 407>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
 			resets = <&cpg 407>;
 		};
 
@@ -217,7 +217,7 @@
 					  "ch4", "ch5", "ch6", "ch7";
 			clocks = <&cpg CPG_MOD 218>;
 			clock-names = "fck";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
 			resets = <&cpg 218>;
 			#dma-cells = <1>;
 			dma-channels = <8>;
@@ -245,7 +245,7 @@
 					  "ch4", "ch5", "ch6", "ch7";
 			clocks = <&cpg CPG_MOD 217>;
 			clock-names = "fck";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
 			resets = <&cpg 217>;
 			#dma-cells = <1>;
 			dma-channels = <8>;
@@ -268,7 +268,7 @@
 			dmas = <&dmac1 0x31>, <&dmac1 0x30>,
 			       <&dmac2 0x31>, <&dmac2 0x30>;
 			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
 			resets = <&cpg 520>;
 			status = "disabled";
 		};
@@ -286,7 +286,7 @@
 			dmas = <&dmac1 0x33>, <&dmac1 0x32>,
 			       <&dmac2 0x33>, <&dmac2 0x32>;
 			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
 			resets = <&cpg 519>;
 			status = "disabled";
 		};
@@ -304,7 +304,7 @@
 			dmas = <&dmac1 0x35>, <&dmac1 0x34>,
 			       <&dmac2 0x35>, <&dmac2 0x34>;
 			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
 			resets = <&cpg 518>;
 			status = "disabled";
 		};
@@ -321,7 +321,7 @@
 			dmas = <&dmac1 0x37>, <&dmac1 0x36>,
 			       <&dmac2 0x37>, <&dmac2 0x36>;
 			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
 			resets = <&cpg 517>;
 			status = "disabled";
 		};
@@ -339,7 +339,7 @@
 			dmas = <&dmac1 0x51>, <&dmac1 0x50>,
 			       <&dmac2 0x51>, <&dmac2 0x50>;
 			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
 			resets = <&cpg 207>;
 			status = "disabled";
 		};
@@ -357,7 +357,7 @@
 			dmas = <&dmac1 0x53>, <&dmac1 0x52>,
 			       <&dmac2 0x53>, <&dmac2 0x52>;
 			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
 			resets = <&cpg 206>;
 			status = "disabled";
 		};
@@ -375,7 +375,7 @@
 			dmas = <&dmac1 0x57>, <&dmac1 0x56>,
 			       <&dmac2 0x57>, <&dmac2 0x56>;
 			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
 			resets = <&cpg 204>;
 			status = "disabled";
 		};
@@ -392,7 +392,7 @@
 			dmas = <&dmac1 0x59>, <&dmac1 0x58>,
 			       <&dmac2 0x59>, <&dmac2 0x58>;
 			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
 			resets = <&cpg 203>;
 			status = "disabled";
 		};
@@ -434,7 +434,7 @@
 					  "ch20", "ch21", "ch22", "ch23",
 					  "ch24";
 			clocks = <&cpg CPG_MOD 812>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
 			resets = <&cpg 812>;
 			phy-mode = "rgmii-id";
 			iommus = <&ipmmu_rt 3>;
-- 
2.11.0
