From: b-cousson@ti.com (Benoit Cousson)
Date: Tue, 4 Oct 2011 23:20:41 +0200
Subject: [PATCH 2/2] ARM: OMAP2+: timer: Remove omap_device_pm_latency
In-Reply-To: <1317763241-21422-1-git-send-email-b-cousson@ti.com>
References: <1317763241-21422-1-git-send-email-b-cousson@ti.com>
Message-ID: <1317763241-21422-3-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the structure since a default one is now available.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/timer.c |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index e49fc7b..037b0d7 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -408,14 +408,6 @@ static int omap2_dm_timer_set_src(struct platform_device *pdev, int source)
 	return ret;
 }
 
-struct omap_device_pm_latency omap2_dmtimer_latency[] = {
-	{
-		.deactivate_func = omap_device_idle_hwmods,
-		.activate_func   = omap_device_enable_hwmods,
-		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
-	},
-};
-
 /**
  * omap_timer_init - build and register timer device with an
  * associated timer hwmod
@@ -477,9 +469,7 @@ static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
 	pdata->get_context_loss_count = omap_pm_get_dev_context_loss_count;
 #endif
 	pdev = omap_device_build(name, id, oh, pdata, sizeof(*pdata),
-			omap2_dmtimer_latency,
-			ARRAY_SIZE(omap2_dmtimer_latency),
-			0);
+				 NULL, 0, 0);
 
 	if (IS_ERR(pdev)) {
 		pr_err("%s: Can't build omap_device for %s: %s.\n",
-- 
1.7.0.4
