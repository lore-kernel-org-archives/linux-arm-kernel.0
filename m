From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:19:38 +0200
Subject: [PATCH 26/38] ARM: dts: r8a7791: Use R-Car Gen 2 fallback binding for
 vin nodes
In-Reply-To: <cover.1501514100.git.horms+renesas@verge.net.au>
References: <cover.1501514100.git.horms+renesas@verge.net.au>
Message-ID: <b5595f2ffec64cce76fd1c6e4bfeb7a0109517a7.1501514100.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use R-Car Gen 2 fallback binding for vind nodes in DT for r8a7791 SoC.

This has no run-time effect for the current driver as the initialisation
sequence is the same for the SoC-specific binding for r8a7791 and the
fallback binding for R-Car Gen 2

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index e135da440eed..ea4a8147d995 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -987,7 +987,7 @@
 	};
 
 	vin0: video at e6ef0000 {
-		compatible = "renesas,vin-r8a7791";
+		compatible = "renesas,vin-r8a7791", "renesas,rcar-gen2-vin";
 		reg = <0 0xe6ef0000 0 0x1000>;
 		interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7791_CLK_VIN0>;
@@ -996,7 +996,7 @@
 	};
 
 	vin1: video at e6ef1000 {
-		compatible = "renesas,vin-r8a7791";
+		compatible = "renesas,vin-r8a7791", "renesas,rcar-gen2-vin";
 		reg = <0 0xe6ef1000 0 0x1000>;
 		interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7791_CLK_VIN1>;
@@ -1005,7 +1005,7 @@
 	};
 
 	vin2: video at e6ef2000 {
-		compatible = "renesas,vin-r8a7791";
+		compatible = "renesas,vin-r8a7791", "renesas,rcar-gen2-vin";
 		reg = <0 0xe6ef2000 0 0x1000>;
 		interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7791_CLK_VIN2>;
-- 
2.1.4
