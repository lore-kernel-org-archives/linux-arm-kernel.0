From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 17 Oct 2017 08:09:52 +0200
Subject: [PATCH 04/11] ARM: dts: r8a7745: Use R-Car SDHI Gen2 fallback compat
 string
In-Reply-To: <20171017060959.16702-1-horms+renesas@verge.net.au>
References: <20171017060959.16702-1-horms+renesas@verge.net.au>
Message-ID: <20171017060959.16702-5-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use newly added R-Car SDHI Gen2 fallback compat string
in the DT of the r8a7745 SoC.

This should have no run-time effect as the driver matches against
the per-SoC compat string before considering the fallback compat string.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7745.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index 3a50f703601c..8df056f07aee 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -805,7 +805,8 @@
 		};
 
 		sdhi0: sd at ee100000 {
-			compatible = "renesas,sdhi-r8a7745";
+			compatible = "renesas,sdhi-r8a7745",
+				     "renesas,rcar-gen2-sdhi";
 			reg = <0 0xee100000 0 0x328>;
 			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 314>;
@@ -819,7 +820,8 @@
 		};
 
 		sdhi1: sd at ee140000 {
-			compatible = "renesas,sdhi-r8a7745";
+			compatible = "renesas,sdhi-r8a7745",
+				     "renesas,rcar-gen2-sdhi";
 			reg = <0 0xee140000 0 0x100>;
 			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 312>;
@@ -833,7 +835,8 @@
 		};
 
 		sdhi2: sd at ee160000 {
-			compatible = "renesas,sdhi-r8a7745";
+			compatible = "renesas,sdhi-r8a7745",
+				     "renesas,rcar-gen2-sdhi";
 			reg = <0 0xee160000 0 0x100>;
 			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 311>;
-- 
2.11.0
