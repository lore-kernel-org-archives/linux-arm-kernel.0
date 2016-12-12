From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 12 Dec 2016 10:11:42 +0100
Subject: [PATCH renesas/devel 13/13] ARM: dts: r8a7794: Use R-Car Gen 2
 fallback binding for i2c nodes
In-Reply-To: <1481533902-14789-1-git-send-email-horms+renesas@verge.net.au>
References: <1481533902-14789-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1481533902-14789-14-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use recently added R-Car Gen 2 fallback binding for iii nodes in
DT for r8a7794 SoC.

This has no run-time effect for the current driver as the initialisation
sequence is the same for the SoC-specific binding for r8a7794 and the
fallback binding for R-Car Gen 2.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 5fd382a5a7b2..e41f1c9b4a9c 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -683,7 +683,8 @@
 	};
 
 	i2c6: i2c at e6500000 {
-		compatible = "renesas,iic-r8a7794", "renesas,rmobile-iic";
+		compatible = "renesas,iic-r8a7794", "renesas,rcar-gen2-iic",
+			     "renesas,rmobile-iic";
 		reg = <0 0xe6500000 0 0x425>;
 		interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7794_CLK_IIC0>;
@@ -697,7 +698,8 @@
 	};
 
 	i2c7: i2c at e6510000 {
-		compatible = "renesas,iic-r8a7794", "renesas,rmobile-iic";
+		compatible = "renesas,iic-r8a7794", "renesas,rcar-gen2-iic",
+			     "renesas,rmobile-iic";
 		reg = <0 0xe6510000 0 0x425>;
 		interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7794_CLK_IIC1>;
-- 
2.7.0.rc3.207.g0ac5344
