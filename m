From: vz@mleia.com (Vladimir Zapolskiy)
Date: Thu,  8 Sep 2016 06:00:09 +0300
Subject: [PATCH 2/2] ARM: lpc32xx: remove unused header file clock.h
In-Reply-To: <1473303609-20076-1-git-send-email-vz@mleia.com>
References: <1473303609-20076-1-git-send-email-vz@mleia.com>
Message-ID: <1473303609-20076-2-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The removed clock.h file is a leftover after moving the platform to a
common clock framework driver, it contains unused "struct clk"
definition, which under circumstances may coalesce with a generic
"struct clk" declaration for clock consumers. Also remove useless
include of the removed local file from a single source file
mach-lpc32xx/pm.c.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/mach-lpc32xx/clock.h | 38 --------------------------------------
 arch/arm/mach-lpc32xx/pm.c    |  1 -
 2 files changed, 39 deletions(-)
 delete mode 100644 arch/arm/mach-lpc32xx/clock.h

diff --git a/arch/arm/mach-lpc32xx/clock.h b/arch/arm/mach-lpc32xx/clock.h
deleted file mode 100644
index c0a8434..0000000
--- a/arch/arm/mach-lpc32xx/clock.h
+++ /dev/null
@@ -1,38 +0,0 @@
-/*
- * arch/arm/mach-lpc32xx/clock.h
- *
- * Author: Kevin Wells <kevin.wells@nxp.com>
- *
- * Copyright (C) 2010 NXP Semiconductors
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#ifndef __LPC32XX_CLOCK_H
-#define __LPC32XX_CLOCK_H
-
-struct clk {
-	struct list_head node;
-	struct clk *parent;
-	u32 rate;
-	u32 usecount;
-
-	int (*set_rate) (struct clk *, unsigned long);
-	unsigned long (*round_rate) (struct clk *, unsigned long);
-	unsigned long (*get_rate) (struct clk *clk);
-	int (*enable) (struct clk *, int);
-
-	/* Register address and bit mask for simple clocks */
-	void __iomem *enable_reg;
-	u32 enable_mask;
-};
-
-#endif
diff --git a/arch/arm/mach-lpc32xx/pm.c b/arch/arm/mach-lpc32xx/pm.c
index 207e812..6247157 100644
--- a/arch/arm/mach-lpc32xx/pm.c
+++ b/arch/arm/mach-lpc32xx/pm.c
@@ -73,7 +73,6 @@
 #include <mach/hardware.h>
 #include <mach/platform.h>
 #include "common.h"
-#include "clock.h"
 
 #define TEMP_IRAM_AREA  IO_ADDRESS(LPC32XX_IRAM_BASE)
 
-- 
2.8.1
