From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 27 Jan 2012 16:04:14 +0000
Subject: [PATCH] ARM: realview: fix unconnected interrupts on EB11MP
Message-ID: <1327680254-24313-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 2eac58d (ARM: amba: make use of -1 IRQs warn), we're
able to detect the use of value -1 to indicate the lack of interrupt
line.

The RealView EB, when used with the 11MPCore tile, has a number of
devices without interrupts, and uses the value -1 to indicate this.

Change that value to 0 to conform to the new behaviour.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-realview/include/mach/irqs-eb.h |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-realview/include/mach/irqs-eb.h b/arch/arm/mach-realview/include/mach/irqs-eb.h
index 204d537..d6b5073 100644
--- a/arch/arm/mach-realview/include/mach/irqs-eb.h
+++ b/arch/arm/mach-realview/include/mach/irqs-eb.h
@@ -96,16 +96,19 @@
 #define IRQ_EB11MP_L220_SLAVE	(IRQ_EB_GIC_START + 30)
 #define IRQ_EB11MP_L220_DECODE	(IRQ_EB_GIC_START + 31)
 
-#define IRQ_EB11MP_UART2	-1
-#define IRQ_EB11MP_UART3	-1
-#define IRQ_EB11MP_CLCD		-1
-#define IRQ_EB11MP_DMA		-1
-#define IRQ_EB11MP_WDOG		-1
-#define IRQ_EB11MP_GPIO0	-1
-#define IRQ_EB11MP_GPIO1	-1
-#define IRQ_EB11MP_GPIO2	-1
-#define IRQ_EB11MP_SCI		-1
-#define IRQ_EB11MP_SSP		-1
+/*
+ * The 11MPcore tile leaves the following unconnected.
+ */
+#define IRQ_EB11MP_UART2	0
+#define IRQ_EB11MP_UART3	0
+#define IRQ_EB11MP_CLCD		0
+#define IRQ_EB11MP_DMA		0
+#define IRQ_EB11MP_WDOG		0
+#define IRQ_EB11MP_GPIO0	0
+#define IRQ_EB11MP_GPIO1	0
+#define IRQ_EB11MP_GPIO2	0
+#define IRQ_EB11MP_SCI		0
+#define IRQ_EB11MP_SSP		0
 
 #define NR_GIC_EB11MP		2
 
-- 
1.7.7.1
