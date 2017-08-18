From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Aug 2017 10:19:54 +0200
Subject: [PATCH 9/9] ARM: dts: r8a7791: Use R-Car SATA Gen2 fallback compat
 string
In-Reply-To: <cover.1502962873.git.horms+renesas@verge.net.au>
References: <cover.1502962873.git.horms+renesas@verge.net.au>
Message-ID: <a4bc74d570a79dbfeb64766b130c0113ac39ec3e.1502962873.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use newly added R-Car SATA Gen2 fallback compat string
in the DT of the r8a7791 SoC.

This should have no run-time effect as the driver matches against
the per-SoC compat string before the fallback compat string is considered.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index ea4a8147d995..f1d1a9772153 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -933,7 +933,7 @@
 	};
 
 	sata0: sata at ee300000 {
-		compatible = "renesas,sata-r8a7791";
+		compatible = "renesas,sata-r8a7791", "renesas,rcar-gen2-sata";
 		reg = <0 0xee300000 0 0x2000>;
 		interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7791_CLK_SATA0>;
@@ -942,7 +942,7 @@
 	};
 
 	sata1: sata at ee500000 {
-		compatible = "renesas,sata-r8a7791";
+		compatible = "renesas,sata-r8a7791", "renesas,rcar-gen2-sata";
 		reg = <0 0xee500000 0 0x2000>;
 		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7791_CLK_SATA1>;
-- 
2.1.4
