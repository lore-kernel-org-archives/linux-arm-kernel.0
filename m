From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  6 Jan 2017 12:18:25 +0100
Subject: [PATCH 16/25] ARM: dts: r8a7792: Use R-Car Gen 2 fallback binding for
 i2c nodes
In-Reply-To: <cover.1483700969.git.horms+renesas@verge.net.au>
References: <cover.1483700969.git.horms+renesas@verge.net.au>
Message-ID: <cfcb93b33f35879cfe06add3859fd869e3d1c9e2.1483700969.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use recently added R-Car Gen 2 fallback binding for i2c nodes in
DT for r8a7792 SoC.

This has no run-time effect for the current driver as the initialisation
sequence is the same for the SoC-specific binding for r8a7792 and the
fallback binding for R-Car Gen 2.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7792.dtsi | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/r8a7792.dtsi
index 6ced3c1ec377..59d31d433244 100644
--- a/arch/arm/boot/dts/r8a7792.dtsi
+++ b/arch/arm/boot/dts/r8a7792.dtsi
@@ -498,7 +498,8 @@
 
 		/* I2C doesn't need pinmux */
 		i2c0: i2c at e6508000 {
-			compatible = "renesas,i2c-r8a7792";
+			compatible = "renesas,i2c-r8a7792",
+				     "renesas,rcar-gen2-i2c";
 			reg = <0 0xe6508000 0 0x40>;
 			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&mstp9_clks R8A7792_CLK_I2C0>;
@@ -510,7 +511,8 @@
 		};
 
 		i2c1: i2c at e6518000 {
-			compatible = "renesas,i2c-r8a7792";
+			compatible = "renesas,i2c-r8a7792",
+				     "renesas,rcar-gen2-i2c";
 			reg = <0 0xe6518000 0 0x40>;
 			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&mstp9_clks R8A7792_CLK_I2C1>;
@@ -522,7 +524,8 @@
 		};
 
 		i2c2: i2c at e6530000 {
-			compatible = "renesas,i2c-r8a7792";
+			compatible = "renesas,i2c-r8a7792",
+				     "renesas,rcar-gen2-i2c";
 			reg = <0 0xe6530000 0 0x40>;
 			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&mstp9_clks R8A7792_CLK_I2C2>;
@@ -534,7 +537,8 @@
 		};
 
 		i2c3: i2c at e6540000 {
-			compatible = "renesas,i2c-r8a7792";
+			compatible = "renesas,i2c-r8a7792",
+				     "renesas,rcar-gen2-i2c";
 			reg = <0 0xe6540000 0 0x40>;
 			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&mstp9_clks R8A7792_CLK_I2C3>;
@@ -546,7 +550,8 @@
 		};
 
 		i2c4: i2c at e6520000 {
-			compatible = "renesas,i2c-r8a7792";
+			compatible = "renesas,i2c-r8a7792",
+				     "renesas,rcar-gen2-i2c";
 			reg = <0 0xe6520000 0 0x40>;
 			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&mstp9_clks R8A7792_CLK_I2C4>;
@@ -558,7 +563,8 @@
 		};
 
 		i2c5: i2c at e6528000 {
-			compatible = "renesas,i2c-r8a7792";
+			compatible = "renesas,i2c-r8a7792",
+				     "renesas,rcar-gen2-i2c";
 			reg = <0 0xe6528000 0 0x40>;
 			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&mstp9_clks R8A7792_CLK_I2C5>;
-- 
2.7.0.rc3.207.g0ac5344
