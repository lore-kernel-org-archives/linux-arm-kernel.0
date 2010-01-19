From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 19 Jan 2010 16:36:33 -0700
Subject: [PATCH v2 14/18] OMAP2/3 clock: remove unnecessary includes and clean
	up header
In-Reply-To: <20100119232900.26047.98263.stgit@localhost.localdomain>
References: <20100119232900.26047.98263.stgit@localhost.localdomain>
Message-ID: <20100119233630.26047.902.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that almost all of the code has been removed from clock2xxx.c and
clock34xx.c, many of the includes are now unnecessary and can be removed.
While we're here, standardize the initial comment blocks.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
Cc: Jouni H?gander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/clock2xxx.c |   35 ++++++++++-------------------------
 arch/arm/mach-omap2/clock34xx.c |   16 +++-------------
 2 files changed, 13 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2xxx.c b/arch/arm/mach-omap2/clock2xxx.c
index b7e81ec..e98f48b 100644
--- a/arch/arm/mach-omap2/clock2xxx.c
+++ b/arch/arm/mach-omap2/clock2xxx.c
@@ -1,15 +1,15 @@
 /*
- *  linux/arch/arm/mach-omap2/clock.c
+ * clock2xxx.c - OMAP2xxx-specific clock integration code
  *
- *  Copyright (C) 2005-2008 Texas Instruments, Inc.
- *  Copyright (C) 2004-2008 Nokia Corporation
+ * Copyright (C) 2005-2008 Texas Instruments, Inc.
+ * Copyright (C) 2004-2010 Nokia Corporation
  *
- *  Contacts:
- *  Richard Woodruff <r-woodruff2@ti.com>
- *  Paul Walmsley
+ * Contacts:
+ * Richard Woodruff <r-woodruff2@ti.com>
+ * Paul Walmsley
  *
- *  Based on earlier work by Tuukka Tikkanen, Tony Lindgren,
- *  Gordon McNutt and RidgeRun, Inc.
+ * Based on earlier work by Tuukka Tikkanen, Tony Lindgren,
+ * Gordon McNutt and RidgeRun, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -17,38 +17,23 @@
  */
 #undef DEBUG
 
-#include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/device.h>
-#include <linux/list.h>
 #include <linux/errno.h>
-#include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/io.h>
-#include <linux/cpufreq.h>
-#include <linux/bitops.h>
 
 #include <plat/clock.h>
-#include <plat/sram.h>
-#include <plat/prcm.h>
-#include <plat/clkdev_omap.h>
-#include <asm/div64.h>
-#include <asm/clkdev.h>
 
-#include <plat/sdrc.h>
 #include "clock.h"
 #include "clock2xxx.h"
-#include "opp2xxx.h"
-#include "prm.h"
-#include "prm-regbits-24xx.h"
 #include "cm.h"
 #include "cm-regbits-24xx.h"
 
 struct clk *vclk, *sclk, *dclk;
 
-/*-------------------------------------------------------------------------
+/*
  * Omap24xx specific clock functions
- *-------------------------------------------------------------------------*/
+ */
 
 #ifdef CONFIG_ARCH_OMAP2430
 
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index d38ad44..8a7db7a 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -2,10 +2,10 @@
  * OMAP3-specific clock framework functions
  *
  * Copyright (C) 2007-2008 Texas Instruments, Inc.
- * Copyright (C) 2007-2009 Nokia Corporation
+ * Copyright (C) 2007-2010 Nokia Corporation
  *
- * Written by Paul Walmsley
- * Testing and integration fixes by Jouni H?gander
+ * Paul Walmsley
+ * Jouni H?gander
  *
  * Parts of this code are based on code written by
  * Richard Woodruff, Tony Lindgren, Tuukka Tikkanen, Karthik Dasu
@@ -16,27 +16,17 @@
  */
 #undef DEBUG
 
-#include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/device.h>
-#include <linux/list.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/io.h>
-#include <linux/limits.h>
-#include <linux/bitops.h>
 
 #include <plat/cpu.h>
 #include <plat/clock.h>
-#include <plat/sram.h>
-#include <plat/sdrc.h>
-#include <asm/div64.h>
-#include <asm/clkdev.h>
 
 #include "clock.h"
 #include "clock34xx.h"
-#include "sdrc.h"
 #include "prm.h"
 #include "prm-regbits-34xx.h"
 #include "cm.h"
