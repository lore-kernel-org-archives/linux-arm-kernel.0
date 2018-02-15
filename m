From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Thu, 15 Feb 2018 14:46:02 +0100
Subject: [PATCH] ARM: sun7i: dt: Add Mali node
Message-ID: <1518702362-115625-1-git-send-email-giulio.benetti@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A20 has an ARM Mali 400 GPU, so add binding to our DT.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index c4ed153d..1524ccb 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -1225,6 +1225,31 @@
 			#size-cells = <0>;
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
+			clocks = <&ccu CLK_AHB_GPU>, <&ccu CLK_GPU>;
+			clock-names = "bus", "core";
+			resets = <&ccu RST_GPU>;
+
+			assigned-clocks = <&ccu CLK_GPU>;
+			assigned-clock-rates = <384000000>;
+		};
+
 		gmac: ethernet at 1c50000 {
 			compatible = "allwinner,sun7i-a20-gmac";
 			reg = <0x01c50000 0x10000>;
-- 
2.7.4
