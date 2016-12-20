From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 20 Dec 2016 11:32:39 +0100
Subject: [PATCH renesas/devel 4/4] ARM: dts: r8a7790: Use R-Car Gen 2 fallback
 binding for msiof nodes
In-Reply-To: <1482229959-25584-1-git-send-email-horms+renesas@verge.net.au>
References: <1482229959-25584-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1482229959-25584-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use recently added R-Car Gen 2 fallback binding for msiof nodes in
DT for r8a7790 SoC.

This has no run-time effect for the current driver as the initialisation
sequence is the same for the SoC-specific binding for r8a7790 and the
fallback binding for R-Car Gen 2.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index b7ed7466308b..63648f1a2e19 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1504,7 +1504,8 @@
 	};
 
 	msiof0: spi at e6e20000 {
-		compatible = "renesas,msiof-r8a7790";
+		compatible = "renesas,msiof-r8a7790",
+			     "renesas,rcar-gen2-msiof";
 		reg = <0 0xe6e20000 0 0x0064>;
 		interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7790_CLK_MSIOF0>;
@@ -1518,7 +1519,8 @@
 	};
 
 	msiof1: spi at e6e10000 {
-		compatible = "renesas,msiof-r8a7790";
+		compatible = "renesas,msiof-r8a7790",
+			     "renesas,rcar-gen2-msiof";
 		reg = <0 0xe6e10000 0 0x0064>;
 		interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_MSIOF1>;
@@ -1532,7 +1534,8 @@
 	};
 
 	msiof2: spi at e6e00000 {
-		compatible = "renesas,msiof-r8a7790";
+		compatible = "renesas,msiof-r8a7790",
+			     "renesas,rcar-gen2-msiof";
 		reg = <0 0xe6e00000 0 0x0064>;
 		interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_MSIOF2>;
@@ -1546,7 +1549,8 @@
 	};
 
 	msiof3: spi at e6c90000 {
-		compatible = "renesas,msiof-r8a7790";
+		compatible = "renesas,msiof-r8a7790",
+			     "renesas,rcar-gen2-msiof";
 		reg = <0 0xe6c90000 0 0x0064>;
 		interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_MSIOF3>;
-- 
2.7.0.rc3.207.g0ac5344
