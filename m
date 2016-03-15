From: niklas.soderlund+renesas@ragnatech.se (=?UTF-8?q?Niklas=20S=C3=B6derlund?=)
Date: Tue, 15 Mar 2016 13:41:46 +0100
Subject: [PATCHv2 09/31] ARM: dts: r8a7790: Reference both DMA controllers in
 MMCIF nodes
In-Reply-To: <1458045728-4758-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1458045728-4758-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Message-ID: <1458045728-4758-10-git-send-email-niklas.soderlund+renesas@ragnatech.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

R-Car Gen2 have two DMA controllers, which are equivalent. Add
references to both dmac0 and dmac1 so the driver can fallback to the
later if the first one is unavailable.

Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7790.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 31b9b0a..b71b3e2 100644
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
2.7.2
