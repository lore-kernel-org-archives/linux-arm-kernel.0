From: lothar.felten@gmail.com (Lothar Felten)
Date: Thu,  1 Nov 2018 08:38:33 +0100
Subject: [PATCH] ARM: dtsi: sun8i-r40: add mali node
Message-ID: <20181101073833.2936-1-lothar.felten@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a node for the mali 400 GPU of the R40/V40 SoC

Signed-off-by: Lothar Felten <lothar.felten@gmail.com>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 6f4c9ca5a3ee..ddf765e931f3 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -542,6 +542,31 @@
 
 		};
 
+		mali: gpu at 1c40000 {
+			compatible = "allwinner,sun7i-a20-mali", "arm,mali-400";
+			reg = <0x01c40000 0x10000>;
+			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "gp",
+					  "gpmmu",
+					  "pp0",
+					  "ppmmu0",
+					  "pp1",
+					  "ppmmu1",
+					  "pmu";
+			clocks = <&ccu CLK_BUS_GPU>, <&ccu CLK_GPU>;
+			clock-names = "bus", "core";
+			resets = <&ccu RST_BUS_GPU>;
+
+			assigned-clocks = <&ccu CLK_GPU>;
+			assigned-clock-rates = <384000000>;
+		};
+
 		gmac: ethernet at 1c50000 {
 			compatible = "allwinner,sun8i-r40-gmac";
 			syscon = <&ccu>;
@@ -813,7 +838,8 @@
 		};
 
 		hdmi_phy: hdmi-phy at 1ef0000 {
-			compatible = "allwinner,sun8i-r40-hdmi-phy";
+			compatible = "allwinner,sun8i-r40-hdmi-phy",
+				     "allwinner,sun50i-a64-hdmi-phy";
 			reg = <0x01ef0000 0x10000>;
 			clocks = <&ccu CLK_BUS_HDMI1>, <&ccu CLK_HDMI_SLOW>,
 				 <&ccu 7>, <&ccu 16>;
-- 
2.11.0
