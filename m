From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 18 May 2017 10:07:37 +0200
Subject: [PATCH v3 1/4] irqchip: armada-370-xp: re-order register definitions
In-Reply-To: <1495094860-24709-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1495094860-24709-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1495094860-24709-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to clarify to which register base the various register
definitions apply, this commit re-orders them, and adds a comment that
clearly indicate which registers are relative to "main_int_base" and
which registers are relative to "per_cpu_int_base".

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/irqchip/irq-armada-370-xp.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index eb0d4d4..76147df 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -34,25 +34,24 @@
 #include <asm/smp_plat.h>
 #include <asm/mach/irq.h>
 
-/* Interrupt Controller Registers Map */
-#define ARMADA_370_XP_INT_SET_MASK_OFFS		(0x48)
-#define ARMADA_370_XP_INT_CLEAR_MASK_OFFS	(0x4C)
-#define ARMADA_370_XP_INT_FABRIC_MASK_OFFS	(0x54)
-#define ARMADA_370_XP_INT_CAUSE_PERF(cpu)	(1 << cpu)
-
+/* Registers relative to main_int_base */
 #define ARMADA_370_XP_INT_CONTROL		(0x00)
+#define ARMADA_370_XP_SW_TRIG_INT_OFFS		(0x04)
 #define ARMADA_370_XP_INT_SET_ENABLE_OFFS	(0x30)
 #define ARMADA_370_XP_INT_CLEAR_ENABLE_OFFS	(0x34)
 #define ARMADA_370_XP_INT_SOURCE_CTL(irq)	(0x100 + irq*4)
 #define ARMADA_370_XP_INT_SOURCE_CPU_MASK	0xF
 #define ARMADA_370_XP_INT_IRQ_FIQ_MASK(cpuid)	((BIT(0) | BIT(8)) << cpuid)
 
-#define ARMADA_370_XP_CPU_INTACK_OFFS		(0x44)
+/* Registers relative to per_cpu_int_base */
+#define ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS	(0x08)
+#define ARMADA_370_XP_IN_DRBEL_MSK_OFFS		(0x0c)
 #define ARMADA_375_PPI_CAUSE			(0x10)
-
-#define ARMADA_370_XP_SW_TRIG_INT_OFFS           (0x4)
-#define ARMADA_370_XP_IN_DRBEL_MSK_OFFS          (0xc)
-#define ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS        (0x8)
+#define ARMADA_370_XP_CPU_INTACK_OFFS		(0x44)
+#define ARMADA_370_XP_INT_SET_MASK_OFFS		(0x48)
+#define ARMADA_370_XP_INT_CLEAR_MASK_OFFS	(0x4C)
+#define ARMADA_370_XP_INT_FABRIC_MASK_OFFS	(0x54)
+#define ARMADA_370_XP_INT_CAUSE_PERF(cpu)	(1 << cpu)
 
 #define ARMADA_370_XP_MAX_PER_CPU_IRQS		(28)
 
-- 
2.7.4
