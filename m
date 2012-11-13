From: jon-hunter@ti.com (Jon Hunter)
Date: Tue, 13 Nov 2012 12:13:22 -0600
Subject: [PATCH 7/8] ARM: OMAP: Remove unnecessary inclusion of dmtimer.h
In-Reply-To: <1352830403-1706-1-git-send-email-jon-hunter@ti.com>
References: <1352830403-1706-1-git-send-email-jon-hunter@ti.com>
Message-ID: <1352830403-1706-8-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some source files are including dmtimer.h but not actually using any dmtimer
definitions or functions. Therefore, remove the inclusion dmtimer.h from these
source files.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap1/timer32k.c             |    1 -
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    1 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    1 -
 arch/arm/mach-omap2/pm-debug.c             |    1 -
 drivers/staging/tidspbridge/core/ue_deh.c  |    1 -
 5 files changed, 5 deletions(-)

diff --git a/arch/arm/mach-omap1/timer32k.c b/arch/arm/mach-omap1/timer32k.c
index 8936819..41152fa 100644
--- a/arch/arm/mach-omap1/timer32k.c
+++ b/arch/arm/mach-omap1/timer32k.c
@@ -51,7 +51,6 @@
 #include <asm/mach/time.h>
 
 #include <plat/counter-32k.h>
-#include <plat/dmtimer.h>
 
 #include <mach/hardware.h>
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index a8b3368..e8efe3d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -17,7 +17,6 @@
 #include <linux/platform_data/spi-omap2-mcspi.h>
 
 #include <plat-omap/dma-omap.h>
-#include <plat/dmtimer.h>
 
 #include "omap_hwmod.h"
 #include "l3_2xxx.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index dc768c5..32d17e3 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -18,7 +18,6 @@
 #include <linux/platform_data/spi-omap2-mcspi.h>
 
 #include <plat-omap/dma-omap.h>
-#include <plat/dmtimer.h>
 
 #include "omap_hwmod.h"
 #include "mmc.h"
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 3cf4fdf..e2c291f 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -30,7 +30,6 @@
 #include "clock.h"
 #include "powerdomain.h"
 #include "clockdomain.h"
-#include <plat/dmtimer.h>
 #include "omap-pm.h"
 
 #include "soc.h"
diff --git a/drivers/staging/tidspbridge/core/ue_deh.c b/drivers/staging/tidspbridge/core/ue_deh.c
index 3d28b23..6aea6f1 100644
--- a/drivers/staging/tidspbridge/core/ue_deh.c
+++ b/drivers/staging/tidspbridge/core/ue_deh.c
@@ -19,7 +19,6 @@
 
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
-#include <plat/dmtimer.h>
 
 #include <dspbridge/dbdefs.h>
 #include <dspbridge/dspdeh.h>
-- 
1.7.9.5
