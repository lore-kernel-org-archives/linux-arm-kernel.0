From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 29 Oct 2014 13:59:08 +0900
Subject: [PATCH 02/19] ARM: shmobile: r8a73a4: Remove spurious dma-multiplexer
 base addresses
In-Reply-To: <cover.1414556943.git.horms+renesas@verge.net.au>
References: <cover.1414556943.git.horms+renesas@verge.net.au>
Message-ID: <6a8663f8bb5e3e2bf0d362744db844f2678d9b8b.1414556943.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As there is no reg property the dma-multiplexer nodes should
not include @...

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index ef152e3..8a70dcd 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -122,7 +122,7 @@
 			     <0 57 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	dmac: dma-multiplexer at 0 {
+	dmac: dma-multiplexer {
 		compatible = "renesas,shdma-mux";
 		#dma-cells = <1>;
 		dma-channels = <20>;
-- 
2.1.1
