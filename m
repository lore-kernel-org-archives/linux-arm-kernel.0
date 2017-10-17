From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 17 Oct 2017 08:09:53 +0200
Subject: [PATCH 05/11] ARM: dts: r8a7778: Use R-Car SDHI Gen1 fallback compat
 string
In-Reply-To: <20171017060959.16702-1-horms+renesas@verge.net.au>
References: <20171017060959.16702-1-horms+renesas@verge.net.au>
Message-ID: <20171017060959.16702-6-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use newly added R-Car SDHI Gen1 fallback compat string
in the DT of the r8a7778 SoC.

This should have no run-time effect as the driver matches against
the per-SoC compat string before considering the fallback compat string.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index a39472aab867..9fe1c3d6e3d6 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -379,7 +379,8 @@
 	};
 
 	sdhi0: sd at ffe4c000 {
-		compatible = "renesas,sdhi-r8a7778";
+		compatible = "renesas,sdhi-r8a7778",
+			     "renesas,rcar-gen1-sdhi";
 		reg = <0xffe4c000 0x100>;
 		interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7778_CLK_SDHI0>;
@@ -388,7 +389,8 @@
 	};
 
 	sdhi1: sd at ffe4d000 {
-		compatible = "renesas,sdhi-r8a7778";
+		compatible = "renesas,sdhi-r8a7778",
+			     "renesas,rcar-gen1-sdhi";
 		reg = <0xffe4d000 0x100>;
 		interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7778_CLK_SDHI1>;
@@ -397,7 +399,8 @@
 	};
 
 	sdhi2: sd at ffe4f000 {
-		compatible = "renesas,sdhi-r8a7778";
+		compatible = "renesas,sdhi-r8a7778",
+			     "renesas,rcar-gen1-sdhi";
 		reg = <0xffe4f000 0x100>;
 		interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7778_CLK_SDHI2>;
-- 
2.11.0
