From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 13 Dec 2016 12:45:56 +0100
Subject: [PATCH v2 renesas/devel 10/13] ARM: dts: r8a7790: Use R-Car Gen 2
 fallback binding for iic nodes
In-Reply-To: <1481629559-14187-1-git-send-email-horms+renesas@verge.net.au>
References: <1481629559-14187-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1481629559-14187-11-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use recently added R-Car Gen 2 fallback binding for iic nodes in
DT for r8a7790 SoC.

This has no run-time effect for the current driver as the initialisation
sequence is the same for the SoC-specific binding for r8a7790 and the
fallback binding for R-Car Gen 2.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7790.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 823ab536175d..ddf6a8cbe6c1 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -528,7 +528,8 @@
 	iic0: i2c at e6500000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,iic-r8a7790", "renesas,rmobile-iic";
+		compatible = "renesas,iic-r8a7790", "renesas,rcar-gen2-iic",
+			     "renesas,rmobile-iic";
 		reg = <0 0xe6500000 0 0x425>;
 		interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_IIC0>;
@@ -542,7 +543,8 @@
 	iic1: i2c at e6510000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,iic-r8a7790", "renesas,rmobile-iic";
+		compatible = "renesas,iic-r8a7790", "renesas,rcar-gen2-iic",
+			     "renesas,rmobile-iic";
 		reg = <0 0xe6510000 0 0x425>;
 		interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_IIC1>;
@@ -556,7 +558,8 @@
 	iic2: i2c at e6520000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,iic-r8a7790", "renesas,rmobile-iic";
+		compatible = "renesas,iic-r8a7790", "renesas,rcar-gen2-iic",
+			     "renesas,rmobile-iic";
 		reg = <0 0xe6520000 0 0x425>;
 		interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_IIC2>;
@@ -570,7 +573,8 @@
 	iic3: i2c at e60b0000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,iic-r8a7790", "renesas,rmobile-iic";
+		compatible = "renesas,iic-r8a7790", "renesas,rcar-gen2-iic",
+			     "renesas,rmobile-iic";
 		reg = <0 0xe60b0000 0 0x425>;
 		interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7790_CLK_IICDVFS>;
-- 
2.7.0.rc3.207.g0ac5344
