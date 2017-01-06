From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  6 Jan 2017 12:18:24 +0100
Subject: [PATCH 15/25] ARM: dts: r8a7791: Use R-Car Gen 2 fallback binding for
 i2c nodes
In-Reply-To: <cover.1483700969.git.horms+renesas@verge.net.au>
References: <cover.1483700969.git.horms+renesas@verge.net.au>
Message-ID: <c7407ca7ef61ff91cfa3c130de59061171102cf3.1483700969.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use recently added R-Car Gen 2 fallback binding for i2c nodes in
DT for r8a7791 SoC.

This has no run-time effect for the current driver as the initialisation
sequence is the same for the SoC-specific binding for r8a7791 and the
fallback binding for R-Car Gen 2.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index a5c596a15120..b61700aa862e 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -444,7 +444,7 @@
 	i2c0: i2c at e6508000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7791";
+		compatible = "renesas,i2c-r8a7791", "renesas,rcar-gen2-i2c";
 		reg = <0 0xe6508000 0 0x40>;
 		interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C0>;
@@ -456,7 +456,7 @@
 	i2c1: i2c at e6518000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7791";
+		compatible = "renesas,i2c-r8a7791", "renesas,rcar-gen2-i2c";
 		reg = <0 0xe6518000 0 0x40>;
 		interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C1>;
@@ -468,7 +468,7 @@
 	i2c2: i2c at e6530000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7791";
+		compatible = "renesas,i2c-r8a7791", "renesas,rcar-gen2-i2c";
 		reg = <0 0xe6530000 0 0x40>;
 		interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C2>;
@@ -480,7 +480,7 @@
 	i2c3: i2c at e6540000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7791";
+		compatible = "renesas,i2c-r8a7791", "renesas,rcar-gen2-i2c";
 		reg = <0 0xe6540000 0 0x40>;
 		interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C3>;
@@ -492,7 +492,7 @@
 	i2c4: i2c at e6520000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7791";
+		compatible = "renesas,i2c-r8a7791", "renesas,rcar-gen2-i2c";
 		reg = <0 0xe6520000 0 0x40>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C4>;
@@ -505,7 +505,7 @@
 		/* doesn't need pinmux */
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7791";
+		compatible = "renesas,i2c-r8a7791", "renesas,rcar-gen2-i2c";
 		reg = <0 0xe6528000 0 0x40>;
 		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C5>;
-- 
2.7.0.rc3.207.g0ac5344
