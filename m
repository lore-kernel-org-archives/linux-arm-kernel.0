From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  6 Dec 2017 11:21:59 +0100
Subject: [PATCH 04/61] ARM: dts: r8a7790: Use R-Car Gen2 Ether fallback compat
 string
In-Reply-To: <cover.1512555546.git.horms+renesas@verge.net.au>
References: <cover.1512555546.git.horms+renesas@verge.net.au>
Message-ID: <adf65f3f575a06b4180b4b9ab8485603303e7596.1512555546.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use newly added R-Car Gen2 Ether fallback compat string
in the DT of the r8a7790 SoC.

This should have no run-time effect as the driver matches against
the per-SoC compat string before considering the fallback compat string.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7790.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 2f017fee4009..4fc607e8e40c 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -906,7 +906,8 @@
 	};
 
 	ether: ethernet at ee700000 {
-		compatible = "renesas,ether-r8a7790";
+		compatible = "renesas,ether-r8a7790",
+			     "renesas,rcar-gen2-ether";
 		reg = <0 0xee700000 0 0x400>;
 		interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 813>;
-- 
2.11.0
