From: jongsun.han@samsung.com (Jongsun Han)
Date: Thu,  7 Oct 2010 20:24:57 +0900
Subject: [PATCH 2/3] ARM: S5PV310: Add the definition for external interrupt
In-Reply-To: <1286450698-12029-1-git-send-email-jongsun.han@samsung.com>
References: <1286450698-12029-1-git-send-email-jongsun.han@samsung.com>
Message-ID: <1286450698-12029-3-git-send-email-jongsun.han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the definition for both IRQs and GPIO registers for external
interrupt.

Signed-off-by: Jongsun Han <jongsun.han@samsung.com>
---
 arch/arm/mach-s5pv310/include/mach/irqs.h      |   26 +++++++++++++++-
 arch/arm/mach-s5pv310/include/mach/regs-gpio.h |   37 ++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-s5pv310/include/mach/regs-gpio.h

diff --git a/arch/arm/mach-s5pv310/include/mach/irqs.h b/arch/arm/mach-s5pv310/include/mach/irqs.h
index e81332f..9faea58 100644
--- a/arch/arm/mach-s5pv310/include/mach/irqs.h
+++ b/arch/arm/mach-s5pv310/include/mach/irqs.h
@@ -78,10 +78,32 @@
 
 #define IRQ_ONENAND_AUDI	COMBINER_IRQ(34, 0)
 
+#define IRQ_EINT4		COMBINER_IRQ(37, 0)
+#define IRQ_EINT5		COMBINER_IRQ(37, 1)
+#define IRQ_EINT6		COMBINER_IRQ(37, 2)
+#define IRQ_EINT7		COMBINER_IRQ(37, 3)
+#define IRQ_EINT8		COMBINER_IRQ(38, 0)
+
+#define IRQ_EINT9		COMBINER_IRQ(38, 1)
+#define IRQ_EINT10		COMBINER_IRQ(38, 2)
+#define IRQ_EINT11		COMBINER_IRQ(38, 3)
+#define IRQ_EINT12		COMBINER_IRQ(38, 4)
+#define IRQ_EINT13		COMBINER_IRQ(38, 5)
+#define IRQ_EINT14		COMBINER_IRQ(38, 6)
+#define IRQ_EINT15		COMBINER_IRQ(38, 7)
+
+#define IRQ_EINT16_31		COMBINER_IRQ(39, 0)
+
+#define IRQ_EINT_BASE		(IRQ_EINT16_31 + 1)
+
 /* Set the default NR_IRQS */
+#define NR_IRQS			(IRQ_EINT_BASE + 32)
+
+#define EINT_NUMBER(x)		((x) + IRQ_EINT_BASE)
 
-#define NR_IRQS			COMBINER_IRQ(MAX_COMBINER_NR, 0)
+#define S5P_EINT_BASE1		EINT_NUMBER(0)
+#define S5P_EINT_BASE2		EINT_NUMBER(16)
 
-#define MAX_COMBINER_NR		39
+#define MAX_COMBINER_NR		40
 
 #endif /* __ASM_ARCH_IRQS_H */
diff --git a/arch/arm/mach-s5pv310/include/mach/regs-gpio.h b/arch/arm/mach-s5pv310/include/mach/regs-gpio.h
new file mode 100644
index 0000000..4fddb12
--- /dev/null
+++ b/arch/arm/mach-s5pv310/include/mach/regs-gpio.h
@@ -0,0 +1,37 @@
+/* linux/arch/arm/mach-s5pv310/include/mach/regs-gpio.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * S5PV310 - GPIO (including EINT) register definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_REGS_GPIO_H
+#define __ASM_ARCH_REGS_GPIO_H __FILE__
+
+#include <mach/map.h>
+
+#define S5PV310_EINT40CON		(S5P_VA_GPIO2 + 0xE00)
+#define S5P_EINT_CON(x)			(S5PV310_EINT40CON + ((x) * 0x4))
+
+#define S5PV310_EINT40FLTCON0		(S5P_VA_GPIO2 + 0xE80)
+#define S5P_EINT_FLTCON(x)		(S5PV310_EINT40FLTCON0 + ((x) * 0x4))
+
+#define S5PV310_EINT40MASK		(S5P_VA_GPIO2 + 0xF00)
+#define S5P_EINT_MASK(x)		(S5PV310_EINT40MASK + ((x) * 0x4))
+
+#define S5PV310_EINT40PEND		(S5P_VA_GPIO2 + 0xF40)
+#define S5P_EINT_PEND(x)		(S5PV310_EINT40PEND + ((x) * 0x4))
+
+#define EINT_MODE			S3C_GPIO_SFN(0xf)
+
+#define EINT_GPIO_0(x)			S5PV310_GPX0(x)
+#define EINT_GPIO_1(x)			S5PV310_GPX1(x)
+#define EINT_GPIO_2(x)			S5PV310_GPX2(x)
+#define EINT_GPIO_3(x)			S5PV310_GPX3(x)
+
+#endif /* __ASM_ARCH_REGS_GPIO_H */
-- 
1.6.3.3
