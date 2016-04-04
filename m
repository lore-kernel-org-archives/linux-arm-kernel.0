From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:22:58 +0900
Subject: [PATCH 26/47] ARM: dts: r8a7793: Reference both DMA controllers in
 SCIFB nodes
In-Reply-To: <cover.1459732726.git.horms+renesas@verge.net.au>
References: <cover.1459732726.git.horms+renesas@verge.net.au>
Message-ID: <7451aa995c5556c64e5499f4767058e0466b4827.1459732726.git.horms+renesas@verge.net.au>
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
 arch/arm/boot/dts/r8a7793.dtsi | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index d83342306dea..d70479085b13 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -598,8 +598,9 @@
 		interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7793_CLK_SCIFB0>;
 		clock-names = "fck";
-		dmas = <&dmac0 0x3d>, <&dmac0 0x3e>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x3d>, <&dmac0 0x3e>,
+		       <&dmac1 0x3d>, <&dmac1 0x3e>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -611,8 +612,9 @@
 		interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7793_CLK_SCIFB1>;
 		clock-names = "fck";
-		dmas = <&dmac0 0x19>, <&dmac0 0x1a>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x19>, <&dmac0 0x1a>,
+		       <&dmac1 0x19>, <&dmac1 0x1a>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -624,8 +626,9 @@
 		interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7793_CLK_SCIFB2>;
 		clock-names = "fck";
-		dmas = <&dmac0 0x1d>, <&dmac0 0x1e>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x1d>, <&dmac0 0x1e>,
+		       <&dmac1 0x1d>, <&dmac1 0x1e>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
-- 
2.1.4
