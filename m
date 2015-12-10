From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Fri, 11 Dec 2015 07:12:10 +0800
Subject: [PATCH 1/3] ARM: dts: imx7d: add arch timer
Message-ID: <1449789132-18976-1-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

add cortex a7 arch timer.
uboot v2016.01-rc2 supported psci basic support.
smp can be supported by psci

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 arch/arm/boot/dts/imx7d.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 489604a..a621af6 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -119,6 +119,15 @@
 		clock-output-names = "osc";
 	};
 
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupt-parent = <&intc>;
+	};
+
 	etr at 30086000 {
 		compatible = "arm,coresight-tmc", "arm,primecell";
 		reg = <0x30086000 0x1000>;
-- 
2.5.2
