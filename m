From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Jul 2018 14:03:32 +0200
Subject: [PATCH 1/9] arm64: dts: renesas: r8a77990: Remove non-existing STBE
 region
In-Reply-To: <cover.1532087303.git.horms+renesas@verge.net.au>
References: <cover.1532087303.git.horms+renesas@verge.net.au>
Message-ID: <4b03df5fc8c65659e41c3531b627ff615ed8ede9.1532087303.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

R-Car E3 does not have the Stream Buffer for EtherAVB-IF (STBE).

Note that the RAVB driver does not use this region.

Fixes: 913a78b575c313b8 ("arm64: dts: renesas: r8a77990: Add EthernetAVB device nodes")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77990.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77990.dtsi b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
index f8004608c595..615a0d2edffc 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
@@ -213,7 +213,7 @@
 		avb: ethernet at e6800000 {
 			compatible = "renesas,etheravb-r8a77990",
 				     "renesas,etheravb-rcar-gen3";
-			reg = <0 0xe6800000 0 0x800>, <0 0xe6a00000 0 0x10000>;
+			reg = <0 0xe6800000 0 0x800>;
 			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.11.0
