From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 20 Feb 2013 20:48:42 +0530
Subject: [PATCH 4/9] ARM: OMAP4+: Remove the un-necessary cache flush from
 hotplug code
In-Reply-To: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1361373527-21695-5-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was added with intial port where OMAP PM support wasn't existing
and only simple WFI based hooks were used.

This should have been cleaned up while adding the PM support but some
how fall through cracks.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-hotplug.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-hotplug.c b/arch/arm/mach-omap2/omap-hotplug.c
index e712d17..458f72f 100644
--- a/arch/arm/mach-omap2/omap-hotplug.c
+++ b/arch/arm/mach-omap2/omap-hotplug.c
@@ -19,11 +19,8 @@
 #include <linux/smp.h>
 #include <linux/io.h>
 
-#include <asm/cacheflush.h>
 #include "omap-wakeupgen.h"
-
 #include "common.h"
-
 #include "powerdomain.h"
 
 /*
@@ -35,9 +32,6 @@ void __ref omap4_cpu_die(unsigned int cpu)
 	unsigned int boot_cpu = 0;
 	void __iomem *base = omap_get_wakeupgen_base();
 
-	flush_cache_all();
-	dsb();
-
 	/*
 	 * we're ready for shutdown now, so do it
 	 */
-- 
1.7.9.5
