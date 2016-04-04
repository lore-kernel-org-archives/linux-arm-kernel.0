From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:23:06 +0900
Subject: [PATCH 34/47] ARM: dts: r8a7794: Reference both DMA controllers in
 SCIF nodes
In-Reply-To: <cover.1459732726.git.horms+renesas@verge.net.au>
References: <cover.1459732726.git.horms+renesas@verge.net.au>
Message-ID: <43a8d7b6d7180a4d91d86acbe28bd40127d238d0.1459732726.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>

R-Car Gen2 have two DMA controllers, which are equivalent. Add
references to both dmac0 and dmac1 so the driver can fallback to the
later if the first one is unavailable.

Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index bc6515303015..982f089f218e 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -423,8 +423,9 @@
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF0>, <&zs_clk>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
-		dmas = <&dmac0 0x29>, <&dmac0 0x2a>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x29>, <&dmac0 0x2a>,
+		       <&dmac1 0x29>, <&dmac1 0x2a>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -437,8 +438,9 @@
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF1>, <&zs_clk>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
-		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>,
+		       <&dmac1 0x2d>, <&dmac1 0x2e>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -451,8 +453,9 @@
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF2>, <&zs_clk>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
-		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>,
+		       <&dmac1 0x2b>, <&dmac1 0x2c>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -465,8 +468,9 @@
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF3>, <&zs_clk>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
-		dmas = <&dmac0 0x2f>, <&dmac0 0x30>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x2f>, <&dmac0 0x30>,
+		       <&dmac1 0x2f>, <&dmac1 0x30>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -479,8 +483,9 @@
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF4>, <&zs_clk>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
-		dmas = <&dmac0 0xfb>, <&dmac0 0xfc>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0xfb>, <&dmac0 0xfc>,
+		       <&dmac1 0xfb>, <&dmac1 0xfc>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -493,8 +498,9 @@
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF5>, <&zs_clk>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
-		dmas = <&dmac0 0xfd>, <&dmac0 0xfe>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0xfd>, <&dmac0 0xfe>,
+		       <&dmac1 0xfd>, <&dmac1 0xfe>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
-- 
2.1.4
