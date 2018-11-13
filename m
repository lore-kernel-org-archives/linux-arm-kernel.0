From: jagan@amarulasolutions.com (Jagan Teki)
Date: Tue, 13 Nov 2018 17:30:54 +0530
Subject: [PATCH v2 2/2] arm64: dts: allwinner: a64: Add device node for
 Mali-400 GPU
In-Reply-To: <20181113120054.17639-1-jagan@amarulasolutions.com>
References: <20181113120054.17639-1-jagan@amarulasolutions.com>
Message-ID: <20181113120054.17639-2-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for Allwinner A64 has Mali-400MP2.

All interrupt lines are mentioned in the manual so used the same.
Used 408MHz as assigned clock rate used by BSP, so used the same as
well.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- Drop assigned clock properties
- Separate dt-bindings as separate patch.

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index d6f269883759..d507be9879d8 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -813,6 +813,28 @@
 			};
 		};
 
+		mali: gpu at 1c40000 {
+			compatible = "allwinner,sun50i-a64-mali", "arm,mali-400";
+			reg = <0x01c40000 0x10000>;
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
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
 		gic: interrupt-controller at 1c81000 {
 			compatible = "arm,gic-400";
 			reg = <0x01c81000 0x1000>,
-- 
2.18.0.321.gffc6fa0e3
