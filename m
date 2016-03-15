From: niklas.soderlund+renesas@ragnatech.se (=?UTF-8?q?Niklas=20S=C3=B6derlund?=)
Date: Tue, 15 Mar 2016 13:41:59 +0100
Subject: [PATCHv2 22/31] ARM: dts: r8a7793: Reference both DMA controllers in
 SCIF nodes
In-Reply-To: <1458045728-4758-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1458045728-4758-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Message-ID: <1458045728-4758-23-git-send-email-niklas.soderlund+renesas@ragnatech.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

R-Car Gen2 have two DMA controllers, which are equivalent. Add
references to both dmac0 and dmac1 so the driver can fallback to the
later if the first one is unavailable.

Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7793.dtsi | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index be2e1fd..88164ac 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -641,8 +641,9 @@
 		clocks = <&mstp7_clks R8A7793_CLK_SCIF0>, <&zs_clk>,
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
@@ -655,8 +656,9 @@
 		clocks = <&mstp7_clks R8A7793_CLK_SCIF1>, <&zs_clk>,
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
@@ -669,8 +671,9 @@
 		clocks = <&mstp7_clks R8A7793_CLK_SCIF2>, <&zs_clk>,
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
@@ -683,8 +686,9 @@
 		clocks = <&mstp7_clks R8A7793_CLK_SCIF3>, <&zs_clk>,
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
@@ -697,8 +701,9 @@
 		clocks = <&mstp7_clks R8A7793_CLK_SCIF4>, <&zs_clk>,
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
@@ -711,8 +716,9 @@
 		clocks = <&mstp7_clks R8A7793_CLK_SCIF5>, <&zs_clk>,
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
2.7.2
