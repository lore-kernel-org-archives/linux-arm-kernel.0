From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 17 Oct 2017 08:09:55 +0200
Subject: [PATCH 07/11] ARM: dts: r8a7790: Use R-Car SDHI Gen2 fallback compat
 string
In-Reply-To: <20171017060959.16702-1-horms+renesas@verge.net.au>
References: <20171017060959.16702-1-horms+renesas@verge.net.au>
Message-ID: <20171017060959.16702-8-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use newly added R-Car SDHI Gen2 fallback compat string
in the DT of the r8a7790 SoC.

This should have no run-time effect as the driver matches against
the per-SoC compat string before considering the fallback compat string.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 2f017fee4009..ef4e144a01a1 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -662,7 +662,8 @@
 	};
 
 	sdhi0: sd at ee100000 {
-		compatible = "renesas,sdhi-r8a7790";
+		compatible = "renesas,sdhi-r8a7790",
+			     "renesas,rcar-gen2-sdhi";
 		reg = <0 0xee100000 0 0x328>;
 		interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 314>;
@@ -676,7 +677,8 @@
 	};
 
 	sdhi1: sd at ee120000 {
-		compatible = "renesas,sdhi-r8a7790";
+		compatible = "renesas,sdhi-r8a7790",
+			     "renesas,rcar-gen2-sdhi";
 		reg = <0 0xee120000 0 0x328>;
 		interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 313>;
@@ -690,7 +692,8 @@
 	};
 
 	sdhi2: sd at ee140000 {
-		compatible = "renesas,sdhi-r8a7790";
+		compatible = "renesas,sdhi-r8a7790",
+			     "renesas,rcar-gen2-sdhi";
 		reg = <0 0xee140000 0 0x100>;
 		interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 312>;
@@ -704,7 +707,8 @@
 	};
 
 	sdhi3: sd at ee160000 {
-		compatible = "renesas,sdhi-r8a7790";
+		compatible = "renesas,sdhi-r8a7790",
+			     "renesas,rcar-gen2-sdhi";
 		reg = <0 0xee160000 0 0x100>;
 		interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 311>;
-- 
2.11.0
