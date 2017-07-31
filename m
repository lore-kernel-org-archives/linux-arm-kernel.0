From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:19:39 +0200
Subject: [PATCH 27/38] ARM: dts: r8a7794: Use R-Car Gen 2 fallback binding for
 vin nodes
In-Reply-To: <cover.1501514100.git.horms+renesas@verge.net.au>
References: <cover.1501514100.git.horms+renesas@verge.net.au>
Message-ID: <a3fbb1dc134f65352ca9188bb23acb233d0b9d89.1501514100.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use R-Car Gen 2 fallback binding for vind nodes in DT for r8a7794 SoC.

This has no run-time effect for the current driver as the initialisation
sequence is the same for the SoC-specific binding for r8a7794 and the
fallback binding for R-Car Gen 2

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7794.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index f32b458e9328..26535414203a 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -801,7 +801,7 @@
 	};
 
 	vin0: video at e6ef0000 {
-		compatible = "renesas,vin-r8a7794";
+		compatible = "renesas,vin-r8a7794", "renesas,rcar-gen2-vin";
 		reg = <0 0xe6ef0000 0 0x1000>;
 		interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7794_CLK_VIN0>;
@@ -810,7 +810,7 @@
 	};
 
 	vin1: video at e6ef1000 {
-		compatible = "renesas,vin-r8a7794";
+		compatible = "renesas,vin-r8a7794", "renesas,rcar-gen2-vin";
 		reg = <0 0xe6ef1000 0 0x1000>;
 		interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7794_CLK_VIN1>;
-- 
2.1.4
