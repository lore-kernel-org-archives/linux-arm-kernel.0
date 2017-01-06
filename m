From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  6 Jan 2017 12:18:33 +0100
Subject: [PATCH 24/25] ARM: dts: r8a7792: Use R-Car Gen 2 fallback binding for
 msiof nodes
In-Reply-To: <cover.1483700969.git.horms+renesas@verge.net.au>
References: <cover.1483700969.git.horms+renesas@verge.net.au>
Message-ID: <50a15093c6f1bf5f89b9954075b27b52c0322beb.1483700969.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use recently added R-Car Gen 2 fallback binding for msiof nodes in
DT for r8a7792 SoC.

This has no run-time effect for the current driver as the initialisation
sequence is the same for the SoC-specific binding for r8a7792 and the
fallback binding for R-Car Gen 2.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7792.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/r8a7792.dtsi
index 59d31d433244..135e06920e2d 100644
--- a/arch/arm/boot/dts/r8a7792.dtsi
+++ b/arch/arm/boot/dts/r8a7792.dtsi
@@ -591,7 +591,8 @@
 		};
 
 		msiof0: spi at e6e20000 {
-			compatible = "renesas,msiof-r8a7792";
+			compatible = "renesas,msiof-r8a7792",
+				     "renesas,rcar-gen2-msiof";
 			reg = <0 0xe6e20000 0 0x0064>;
 			interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&mstp0_clks R8A7792_CLK_MSIOF0>;
@@ -605,7 +606,8 @@
 		};
 
 		msiof1: spi at e6e10000 {
-			compatible = "renesas,msiof-r8a7792";
+			compatible = "renesas,msiof-r8a7792",
+				     "renesas,rcar-gen2-msiof";
 			reg = <0 0xe6e10000 0 0x0064>;
 			interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&mstp2_clks R8A7792_CLK_MSIOF1>;
-- 
2.7.0.rc3.207.g0ac5344
