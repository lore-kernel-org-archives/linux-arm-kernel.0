From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 17 Oct 2017 08:09:50 +0200
Subject: [PATCH 02/11] arm64: dts: renesas: r8a7796: Use R-Car SDHI Gen3
 fallback compat string
In-Reply-To: <20171017060959.16702-1-horms+renesas@verge.net.au>
References: <20171017060959.16702-1-horms+renesas@verge.net.au>
Message-ID: <20171017060959.16702-3-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use newly added R-Car SDHI Gen3 fallback compat string
in the DT of the r8a7796 SoC.

This should have no run-time effect as the driver matches against
the per-SoC compat string before considering the fallback compat string.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index f2b2e40c655e..8c94a313d9e1 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -1380,7 +1380,8 @@
 		};
 
 		sdhi0: sd at ee100000 {
-			compatible = "renesas,sdhi-r8a7796";
+			compatible = "renesas,sdhi-r8a7796",
+				     "renesas,rcar-gen3-sdhi";
 			reg = <0 0xee100000 0 0x2000>;
 			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 314>;
@@ -1391,7 +1392,8 @@
 		};
 
 		sdhi1: sd at ee120000 {
-			compatible = "renesas,sdhi-r8a7796";
+			compatible = "renesas,sdhi-r8a7796",
+				     "renesas,rcar-gen3-sdhi";
 			reg = <0 0xee120000 0 0x2000>;
 			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 313>;
@@ -1402,7 +1404,8 @@
 		};
 
 		sdhi2: sd at ee140000 {
-			compatible = "renesas,sdhi-r8a7796";
+			compatible = "renesas,sdhi-r8a7796",
+				     "renesas,rcar-gen3-sdhi";
 			reg = <0 0xee140000 0 0x2000>;
 			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 312>;
@@ -1413,7 +1416,8 @@
 		};
 
 		sdhi3: sd at ee160000 {
-			compatible = "renesas,sdhi-r8a7796";
+			compatible = "renesas,sdhi-r8a7796",
+				     "renesas,rcar-gen3-sdhi";
 			reg = <0 0xee160000 0 0x2000>;
 			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 311>;
-- 
2.11.0
