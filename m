From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Tue,  7 Nov 2017 10:35:20 +0100
Subject: [PATCH 1/1] add mali r6p2 dt node
Message-ID: <1510047320-5480-1-git-send-email-giulio.benetti@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree mali node compatible with r6p2 utgard kernel driver 
provided by ARM and patched by maxime ripard on his github.

It can be easily used in target.dts with:

&mali {
	status = "okay";
}

then loading mali.ko in user space.

Best regards
Giulio Benetti
Micronova srl

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 228c368..e402596 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -1216,6 +1216,33 @@
 			#size-cells = <0>;
 		};
 
+		mali: gpu at 1c40000 {
+			compatible = "allwinner,sun8i-a23-mali",
+				     "allwinner,sun7i-a20-mali", "arm,mali-400";
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
+			#cooling-cells = <2>;
+
+			assigned-clocks = <&ccu CLK_GPU>;
+			assigned-clock-rates = <381000000>;
+		};
+
 		gmac: ethernet at 1c50000 {
 			compatible = "allwinner,sun7i-a20-gmac";
 			reg = <0x01c50000 0x10000>;
-- 
2.7.4
