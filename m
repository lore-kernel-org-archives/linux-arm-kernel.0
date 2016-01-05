From: Frank.Li@nxp.com (Frank Li)
Date: Tue, 5 Jan 2016 11:17:14 -0600
Subject: [PATCH v2 1/4] ARM: dts: imx7d: add arch timer
Message-ID: <1452014237-12848-1-git-send-email-Frank.Li@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

Since uboot v2016.01-rc2, which supported basic psci for i.mx7d.
So imx7d's second core can be enabled by psci.

Without arch timer, every timer event will be boardcasted to each core.
arch timer has local timer irq for each core.

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---

Change from v1 to v2:
 * refine commit message show the relationship between smp and arch timer

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
