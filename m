From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 20 Dec 2016 11:32:37 +0100
Subject: [PATCH renesas/devel 2/4] ARM: dts: r8a7791: Use R-Car Gen 2 fallback
 binding for msiof nodes
In-Reply-To: <1482229959-25584-1-git-send-email-horms+renesas@verge.net.au>
References: <1482229959-25584-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1482229959-25584-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use recently added R-Car Gen 2 fallback binding for msiof nodes in
DT for r8a7791 SoC.

This has no run-time effect for the current driver as the initialisation
sequence is the same for the SoC-specific binding for r8a7791 and the
fallback binding for R-Car Gen 2.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 93f446db6a21..ba5748dc5171 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1518,7 +1518,8 @@
 	};
 
 	msiof0: spi at e6e20000 {
-		compatible = "renesas,msiof-r8a7791";
+		compatible = "renesas,msiof-r8a7791",
+			     "renesas,rcar-gen2-msiof";
 		reg = <0 0xe6e20000 0 0x0064>;
 		interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7791_CLK_MSIOF0>;
@@ -1532,7 +1533,8 @@
 	};
 
 	msiof1: spi at e6e10000 {
-		compatible = "renesas,msiof-r8a7791";
+		compatible = "renesas,msiof-r8a7791",
+			     "renesas,rcar-gen2-msiof";
 		reg = <0 0xe6e10000 0 0x0064>;
 		interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_MSIOF1>;
@@ -1546,7 +1548,8 @@
 	};
 
 	msiof2: spi at e6e00000 {
-		compatible = "renesas,msiof-r8a7791";
+		compatible = "renesas,msiof-r8a7791",
+			     "renesas,rcar-gen2-msiof";
 		reg = <0 0xe6e00000 0 0x0064>;
 		interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_MSIOF2>;
-- 
2.7.0.rc3.207.g0ac5344
