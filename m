From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 6 Mar 2015 14:28:56 +0200
Subject: [PATCH 21/24] ARM: OMAP4: clock: remove clock44xx.h header
In-Reply-To: <1425644939-3232-1-git-send-email-t-kristo@ti.com>
References: <1425644939-3232-1-git-send-email-t-kristo@ti.com>
Message-ID: <1425644939-3232-22-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is not needed for anything anymore, so remove it completely.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock44xx.h |   20 --------------------
 arch/arm/mach-omap2/io.c        |    1 -
 2 files changed, 21 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/clock44xx.h

diff --git a/arch/arm/mach-omap2/clock44xx.h b/arch/arm/mach-omap2/clock44xx.h
deleted file mode 100644
index 287a46f..0000000
--- a/arch/arm/mach-omap2/clock44xx.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * OMAP4 clock function prototypes and macros
- *
- * Copyright (C) 2009 Texas Instruments, Inc.
- * Copyright (C) 2010 Nokia Corporation
- */
-
-#ifndef __ARCH_ARM_MACH_OMAP2_CLOCK44XX_H
-#define __ARCH_ARM_MACH_OMAP2_CLOCK44XX_H
-
-/*
- * OMAP4430_REGM4XEN_MULT: If the CM_CLKMODE_DPLL_ABE.DPLL_REGM4XEN bit is
- *    set, then the DPLL's lock frequency is multiplied by 4 (OMAP4430 TRM
- *    vV Section 3.6.3.3.1 "DPLLs Output Clocks Parameters")
- */
-#define OMAP4430_REGM4XEN_MULT	4
-
-int omap4xxx_clk_init(void);
-
-#endif
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index c4871c5..ede2229 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -37,7 +37,6 @@
 #include "clock.h"
 #include "clock2xxx.h"
 #include "clock3xxx.h"
-#include "clock44xx.h"
 #include "omap-pm.h"
 #include "sdrc.h"
 #include "control.h"
-- 
1.7.9.5
