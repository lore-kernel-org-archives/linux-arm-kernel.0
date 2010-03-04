From: linux@arm.linux.org.uk (Russell King)
Date: Thu, 04 Mar 2010 19:11:56 +0000
Subject: [PATCH] ARM: 5890/1: Fix incorrect Realview board IRQs for L220
	and PMU
References: <git-1267729916-7f33674fea37cfdc2c024a267d2d2758cc64085c@rmk-PC>
Message-ID: <git-1267729916-c739d2307661c806c29c44bdccb224eca19d528b@rmk-PC>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

In anticipation of PMU support for Realview boards, the IRQs defined
for some of these boards need updating.

This patch removes incorrect L220 IRQ definitions, corrects incorrect PMU
IRQs and adds any missing IRQs that are required.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-realview/include/mach/irqs-pb1176.h |    1 +
 arch/arm/mach-realview/include/mach/irqs-pba8.h   |    8 ++------
 arch/arm/mach-realview/include/mach/irqs-pbx.h    |   14 ++++----------
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-realview/include/mach/irqs-pb1176.h b/arch/arm/mach-realview/include/mach/irqs-pb1176.h
index 2410d4f..830055b 100644
--- a/arch/arm/mach-realview/include/mach/irqs-pb1176.h
+++ b/arch/arm/mach-realview/include/mach/irqs-pb1176.h
@@ -31,6 +31,7 @@
 #define IRQ_DC1176_SOFTINT	(IRQ_DC1176_GIC_START + 1)	/* Software interrupt */
 #define IRQ_DC1176_COMMRx	(IRQ_DC1176_GIC_START + 2)	/* Debug Comm Rx interrupt */
 #define IRQ_DC1176_COMMTx	(IRQ_DC1176_GIC_START + 3)	/* Debug Comm Tx interrupt */
+#define IRQ_DC1176_CORE_PMU	(IRQ_DC1176_GIC_START + 7)	/* Core PMU interrupt */
 #define IRQ_DC1176_TIMER0	(IRQ_DC1176_GIC_START + 8)	/* Timer 0 */
 #define IRQ_DC1176_TIMER1	(IRQ_DC1176_GIC_START + 9)	/* Timer 1 */
 #define IRQ_DC1176_TIMER2	(IRQ_DC1176_GIC_START + 10)	/* Timer 2 */
diff --git a/arch/arm/mach-realview/include/mach/irqs-pba8.h b/arch/arm/mach-realview/include/mach/irqs-pba8.h
index 86792a9..4a88a4e 100644
--- a/arch/arm/mach-realview/include/mach/irqs-pba8.h
+++ b/arch/arm/mach-realview/include/mach/irqs-pba8.h
@@ -23,12 +23,6 @@
 
 #define IRQ_PBA8_GIC_START			32
 
-/* L220
-#define IRQ_PBA8_L220_EVENT	(IRQ_PBA8_GIC_START + 29)
-#define IRQ_PBA8_L220_SLAVE	(IRQ_PBA8_GIC_START + 30)
-#define IRQ_PBA8_L220_DECODE	(IRQ_PBA8_GIC_START + 31)
-*/
-
 /*
  * PB-A8 on-board gic irq sources
  */
@@ -65,6 +59,8 @@
 #define IRQ_PBA8_TSPEN		(IRQ_PBA8_GIC_START + 30)	/* Touchscreen pen */
 #define IRQ_PBA8_TSKPAD		(IRQ_PBA8_GIC_START + 31)	/* Touchscreen keypad */
 
+#define IRQ_PBA8_PMU		(IRQ_PBA8_GIC_START + 47)	/* Cortex-A8 PMU */
+
 /* ... */
 #define IRQ_PBA8_PCI0		(IRQ_PBA8_GIC_START + 50)
 #define IRQ_PBA8_PCI1		(IRQ_PBA8_GIC_START + 51)
diff --git a/arch/arm/mach-realview/include/mach/irqs-pbx.h b/arch/arm/mach-realview/include/mach/irqs-pbx.h
index deaad43..206a300 100644
--- a/arch/arm/mach-realview/include/mach/irqs-pbx.h
+++ b/arch/arm/mach-realview/include/mach/irqs-pbx.h
@@ -22,12 +22,6 @@
 
 #define IRQ_PBX_GIC_START			32
 
-/* L220
-#define IRQ_PBX_L220_EVENT	(IRQ_PBX_GIC_START + 29)
-#define IRQ_PBX_L220_SLAVE	(IRQ_PBX_GIC_START + 30)
-#define IRQ_PBX_L220_DECODE	(IRQ_PBX_GIC_START + 31)
-*/
-
 /*
  * PBX on-board gic irq sources
  */
@@ -77,10 +71,10 @@
 #define IRQ_PBX_TIMER4_5        (IRQ_PBX_GIC_START + 41)        /* Timer 0/1 (default timer) */
 #define IRQ_PBX_TIMER6_7        (IRQ_PBX_GIC_START + 42)        /* Timer 2/3 */
 /* ... */
-#define IRQ_PBX_PMU_CPU3        (IRQ_PBX_GIC_START + 44)        /* CPU PMU Interrupts */
-#define IRQ_PBX_PMU_CPU2        (IRQ_PBX_GIC_START + 45)
-#define IRQ_PBX_PMU_CPU1        (IRQ_PBX_GIC_START + 46)
-#define IRQ_PBX_PMU_CPU0        (IRQ_PBX_GIC_START + 47)
+#define IRQ_PBX_PMU_CPU0        (IRQ_PBX_GIC_START + 44)        /* CPU PMU Interrupts */
+#define IRQ_PBX_PMU_CPU1        (IRQ_PBX_GIC_START + 45)
+#define IRQ_PBX_PMU_CPU2        (IRQ_PBX_GIC_START + 46)
+#define IRQ_PBX_PMU_CPU3        (IRQ_PBX_GIC_START + 47)
 
 /* ... */
 #define IRQ_PBX_PCI0		(IRQ_PBX_GIC_START + 50)
