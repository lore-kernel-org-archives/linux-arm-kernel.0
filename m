From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:22:47 +0900
Subject: [PATCH 15/47] ARM: dts: r8a7790: Reference both DMA controllers in
 MMCIF nodes
In-Reply-To: <cover.1459732726.git.horms+renesas@verge.net.au>
References: <cover.1459732726.git.horms+renesas@verge.net.au>
Message-ID: <d1abb069a8e7f11b36b1b383fa4c54ce7cbc8ff7.1459732726.git.horms+renesas@verge.net.au>
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
 arch/arm/boot/dts/r8a7790.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 31b9b0abf458..b71b3e20b6e4 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -560,8 +560,9 @@
 		reg = <0 0xee200000 0 0x80>;
 		interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_MMCIF0>;
-		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>,
+		       <&dmac1 0xd1>, <&dmac1 0xd2>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		reg-io-width = <4>;
 		status = "disabled";
@@ -573,8 +574,9 @@
 		reg = <0 0xee220000 0 0x80>;
 		interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_MMCIF1>;
-		dmas = <&dmac0 0xe1>, <&dmac0 0xe2>;
-		dma-names = "tx", "rx";
+		dmas = <&dmac0 0xe1>, <&dmac0 0xe2>,
+		       <&dmac1 0xe1>, <&dmac1 0xe2>;
+		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&cpg_clocks>;
 		reg-io-width = <4>;
 		status = "disabled";
-- 
2.1.4
