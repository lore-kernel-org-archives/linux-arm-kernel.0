From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  6 Dec 2017 11:21:58 +0100
Subject: [PATCH 03/61] ARM: dts: r8a7778: Use R-Car Gen1 Ether fallback compat
 string
In-Reply-To: <cover.1512555546.git.horms+renesas@verge.net.au>
References: <cover.1512555546.git.horms+renesas@verge.net.au>
Message-ID: <1bfd944483b209c577fa50cc981b4f959a287f83.1512555546.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use newly added R-Car Gen1 Ether fallback compat string
in the DT of the r8a7778 SoC.

This should have no run-time effect as the driver matches against
the per-SoC compat string before considering the fallback compat string.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7778.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index a39472aab867..d6e3c0400ec3 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -51,7 +51,8 @@
 	};
 
 	ether: ethernet at fde00000 {
-		compatible = "renesas,ether-r8a7778";
+		compatible = "renesas,ether-r8a7778",
+			     "renesas,rcar-gen1-ether";
 		reg = <0xfde00000 0x400>;
 		interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7778_CLK_ETHER>;
-- 
2.11.0
