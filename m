From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Aug 2017 10:19:53 +0200
Subject: [PATCH 8/9] ARM: dts: r8a7790: Use R-Car SATA Gen2 fallback compat
 string
In-Reply-To: <cover.1502962873.git.horms+renesas@verge.net.au>
References: <cover.1502962873.git.horms+renesas@verge.net.au>
Message-ID: <faa63e832c427b7ba107291e9f07fa2f570c0835.1502962873.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use newly added R-Car SATA Gen2 fallback compat string
in the DT of the r8a7790 SoC.

This should have no run-time effect as the driver matches against
the per-SoC compat string before the fallback compat string is considered.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7790.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 167fd57aea68..16358bf8d1db 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -873,7 +873,7 @@
 	};
 
 	sata0: sata at ee300000 {
-		compatible = "renesas,sata-r8a7790";
+		compatible = "renesas,sata-r8a7790", "renesas,rcar-gen2-sata";
 		reg = <0 0xee300000 0 0x2000>;
 		interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7790_CLK_SATA0>;
@@ -882,7 +882,7 @@
 	};
 
 	sata1: sata at ee500000 {
-		compatible = "renesas,sata-r8a7790";
+		compatible = "renesas,sata-r8a7790", "renesas,rcar-gen2-sata";
 		reg = <0 0xee500000 0 0x2000>;
 		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7790_CLK_SATA1>;
-- 
2.1.4
