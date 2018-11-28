From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 28 Nov 2018 14:03:06 +0100
Subject: [PATCH 04/16] ARM: dts: r8a77470: Add SDHI1 support
In-Reply-To: <cover.1543409901.git.horms+renesas@verge.net.au>
References: <cover.1543409901.git.horms+renesas@verge.net.au>
Message-ID: <0485da788028ecd525291974c8efe2d072607476.1543409901.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Althought interface SDHI1 found on the RZ/G1C SoC (a.k.a.
r8a77470) is compatible with the R-Car Gen3 ones, its OF
compatibility is restricted to the SoC specific compatible
string to avoid confusion, as from a more generic perspective
the RZ/G1C is sharing the most similarities with the R-Car
Gen2 family of SoCs, and there is a combination of R-Car
Gen2 compatible SDHI IPs and R-Car Gen3 compatible SDHI IP
on this specific chip.
This patch adds the SoC specific part of SDHI1 support, and
since SDHI1 comes with internal DMA, its DT node looks fairly
different from SDHI0 and SDHI2.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a77470.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/r8a77470.dtsi b/arch/arm/boot/dts/r8a77470.dtsi
index ab2e0223f8a1..6ac7f467065e 100644
--- a/arch/arm/boot/dts/r8a77470.dtsi
+++ b/arch/arm/boot/dts/r8a77470.dtsi
@@ -505,6 +505,17 @@
 			status = "disabled";
 		};
 
+		sdhi1: sd at ee300000 {
+			compatible = "renesas,sdhi-mmc-r8a77470";
+			reg = <0 0xee300000 0 0x2000>;
+			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 313>;
+			max-frequency = <156000000>;
+			power-domains = <&sysc R8A77470_PD_ALWAYS_ON>;
+			resets = <&cpg 313>;
+			status = "disabled";
+		};
+
 		sdhi2: sd at ee160000 {
 			compatible = "renesas,sdhi-r8a77470",
 				     "renesas,rcar-gen2-sdhi";
-- 
2.11.0
