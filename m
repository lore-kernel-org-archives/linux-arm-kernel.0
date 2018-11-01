From: lothar.felten@gmail.com (Lothar Felten)
Date: Thu,  1 Nov 2018 09:57:10 +0100
Subject: [PATCH v3] ARM: dtsi: sun8i-r40: add mali node
Message-ID: <20181101085710.15774-1-lothar.felten@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a node for the mali 400 GPU of the R40/V40 SoC

Signed-off-by: Lothar Felten <lothar.felten@gmail.com>
---
Changes v2->v3:
- remove mali clock rates
- drop hdmi-phy sun50i-a64 compatibility  
- patch version, change log added

Changes v1->v2:
- commit message uppercase ARM prefix
- wrong patch submitted by mistake
---

 arch/arm/boot/dts/sun8i-r40.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 6f4c9ca5a3ee..136c248cc7d1 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -542,6 +542,28 @@
 
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
+		};
+
 		gmac: ethernet at 1c50000 {
 			compatible = "allwinner,sun8i-r40-gmac";
 			syscon = <&ccu>;
-- 
2.11.0
