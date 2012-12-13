From: tony@atomide.com (Tony Lindgren)
Date: Thu, 13 Dec 2012 13:36:41 -0800
Subject: cpts: Fix build error caused by include of plat/clock.h
Message-ID: <20121213213641.GF4989@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 87c0e764 (cpts: introduce time stamping code and a PTP hardware clock)
mistakenly included plat/clock.h that should not be included by drivers
even if it exists.

Otherwise we get the following error with at least omap2plus_defconfig:

drivers/net/ethernet/ti/cpts.c:30:24: error: plat/clock.h: No such file or directory

Signed-off-by: Tony Lindgren <tony@atomide.com

--- a/drivers/net/ethernet/ti/cpts.c
+++ b/drivers/net/ethernet/ti/cpts.c
@@ -27,8 +27,6 @@
 #include <linux/uaccess.h>
 #include <linux/workqueue.h>
 
-#include <plat/clock.h>
-
 #include "cpts.h"
 
 #ifdef CONFIG_TI_CPTS
