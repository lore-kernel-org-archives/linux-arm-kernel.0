From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 12 Dec 2016 10:11:40 +0100
Subject: [PATCH renesas/devel 11/13] ARM: dts: r8a7791: Use R-Car Gen 2
 fallback binding for i2c nodes
In-Reply-To: <1481533902-14789-1-git-send-email-horms+renesas@verge.net.au>
References: <1481533902-14789-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1481533902-14789-12-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use recently added R-Car Gen 2 fallback binding for iii nodes in
DT for r8a7791 SoC.

This has no run-time effect for the current driver as the initialisation
sequence is the same for the SoC-specific binding for r8a7791 and the
fallback binding for R-Car Gen 2.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 48662c13f79a..01599fe90fc0 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -518,7 +518,8 @@
 		/* doesn't need pinmux */
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,iic-r8a7791", "renesas,rmobile-iic";
+		compatible = "renesas,iic-r8a7791", "renesas,rcar-gen2-iic",
+			     "renesas,rmobile-iic";
 		reg = <0 0xe60b0000 0 0x425>;
 		interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_IICDVFS>;
@@ -532,7 +533,8 @@
 	i2c7: i2c at e6500000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,iic-r8a7791", "renesas,rmobile-iic";
+		compatible = "renesas,iic-r8a7791", "renesas,rcar-gen2-iic",
+			     "renesas,rmobile-iic";
 		reg = <0 0xe6500000 0 0x425>;
 		interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_IIC0>;
@@ -546,7 +548,8 @@
 	i2c8: i2c at e6510000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,iic-r8a7791", "renesas,rmobile-iic";
+		compatible = "renesas,iic-r8a7791", "renesas,rcar-gen2-iic",
+			     "renesas,rmobile-iic";
 		reg = <0 0xe6510000 0 0x425>;
 		interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_IIC1>;
-- 
2.7.0.rc3.207.g0ac5344
