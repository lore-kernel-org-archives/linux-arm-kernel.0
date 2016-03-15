From: niklas.soderlund+renesas@ragnatech.se (=?UTF-8?q?Niklas=20S=C3=B6derlund?=)
Date: Tue, 15 Mar 2016 13:42:04 +0100
Subject: [PATCHv2 27/31] ARM: dts: r8a7794: Reference both DMA controllers in
 HSCIF nodes
In-Reply-To: <1458045728-4758-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1458045728-4758-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Message-ID: <1458045728-4758-28-git-send-email-niklas.soderlund+renesas@ragnatech.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

R-Car Gen2 have two DMA controllers, which are equivalent. Add
references to both dmac0 and dmac1 so the driver can fallback to the
later if the first one is unavailable.

Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7794.dtsi | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index ccf3061..bc65153 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -507,8 +507,9 @@
 		clocks = <&mstp7_clks R8A7794_CLK_HSCIF0>, <&zs_clk>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
-		dmas = <&dmac0 0x39>, <&dmac0 0x3a>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x39>, <&dmac0 0x3a>,
+		       <&dmac1 0x39>, <&dmac1 0x3a>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -521,8 +522,9 @@
 		clocks = <&mstp7_clks R8A7794_CLK_HSCIF1>, <&zs_clk>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
-		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>,
+		       <&dmac1 0x4d>, <&dmac1 0x4e>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -535,8 +537,9 @@
 		clocks = <&mstp7_clks R8A7794_CLK_HSCIF2>, <&zs_clk>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
-		dmas = <&dmac0 0x3b>, <&dmac0 0x3c>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x3b>, <&dmac0 0x3c>,
+		       <&dmac1 0x3b>, <&dmac1 0x3c>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
-- 
2.7.2
