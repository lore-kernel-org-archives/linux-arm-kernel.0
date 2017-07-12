From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 12 Jul 2017 12:35:53 +0200
Subject: [PATCH] arm64: dts: r8a7796: Add missing second pair of DMA names to
 MSIOF nodes
Message-ID: <1499855753-21630-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MSIOF0 and MSIOF1 are tied to two DMA controllers through two pairs of
DMA specifiers.  However, the second pair of corresponding DMA names was
missing.

Fixes: 80fab06e258da762 ("arm64: dts: r8a7796: Add all MSIOF nodes")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index c7bbb501ebe06826..f63f9107f453b5b7 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -1000,7 +1000,7 @@
 			clocks = <&cpg CPG_MOD 211>;
 			dmas = <&dmac1 0x41>, <&dmac1 0x40>,
 			       <&dmac2 0x41>, <&dmac2 0x40>;
-			dma-names = "tx", "rx";
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
 			resets = <&cpg 211>;
 			#address-cells = <1>;
@@ -1016,7 +1016,7 @@
 			clocks = <&cpg CPG_MOD 210>;
 			dmas = <&dmac1 0x43>, <&dmac1 0x42>,
 			       <&dmac2 0x43>, <&dmac2 0x42>;
-			dma-names = "tx", "rx";
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
 			resets = <&cpg 210>;
 			#address-cells = <1>;
-- 
2.7.4
