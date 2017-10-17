From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 17 Oct 2017 08:09:51 +0200
Subject: [PATCH 03/11] ARM: dts: r8a7743: Use R-Car SDHI Gen2 fallback compat
 string
In-Reply-To: <20171017060959.16702-1-horms+renesas@verge.net.au>
References: <20171017060959.16702-1-horms+renesas@verge.net.au>
Message-ID: <20171017060959.16702-4-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use newly added R-Car SDHI Gen2 fallback compat string
in the DT of the r8a7743 SoC.

This should have no run-time effect as the driver matches against
the per-SoC compat string before considering the fallback compat string.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7743.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 4db4f61be25a..3bbcf6649d7e 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -933,7 +933,8 @@
 		};
 
 		sdhi0: sd at ee100000 {
-			compatible = "renesas,sdhi-r8a7743";
+			compatible = "renesas,sdhi-r8a7743",
+				     "renesas,rcar-gen2-sdhi";
 			reg = <0 0xee100000 0 0x328>;
 			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 314>;
@@ -947,7 +948,8 @@
 		};
 
 		sdhi1: sd at ee140000 {
-			compatible = "renesas,sdhi-r8a7743";
+			compatible = "renesas,sdhi-r8a7743",
+				     "renesas,rcar-gen2-sdhi";
 			reg = <0 0xee140000 0 0x100>;
 			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 312>;
@@ -961,7 +963,8 @@
 		};
 
 		sdhi2: sd at ee160000 {
-			compatible = "renesas,sdhi-r8a7743";
+			compatible = "renesas,sdhi-r8a7743",
+				     "renesas,rcar-gen2-sdhi";
 			reg = <0 0xee160000 0 0x100>;
 			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 311>;
-- 
2.11.0
