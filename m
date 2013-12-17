From: kgene@kernel.org (kgene at kernel.org)
Date: Tue, 17 Dec 2013 20:52:17 +0900
Subject: [PATCH 04/11] ARM: EXYNOS: cleanup <mach/regs-irq.h>
Message-ID: <116201cefb1e$6f9f3ae0$4eddb0a0$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kukjin Kim <kgene.kim@samsung.com>

Remove useless inclusion <mach/regs-irq.h> for exynos.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/common.c                |    2 --
 arch/arm/mach-exynos/include/mach/regs-irq.h |   19 -------------------
 arch/arm/mach-exynos/pm.c                    |    1 -
 arch/arm/plat-samsung/pm.c                   |    2 ++
 arch/arm/plat-samsung/s5p-irq-pm.c           |    3 +++
 5 files changed, 5 insertions(+), 22 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/include/mach/regs-irq.h

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 1fc0424..52cef6a 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -37,8 +37,6 @@
 #include <asm/mach/irq.h>
 #include <asm/cacheflush.h>
 
-#include <mach/regs-irq.h>
-
 #include <plat/cpu.h>
 #include <plat/pm.h>
 #include <plat/regs-serial.h>
diff --git a/arch/arm/mach-exynos/include/mach/regs-irq.h
b/arch/arm/mach-exynos/include/mach/regs-irq.h
deleted file mode 100644
index f2b5050..0000000
--- a/arch/arm/mach-exynos/include/mach/regs-irq.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* linux/arch/arm/mach-exynos4/include/mach/regs-irq.h
- *
- * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * EXYNOS4 - IRQ register definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_REGS_IRQ_H
-#define __ASM_ARCH_REGS_IRQ_H __FILE__
-
-#include <linux/irqchip/arm-gic.h>
-#include <mach/map.h>
-
-#endif /* __ASM_ARCH_REGS_IRQ_H */
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 717c6a6..d4a3368 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -29,7 +29,6 @@
 #include <plat/pll.h>
 #include <plat/regs-srom.h>
 
-#include <mach/regs-irq.h>
 #include <mach/regs-clock.h>
 #include <mach/pm-core.h>
 
diff --git a/arch/arm/plat-samsung/pm.c b/arch/arm/plat-samsung/pm.c
index d0c2301..47ec54b 100644
--- a/arch/arm/plat-samsung/pm.c
+++ b/arch/arm/plat-samsung/pm.c
@@ -29,7 +29,9 @@
 #include <mach/hardware.h>
 #include <mach/map.h>
 #include <mach/regs-clock.h>
+#ifndef CONFIG_ARCH_EXYNOS
 #include <mach/regs-irq.h>
+#endif
 #include <mach/irqs.h>
 #endif
 
diff --git a/arch/arm/plat-samsung/s5p-irq-pm.c
b/arch/arm/plat-samsung/s5p-irq-pm.c
index 7c1e3b7..5914980 100644
--- a/arch/arm/plat-samsung/s5p-irq-pm.c
+++ b/arch/arm/plat-samsung/s5p-irq-pm.c
@@ -22,7 +22,10 @@
 #include <mach/map.h>
 
 #include <mach/regs-gpio.h>
+
+#ifndef CONFIG_ARCH_EXYNOS
 #include <mach/regs-irq.h>
+#endif
 
 /* state for IRQs over sleep */
 
-- 
1.7.10.4
