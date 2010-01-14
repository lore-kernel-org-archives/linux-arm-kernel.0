From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 14 Jan 2010 12:29:24 +0100
Subject: [PATCH 06/21] ARM: S5PC1XX: move common s5pc1xx mach/* includes to
	plat-s5pc1xx/include/mach
In-Reply-To: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
References: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1263468579-5732-7-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

All includes that are common for S5PC100 and S5PC110 are moved to
plat-s5pc1xx/include/mach, so they can be used by both sub-platforms.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-s5pc100/include/mach/gpio-core.h  |   21 ---------
 arch/arm/mach-s5pc100/include/mach/hardware.h   |   14 ------
 arch/arm/mach-s5pc100/include/mach/irqs.h       |   19 --------
 arch/arm/mach-s5pc100/include/mach/memory.h     |   18 -------
 arch/arm/mach-s5pc100/include/mach/pwm-clock.h  |   56 -----------------------
 arch/arm/mach-s5pc100/include/mach/tick.h       |   29 ------------
 arch/arm/mach-s5pc100/include/mach/uncompress.h |   28 -----------
 arch/arm/plat-s5pc1xx/include/mach/gpio-core.h  |   21 +++++++++
 arch/arm/plat-s5pc1xx/include/mach/hardware.h   |   14 ++++++
 arch/arm/plat-s5pc1xx/include/mach/irqs.h       |   19 ++++++++
 arch/arm/plat-s5pc1xx/include/mach/memory.h     |   18 +++++++
 arch/arm/plat-s5pc1xx/include/mach/pwm-clock.h  |   56 +++++++++++++++++++++++
 arch/arm/plat-s5pc1xx/include/mach/tick.h       |   29 ++++++++++++
 arch/arm/plat-s5pc1xx/include/mach/uncompress.h |   28 +++++++++++
 14 files changed, 185 insertions(+), 185 deletions(-)
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/gpio-core.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/memory.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/pwm-clock.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/tick.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/uncompress.h
 create mode 100644 arch/arm/plat-s5pc1xx/include/mach/gpio-core.h
 create mode 100644 arch/arm/plat-s5pc1xx/include/mach/hardware.h
 create mode 100644 arch/arm/plat-s5pc1xx/include/mach/irqs.h
 create mode 100644 arch/arm/plat-s5pc1xx/include/mach/memory.h
 create mode 100644 arch/arm/plat-s5pc1xx/include/mach/pwm-clock.h
 create mode 100644 arch/arm/plat-s5pc1xx/include/mach/tick.h
 create mode 100644 arch/arm/plat-s5pc1xx/include/mach/uncompress.h

diff --git a/arch/arm/mach-s5pc100/include/mach/gpio-core.h b/arch/arm/mach-s5pc100/include/mach/gpio-core.h
deleted file mode 100644
index ad28d8e..0000000
--- a/arch/arm/mach-s5pc100/include/mach/gpio-core.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* arch/arm/mach-s5pc100/include/mach/gpio-core.h
- *
- * Copyright 2009 Samsung Electronics Co.
- *      Byungho Min <bhmin@samsung.com>
- *
- * S5PC100 - GPIO core support
- *
- * Based on mach-s3c6400/include/mach/gpio-core.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_GPIO_CORE_H
-#define __ASM_ARCH_GPIO_CORE_H __FILE__
-
-/* currently we just include the platform support */
-#include <plat/gpio-core.h>
-
-#endif /* __ASM_ARCH_GPIO_CORE_H */
diff --git a/arch/arm/mach-s5pc100/include/mach/hardware.h b/arch/arm/mach-s5pc100/include/mach/hardware.h
deleted file mode 100644
index 6b38618..0000000
--- a/arch/arm/mach-s5pc100/include/mach/hardware.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* linux/arch/arm/mach-s5pc100/include/mach/hardware.h
- *
- * Copyright 2009 Samsung Electronics Co.
- *      Byungho Min <bhmin@samsung.com>
- *
- * S5PC100 - Hardware support
- */
-
-#ifndef __ASM_ARCH_HARDWARE_H
-#define __ASM_ARCH_HARDWARE_H __FILE__
-
-/* currently nothing here, placeholder */
-
-#endif /* __ASM_ARCH_HARDWARE_H */
diff --git a/arch/arm/mach-s5pc100/include/mach/irqs.h b/arch/arm/mach-s5pc100/include/mach/irqs.h
deleted file mode 100644
index b53fa48..0000000
--- a/arch/arm/mach-s5pc100/include/mach/irqs.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* linux/arch/arm/mach-s5pc100/include/mach/irqs.h
- *
- * Copyright 2009 Samsung Electronics Co.
- *      Byungho Min <bhmin@samsung.com>
- *
- * S5PC100 - IRQ definitions
- */
-
-#ifndef __ASM_ARCH_IRQS_H
-#define __ASM_ARCH_IRQS_H __FILE__
-
-#include <plat/irqs.h>
-
-/* LCD */
-#define IRQ_LCD_FIFO		IRQ_LCD0
-#define IRQ_LCD_VSYNC		IRQ_LCD1
-#define IRQ_LCD_SYSTEM		IRQ_LCD2
-
-#endif /* __ASM_ARCH_IRQ_H */
diff --git a/arch/arm/mach-s5pc100/include/mach/memory.h b/arch/arm/mach-s5pc100/include/mach/memory.h
deleted file mode 100644
index 21cc182..0000000
--- a/arch/arm/mach-s5pc100/include/mach/memory.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* arch/arm/mach-s5pc100/include/mach/memory.h
- *
- * Copyright 2008 Samsung Electronics Co.
- *      Byungho Min <bhmin@samsung.com>
- *
- * Based on mach-s3c6400/include/mach/memory.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_MEMORY_H
-#define __ASM_ARCH_MEMORY_H
-
-#define PHYS_OFFSET     	UL(0x30000000)
-
-#endif
diff --git a/arch/arm/mach-s5pc100/include/mach/pwm-clock.h b/arch/arm/mach-s5pc100/include/mach/pwm-clock.h
deleted file mode 100644
index b34d2f7..0000000
--- a/arch/arm/mach-s5pc100/include/mach/pwm-clock.h
+++ /dev/null
@@ -1,56 +0,0 @@
-/* linux/arch/arm/mach-s5pc100/include/mach/pwm-clock.h
- *
- * Copyright 2009 Samsung Electronics Co.
- *      Byungho Min <bhmin@samsung.com>
- *
- * S5PC100 - pwm clock and timer support
- *
- * Based on mach-s3c6400/include/mach/pwm-clock.h
- */
-
-/**
- * pwm_cfg_src_is_tclk() - return whether the given mux config is a tclk
- * @tcfg: The timer TCFG1 register bits shifted down to 0.
- *
- * Return true if the given configuration from TCFG1 is a TCLK instead
- * any of the TDIV clocks.
- */
-static inline int pwm_cfg_src_is_tclk(unsigned long tcfg)
-{
-	return tcfg >= S3C64XX_TCFG1_MUX_TCLK;
-}
-
-/**
- * tcfg_to_divisor() - convert tcfg1 setting to a divisor
- * @tcfg1: The tcfg1 setting, shifted down.
- *
- * Get the divisor value for the given tcfg1 setting. We assume the
- * caller has already checked to see if this is not a TCLK source.
- */
-static inline unsigned long tcfg_to_divisor(unsigned long tcfg1)
-{
-	return 1 << tcfg1;
-}
-
-/**
- * pwm_tdiv_has_div1() - does the tdiv setting have a /1
- *
- * Return true if we have a /1 in the tdiv setting.
- */
-static inline unsigned int pwm_tdiv_has_div1(void)
-{
-	return 1;
-}
-
-/**
- * pwm_tdiv_div_bits() - calculate TCFG1 divisor value.
- * @div: The divisor to calculate the bit information for.
- *
- * Turn a divisor into the necessary bit field for TCFG1.
- */
-static inline unsigned long pwm_tdiv_div_bits(unsigned int div)
-{
-	return ilog2(div);
-}
-
-#define S3C_TCFG1_MUX_TCLK S3C64XX_TCFG1_MUX_TCLK
diff --git a/arch/arm/mach-s5pc100/include/mach/tick.h b/arch/arm/mach-s5pc100/include/mach/tick.h
deleted file mode 100644
index f338c9e..0000000
--- a/arch/arm/mach-s5pc100/include/mach/tick.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* linux/arch/arm/mach-s5pc100/include/mach/tick.h
- *
- * Copyright 2009 Samsung Electronics Co.
- *	Byungho Min <bhmin@samsung.com>
- *
- * S3C64XX - Timer tick support definitions
- *
- * Based on mach-s3c6400/include/mach/tick.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_TICK_H
-#define __ASM_ARCH_TICK_H __FILE__
-
-/* note, the timer interrutps turn up in 2 places, the vic and then
- * the timer block. We take the VIC as the base at the moment.
- */
-static inline u32 s3c24xx_ostimer_pending(void)
-{
-	u32 pend = __raw_readl(S3C_VA_VIC0 + VIC_RAW_STATUS);
-	return pend & 1 << (IRQ_TIMER4_VIC - S5PC1XX_IRQ_VIC0(0));
-}
-
-#define TICK_MAX	(0xffffffff)
-
-#endif /* __ASM_ARCH_TICK_H */
diff --git a/arch/arm/mach-s5pc100/include/mach/uncompress.h b/arch/arm/mach-s5pc100/include/mach/uncompress.h
deleted file mode 100644
index 01ccf53..0000000
--- a/arch/arm/mach-s5pc100/include/mach/uncompress.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* arch/arm/mach-s5pc100/include/mach/uncompress.h
- *
- * Copyright 2009 Samsung Electronics Co.
- *	Byungho Min <bhmin@samsung.com>
- *
- * S5PC100 - uncompress code
- *
- * Based on mach-s3c6400/include/mach/uncompress.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_UNCOMPRESS_H
-#define __ASM_ARCH_UNCOMPRESS_H
-
-#include <mach/map.h>
-#include <plat/uncompress.h>
-
-static void arch_detect_cpu(void)
-{
-	/* we do not need to do any cpu detection here at the moment. */
-	fifo_mask = S3C2440_UFSTAT_TXMASK;
-	fifo_max = 63 << S3C2440_UFSTAT_TXSHIFT;
-}
-
-#endif /* __ASM_ARCH_UNCOMPRESS_H */
diff --git a/arch/arm/plat-s5pc1xx/include/mach/gpio-core.h b/arch/arm/plat-s5pc1xx/include/mach/gpio-core.h
new file mode 100644
index 0000000..6364800
--- /dev/null
+++ b/arch/arm/plat-s5pc1xx/include/mach/gpio-core.h
@@ -0,0 +1,21 @@
+/* arch/arm/plat-s5pc1xx/include/mach/gpio-core.h
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *      Byungho Min <bhmin@samsung.com>
+ *
+ * S5PC100 - GPIO core support
+ *
+ * Based on mach-s3c6400/include/mach/gpio-core.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_GPIO_CORE_H
+#define __ASM_ARCH_GPIO_CORE_H __FILE__
+
+/* currently we just include the platform support */
+#include <plat/gpio-core.h>
+
+#endif /* __ASM_ARCH_GPIO_CORE_H */
diff --git a/arch/arm/plat-s5pc1xx/include/mach/hardware.h b/arch/arm/plat-s5pc1xx/include/mach/hardware.h
new file mode 100644
index 0000000..c47affb
--- /dev/null
+++ b/arch/arm/plat-s5pc1xx/include/mach/hardware.h
@@ -0,0 +1,14 @@
+/* linux/arch/arm/plat-s5pc1xx/include/mach/hardware.h
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *      Byungho Min <bhmin@samsung.com>
+ *
+ * S5PC100 - Hardware support
+ */
+
+#ifndef __ASM_ARCH_HARDWARE_H
+#define __ASM_ARCH_HARDWARE_H __FILE__
+
+/* currently nothing here, placeholder */
+
+#endif /* __ASM_ARCH_HARDWARE_H */
diff --git a/arch/arm/plat-s5pc1xx/include/mach/irqs.h b/arch/arm/plat-s5pc1xx/include/mach/irqs.h
new file mode 100644
index 0000000..198cff8
--- /dev/null
+++ b/arch/arm/plat-s5pc1xx/include/mach/irqs.h
@@ -0,0 +1,19 @@
+/* linux/arch/arm/plat-s5pc1xx/include/mach/irqs.h
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *      Byungho Min <bhmin@samsung.com>
+ *
+ * S5PC100 - IRQ definitions
+ */
+
+#ifndef __ASM_ARCH_IRQS_H
+#define __ASM_ARCH_IRQS_H __FILE__
+
+#include <plat/irqs.h>
+
+/* LCD */
+#define IRQ_LCD_FIFO		IRQ_LCD0
+#define IRQ_LCD_VSYNC		IRQ_LCD1
+#define IRQ_LCD_SYSTEM		IRQ_LCD2
+
+#endif /* __ASM_ARCH_IRQ_H */
diff --git a/arch/arm/plat-s5pc1xx/include/mach/memory.h b/arch/arm/plat-s5pc1xx/include/mach/memory.h
new file mode 100644
index 0000000..d378f45
--- /dev/null
+++ b/arch/arm/plat-s5pc1xx/include/mach/memory.h
@@ -0,0 +1,18 @@
+/* linux/arch/arm/plat-s5pc1xx/include/mach/memory.h
+ *
+ * Copyright 2008 Samsung Electronics Co.
+ *      Byungho Min <bhmin@samsung.com>
+ *
+ * Based on mach-s3c6400/include/mach/memory.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_MEMORY_H
+#define __ASM_ARCH_MEMORY_H
+
+#define PHYS_OFFSET     	UL(0x30000000)
+
+#endif
diff --git a/arch/arm/plat-s5pc1xx/include/mach/pwm-clock.h b/arch/arm/plat-s5pc1xx/include/mach/pwm-clock.h
new file mode 100644
index 0000000..09a2834
--- /dev/null
+++ b/arch/arm/plat-s5pc1xx/include/mach/pwm-clock.h
@@ -0,0 +1,56 @@
+/* linux/arch/arm/plat-s5pc1xx/include/mach/pwm-clock.h
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *      Byungho Min <bhmin@samsung.com>
+ *
+ * S5PC100 - pwm clock and timer support
+ *
+ * Based on mach-s3c6400/include/mach/pwm-clock.h
+ */
+
+/**
+ * pwm_cfg_src_is_tclk() - return whether the given mux config is a tclk
+ * @tcfg: The timer TCFG1 register bits shifted down to 0.
+ *
+ * Return true if the given configuration from TCFG1 is a TCLK instead
+ * any of the TDIV clocks.
+ */
+static inline int pwm_cfg_src_is_tclk(unsigned long tcfg)
+{
+	return tcfg >= S3C64XX_TCFG1_MUX_TCLK;
+}
+
+/**
+ * tcfg_to_divisor() - convert tcfg1 setting to a divisor
+ * @tcfg1: The tcfg1 setting, shifted down.
+ *
+ * Get the divisor value for the given tcfg1 setting. We assume the
+ * caller has already checked to see if this is not a TCLK source.
+ */
+static inline unsigned long tcfg_to_divisor(unsigned long tcfg1)
+{
+	return 1 << tcfg1;
+}
+
+/**
+ * pwm_tdiv_has_div1() - does the tdiv setting have a /1
+ *
+ * Return true if we have a /1 in the tdiv setting.
+ */
+static inline unsigned int pwm_tdiv_has_div1(void)
+{
+	return 1;
+}
+
+/**
+ * pwm_tdiv_div_bits() - calculate TCFG1 divisor value.
+ * @div: The divisor to calculate the bit information for.
+ *
+ * Turn a divisor into the necessary bit field for TCFG1.
+ */
+static inline unsigned long pwm_tdiv_div_bits(unsigned int div)
+{
+	return ilog2(div);
+}
+
+#define S3C_TCFG1_MUX_TCLK S3C64XX_TCFG1_MUX_TCLK
diff --git a/arch/arm/plat-s5pc1xx/include/mach/tick.h b/arch/arm/plat-s5pc1xx/include/mach/tick.h
new file mode 100644
index 0000000..c12f925
--- /dev/null
+++ b/arch/arm/plat-s5pc1xx/include/mach/tick.h
@@ -0,0 +1,29 @@
+/* linux/arch/arm/plat-s5pc1xx/include/mach/tick.h
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *	Byungho Min <bhmin@samsung.com>
+ *
+ * S3C64XX - Timer tick support definitions
+ *
+ * Based on mach-s3c6400/include/mach/tick.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_TICK_H
+#define __ASM_ARCH_TICK_H __FILE__
+
+/* note, the timer interrutps turn up in 2 places, the vic and then
+ * the timer block. We take the VIC as the base at the moment.
+ */
+static inline u32 s3c24xx_ostimer_pending(void)
+{
+	u32 pend = __raw_readl(S3C_VA_VIC0 + VIC_RAW_STATUS);
+	return pend & 1 << (IRQ_TIMER4_VIC - S5PC1XX_IRQ_VIC0(0));
+}
+
+#define TICK_MAX	(0xffffffff)
+
+#endif /* __ASM_ARCH_TICK_H */
diff --git a/arch/arm/plat-s5pc1xx/include/mach/uncompress.h b/arch/arm/plat-s5pc1xx/include/mach/uncompress.h
new file mode 100644
index 0000000..e9ee0be
--- /dev/null
+++ b/arch/arm/plat-s5pc1xx/include/mach/uncompress.h
@@ -0,0 +1,28 @@
+/* linux/arch/arm/plat-s5pc1xx/include/mach/uncompress.h
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *	Byungho Min <bhmin@samsung.com>
+ *
+ * S5PC100 - uncompress code
+ *
+ * Based on mach-s3c6400/include/mach/uncompress.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_UNCOMPRESS_H
+#define __ASM_ARCH_UNCOMPRESS_H
+
+#include <mach/map.h>
+#include <plat/uncompress.h>
+
+static void arch_detect_cpu(void)
+{
+	/* we do not need to do any cpu detection here at the moment. */
+	fifo_mask = S3C2440_UFSTAT_TXMASK;
+	fifo_max = 63 << S3C2440_UFSTAT_TXSHIFT;
+}
+
+#endif /* __ASM_ARCH_UNCOMPRESS_H */
-- 
1.6.4
