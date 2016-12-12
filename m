From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 12 Dec 2016 10:11:32 +0100
Subject: [PATCH renesas/devel 03/13] ARM: dts: r8a7790: Use R-Car Gen 2
 fallback binding for i2c nodes
In-Reply-To: <1481533902-14789-1-git-send-email-horms+renesas@verge.net.au>
References: <1481533902-14789-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1481533902-14789-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use recently added R-Car Gen 2 fallback binding for i2c nodes in
DT for r8a7790 SoC.

This has no run-time effect for the current driver as the initialisation
sequence is the same for the SoC-specific binding for r8a7790 and the
fallback binding for R-Car Gen 2.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index b7ed7466308b..823ab536175d 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -480,7 +480,7 @@
 	i2c0: i2c at e6508000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7790";
+		compatible = "renesas,i2c-r8a7790", "renesas,rcar-gen2-i2c";
 		reg = <0 0xe6508000 0 0x40>;
 		interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7790_CLK_I2C0>;
@@ -492,7 +492,7 @@
 	i2c1: i2c at e6518000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7790";
+		compatible = "renesas,i2c-r8a7790", "renesas,rcar-gen2-i2c";
 		reg = <0 0xe6518000 0 0x40>;
 		interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7790_CLK_I2C1>;
@@ -504,7 +504,7 @@
 	i2c2: i2c at e6530000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7790";
+		compatible = "renesas,i2c-r8a7790", "renesas,rcar-gen2-i2c";
 		reg = <0 0xe6530000 0 0x40>;
 		interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7790_CLK_I2C2>;
@@ -516,7 +516,7 @@
 	i2c3: i2c at e6540000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7790";
+		compatible = "renesas,i2c-r8a7790", "renesas,rcar-gen2-i2c";
 		reg = <0 0xe6540000 0 0x40>;
 		interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7790_CLK_I2C3>;
-- 
2.7.0.rc3.207.g0ac5344
