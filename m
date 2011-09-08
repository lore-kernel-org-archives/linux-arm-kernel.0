From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Fri, 9 Sep 2011 02:38:08 +0530
Subject: [PATCH v15 02/12] OMAP4: hwmod data: add dmtimer version information
In-Reply-To: <1315516098-29761-1-git-send-email-tarun.kanti@ti.com>
References: <1315516098-29761-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <1315516098-29761-3-git-send-email-tarun.kanti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP4 has two groups of timers: version 1 timers are 1, 2, 10,
while the rest of the timers, 3-9, 11 are version 2 timers.
The version information is required by the driver so that they
could be handled correctly by it.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Cousson, Benoit <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 +++
 arch/arm/plat-omap/include/plat/dmtimer.h  |    4 +++-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 6201422..2010a7b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -29,6 +29,7 @@
 #include <plat/mcbsp.h>
 #include <plat/mmc.h>
 #include <plat/i2c.h>
+#include <plat/dmtimer.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -4248,6 +4249,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_timer_1ms_sysc = {
 static struct omap_hwmod_class omap44xx_timer_1ms_hwmod_class = {
 	.name	= "timer",
 	.sysc	= &omap44xx_timer_1ms_sysc,
+	.rev    = OMAP_TIMER_IP_VERSION_1,
 };
 
 static struct omap_hwmod_class_sysconfig omap44xx_timer_sysc = {
@@ -4263,6 +4265,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_timer_sysc = {
 static struct omap_hwmod_class omap44xx_timer_hwmod_class = {
 	.name	= "timer",
 	.sysc	= &omap44xx_timer_sysc,
+	.rev    = OMAP_TIMER_IP_VERSION_2,
 };
 
 /* timer1 */
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index eb5d16c..37efa15 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -58,7 +58,9 @@
  * IP revision identifier so that Highlander IP
  * in OMAP4 can be distinguished.
  */
-#define OMAP_TIMER_IP_VERSION_1                        0x1
+#define OMAP_TIMER_IP_VERSION_1			0x1
+#define OMAP_TIMER_IP_VERSION_2			0x2
+
 struct omap_dm_timer;
 struct clk;
 
-- 
1.7.0.4
