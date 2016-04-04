From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:22:43 +0900
Subject: [PATCH 11/47] ARM: dts: r8a7790: Reference both DMA controllers in
 MSIOF nodes
In-Reply-To: <cover.1459732726.git.horms+renesas@verge.net.au>
References: <cover.1459732726.git.horms+renesas@verge.net.au>
Message-ID: <d1b771f79c50f28232ce3fbf583098d4ae13200a.1459732726.git.horms+renesas@verge.net.au>
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
 arch/arm/boot/dts/r8a7790.dtsi | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index fe1e9952d14b..102973c50294 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1508,8 +1508,9 @@
 		reg = <0 0xe6e20000 0 0x0064>;
 		interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7790_CLK_MSIOF0>;
-		dmas = <&dmac0 0x51>, <&dmac0 0x52>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x51>, <&dmac0 0x52>,
+		       <&dmac1 0x51>, <&dmac1 0x52>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -1521,8 +1522,9 @@
 		reg = <0 0xe6e10000 0 0x0064>;
 		interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_MSIOF1>;
-		dmas = <&dmac0 0x55>, <&dmac0 0x56>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x55>, <&dmac0 0x56>,
+		       <&dmac1 0x55>, <&dmac1 0x56>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -1534,8 +1536,9 @@
 		reg = <0 0xe6e00000 0 0x0064>;
 		interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_MSIOF2>;
-		dmas = <&dmac0 0x41>, <&dmac0 0x42>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x41>, <&dmac0 0x42>,
+		       <&dmac1 0x41>, <&dmac1 0x42>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -1547,8 +1550,9 @@
 		reg = <0 0xe6c90000 0 0x0064>;
 		interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_MSIOF3>;
-		dmas = <&dmac0 0x45>, <&dmac0 0x46>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0x45>, <&dmac0 0x46>,
+		       <&dmac1 0x45>, <&dmac1 0x46>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.1.4
