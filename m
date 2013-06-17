From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 17 Jun 2013 18:34:09 +0200
Subject: [PATCH v2 24/38] ARM: EXYNOS: Remove mach/regs-gpio.h header
In-Reply-To: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
References: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
Message-ID: <1371486863-12398-25-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Contents of this header are not used any more and can be safely removed.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/common.c                 |  1 -
 arch/arm/mach-exynos/include/mach/regs-gpio.h | 40 ---------------------------
 arch/arm/mach-exynos/pm.c                     |  1 -
 3 files changed, 42 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/include/mach/regs-gpio.h

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index f81aa22..7b53e4c 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -40,7 +40,6 @@
 
 #include <mach/regs-irq.h>
 #include <mach/regs-pmu.h>
-#include <mach/regs-gpio.h>
 
 #include <plat/cpu.h>
 #include <plat/pm.h>
diff --git a/arch/arm/mach-exynos/include/mach/regs-gpio.h b/arch/arm/mach-exynos/include/mach/regs-gpio.h
deleted file mode 100644
index e4b5b60..0000000
--- a/arch/arm/mach-exynos/include/mach/regs-gpio.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/* linux/arch/arm/mach-exynos4/include/mach/regs-gpio.h
- *
- * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * EXYNOS4 - GPIO (including EINT) register definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_REGS_GPIO_H
-#define __ASM_ARCH_REGS_GPIO_H __FILE__
-
-#include <mach/map.h>
-#include <mach/irqs.h>
-
-#define EINT_REG_NR(x)			(EINT_OFFSET(x) >> 3)
-#define EINT_CON(b, x)			(b + 0xE00 + (EINT_REG_NR(x) * 4))
-#define EINT_FLTCON(b, x)		(b + 0xE80 + (EINT_REG_NR(x) * 4))
-#define EINT_MASK(b, x)			(b + 0xF00 + (EINT_REG_NR(x) * 4))
-#define EINT_PEND(b, x)			(b + 0xF40 + (EINT_REG_NR(x) * 4))
-
-#define EINT_OFFSET_BIT(x)		(1 << (EINT_OFFSET(x) & 0x7))
-
-/* compatibility for plat-s5p/irq-pm.c */
-#define EXYNOS4_EINT40CON		(S5P_VA_GPIO2 + 0xE00)
-#define S5P_EINT_CON(x)			(EXYNOS4_EINT40CON + ((x) * 0x4))
-
-#define EXYNOS4_EINT40FLTCON0		(S5P_VA_GPIO2 + 0xE80)
-#define S5P_EINT_FLTCON(x)		(EXYNOS4_EINT40FLTCON0 + ((x) * 0x4))
-
-#define EXYNOS4_EINT40MASK		(S5P_VA_GPIO2 + 0xF00)
-#define S5P_EINT_MASK(x)		(EXYNOS4_EINT40MASK + ((x) * 0x4))
-
-#define EXYNOS4_EINT40PEND		(S5P_VA_GPIO2 + 0xF40)
-#define S5P_EINT_PEND(x)		(EXYNOS4_EINT40PEND + ((x) * 0x4))
-
-#endif /* __ASM_ARCH_REGS_GPIO_H */
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index e3faaa81..41c2069 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -30,7 +30,6 @@
 #include <plat/regs-srom.h>
 
 #include <mach/regs-irq.h>
-#include <mach/regs-gpio.h>
 #include <mach/regs-clock.h>
 #include <mach/regs-pmu.h>
 #include <mach/pm-core.h>
-- 
1.8.2.1
