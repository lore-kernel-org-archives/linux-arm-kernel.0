From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  6 Dec 2017 11:22:16 +0100
Subject: [PATCH 21/61] ARM: dts: r8a7778: Use R-Car SDHI Gen1 fallback compat
 string
In-Reply-To: <cover.1512555546.git.horms+renesas@verge.net.au>
References: <cover.1512555546.git.horms+renesas@verge.net.au>
Message-ID: <bce90b30fc0b65fb4a7c89135a563f5cffdf64cd.1512555546.git.horms+renesas@verge.net.au>
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
index d6e3c0400ec3..3b49f9ed2e2b 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -380,7 +380,8 @@
 	};
 
 	sdhi0: sd at ffe4c000 {
-		compatible = "renesas,sdhi-r8a7778";
+		compatible = "renesas,sdhi-r8a7778",
+			     "renesas,rcar-gen1-sdhi";
 		reg = <0xffe4c000 0x100>;
 		interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7778_CLK_SDHI0>;
@@ -389,7 +390,8 @@
 	};
 
 	sdhi1: sd at ffe4d000 {
-		compatible = "renesas,sdhi-r8a7778";
+		compatible = "renesas,sdhi-r8a7778",
+			     "renesas,rcar-gen1-sdhi";
 		reg = <0xffe4d000 0x100>;
 		interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7778_CLK_SDHI1>;
@@ -398,7 +400,8 @@
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
