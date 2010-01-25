From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Mon, 25 Jan 2010 05:22:09 -0500
Subject: [PATCH] mmp2: append board irq events
Message-ID: <mailman.166.1264417467.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/include/mach/irqs.h     |    5 ++++-
 arch/arm/mach-mmp/include/mach/regs-icu.h |   12 ++++++++++++
 2 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mmp/include/mach/irqs.h
b/arch/arm/mach-mmp/include/mach/irqs.h
index f907cc9..4a0f746 100644
--- a/arch/arm/mach-mmp/include/mach/irqs.h
+++ b/arch/arm/mach-mmp/include/mach/irqs.h
@@ -222,6 +222,9 @@
 #define IRQ_GPIO_NUM			192
 #define IRQ_GPIO(x)			(IRQ_GPIO_START + (x))

-#define NR_IRQS		(IRQ_GPIO_START + IRQ_GPIO_NUM)
+/* SOC_NR_IRQS contains interrupt from interrupt controller and GPIOs */
+#define BOARD_NR_IRQS			64
+#define SOC_NR_IRQS			(IRQ_GPIO_START + IRQ_GPIO_NUM)
+#define NR_IRQS				(SOC_NR_IRQS + BOARD_NR_IRQS)

 #endif /* __ASM_MACH_IRQS_H */
diff --git a/arch/arm/mach-mmp/include/mach/regs-icu.h
b/arch/arm/mach-mmp/include/mach/regs-icu.h
index 02b8bf8..f882d91 100644
--- a/arch/arm/mach-mmp/include/mach/regs-icu.h
+++ b/arch/arm/mach-mmp/include/mach/regs-icu.h
@@ -40,6 +40,11 @@
 #define ICU_INT_ROUTE_PJ4_IRQ		(1 << 5)
 #define ICU_INT_ROUTE_PJ4_FIQ		(1 << 6)

+#define MMP2_ICU_PJ4_IRQ_STATUS0	ICU_REG(0x138)
+#define MMP2_ICU_PJ4_IRQ_STATUS1	ICU_REG(0x13c)
+#define MMP2_ICU_PJ4_FIQ_STATUS0	ICU_REG(0x140)
+#define MMP2_ICU_PJ4_FIQ_STATUS1	ICU_REG(0x144)
+
 #define MMP2_ICU_INT4_STATUS		ICU_REG(0x150)
 #define MMP2_ICU_INT5_STATUS		ICU_REG(0x154)
 #define MMP2_ICU_INT17_STATUS		ICU_REG(0x158)
@@ -56,4 +61,11 @@
 #define MMP2_ICU_PJ4_IRQ_SEL		ICU_REG(0x104)
 #define MMP2_ICU_PJ4_FIQ_SEL		ICU_REG(0x108)

+#define MMP2_ICU_INVERT			ICU_REG(0x164)
+
+#define MMP2_ICU_INV_PMIC		(1 << 0)
+#define MMP2_ICU_INV_PERF		(1 << 1)
+#define MMP2_ICU_INV_COMMTX		(1 << 2)
+#define MMP2_ICU_INV_COMMRX		(1 << 3)
+
 #endif /* __ASM_MACH_ICU_H */
-- 
1.5.6.5
