From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  6 Dec 2017 11:22:19 +0100
Subject: [PATCH 24/61] ARM: dts: r8a7791: Use R-Car SDHI Gen2 fallback compat
 string
In-Reply-To: <cover.1512555546.git.horms+renesas@verge.net.au>
References: <cover.1512555546.git.horms+renesas@verge.net.au>
Message-ID: <8423f640cfff6a32f95983e4e60795f77369dca2.1512555546.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use newly added R-Car SDHI Gen2 fallback compat string
in the DT of the r8a7791 SoC.

This should have no run-time effect as the driver matches against
the per-SoC compat string before considering the fallback compat string.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 9815a933e4cc..e888b5b0e135 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -612,7 +612,8 @@
 	};
 
 	sdhi0: sd at ee100000 {
-		compatible = "renesas,sdhi-r8a7791";
+		compatible = "renesas,sdhi-r8a7791",
+			     "renesas,rcar-gen2-sdhi";
 		reg = <0 0xee100000 0 0x328>;
 		interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 314>;
@@ -626,7 +627,8 @@
 	};
 
 	sdhi1: sd at ee140000 {
-		compatible = "renesas,sdhi-r8a7791";
+		compatible = "renesas,sdhi-r8a7791",
+			     "renesas,rcar-gen2-sdhi";
 		reg = <0 0xee140000 0 0x100>;
 		interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 312>;
@@ -640,7 +642,8 @@
 	};
 
 	sdhi2: sd at ee160000 {
-		compatible = "renesas,sdhi-r8a7791";
+		compatible = "renesas,sdhi-r8a7791",
+			     "renesas,rcar-gen2-sdhi";
 		reg = <0 0xee160000 0 0x100>;
 		interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 311>;
-- 
2.11.0
