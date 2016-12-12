From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 12 Dec 2016 10:11:31 +0100
Subject: [PATCH renesas/devel 02/13] ARM: dts: r8a7778: Use R-Car Gen 1
 fallback binding for i2c nodes
In-Reply-To: <1481533902-14789-1-git-send-email-horms+renesas@verge.net.au>
References: <1481533902-14789-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1481533902-14789-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use recently added R-Car Gen 1 fallback binding for i2c nodes in
DT for r8a7778 SoC.

This has no run-time effect for the current driver as the initialisation
sequence is the same for the SoC-specific binding for r8a7778 and the
fallback binding for R-Car Gen 1.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index b0c9674fad17..1e93c94a9eac 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -150,7 +150,7 @@
 	i2c0: i2c at ffc70000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7778";
+		compatible = "renesas,i2c-r8a7778", "renesas,rcar-gen1-i2c";
 		reg = <0xffc70000 0x1000>;
 		interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_I2C0>;
@@ -161,7 +161,7 @@
 	i2c1: i2c at ffc71000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7778";
+		compatible = "renesas,i2c-r8a7778", "renesas,rcar-gen1-i2c";
 		reg = <0xffc71000 0x1000>;
 		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_I2C1>;
@@ -172,7 +172,7 @@
 	i2c2: i2c at ffc72000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7778";
+		compatible = "renesas,i2c-r8a7778", "renesas,rcar-gen1-i2c";
 		reg = <0xffc72000 0x1000>;
 		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_I2C2>;
@@ -183,7 +183,7 @@
 	i2c3: i2c at ffc73000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7778";
+		compatible = "renesas,i2c-r8a7778", "renesas,rcar-gen1-i2c";
 		reg = <0xffc73000 0x1000>;
 		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_I2C3>;
-- 
2.7.0.rc3.207.g0ac5344
