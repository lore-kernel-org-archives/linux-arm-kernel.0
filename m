From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  8 Sep 2016 09:43:08 +0200
Subject: [PATCH 12/30] arm64: dts: r8a7795: Add SoC-specific compatible
 property to audio-dmac nodes
In-Reply-To: <cover.1473320411.git.horms+renesas@verge.net.au>
References: <cover.1473320411.git.horms+renesas@verge.net.au>
Message-ID: <f826473520e7aba2e416f79a3acbd6da3921e0a2.1473320411.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The audio-dmac nodes used the generic compatible property only.
Add the SoC-specific one, to make it future proof.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 5d59e7fe7bbc..64899b556a0e 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -328,7 +328,8 @@
 		};
 
 		audma0: dma-controller at ec700000 {
-			compatible = "renesas,rcar-dmac";
+			compatible = "renesas,dmac-r8a7795",
+				     "renesas,rcar-dmac";
 			reg = <0 0xec700000 0 0x10000>;
 			interrupts = <GIC_SPI 350 IRQ_TYPE_LEVEL_HIGH
 				      GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH
@@ -360,7 +361,8 @@
 		};
 
 		audma1: dma-controller@ec720000 {
-			compatible = "renesas,rcar-dmac";
+			compatible = "renesas,dmac-r8a7795",
+				     "renesas,rcar-dmac";
 			reg = <0 0xec720000 0 0x10000>;
 			interrupts = <GIC_SPI 351 IRQ_TYPE_LEVEL_HIGH
 				      GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH
-- 
2.7.0.rc3.207.g0ac5344
