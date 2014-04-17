From: joelf@ti.com (Joel Fernandes)
Date: Wed, 16 Apr 2014 19:03:12 -0500
Subject: [PATCH 2/9] ARM: OMAP: dmtimer: Add comments on OMAP1 clock framework
In-Reply-To: <1397692999-7800-1-git-send-email-joelf@ti.com>
References: <1397692999-7800-1-git-send-email-joelf@ti.com>
Message-ID: <1397692999-7800-2-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP1 doesn't support clock framework, add a comment where needed
and correct a FIXME.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index ecd3f97..f5a674c 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -142,8 +142,7 @@ static int omap_dm_timer_prepare(struct omap_dm_timer *timer)
 	int rc;
 
 	/*
-	 * FIXME: OMAP1 devices do not use the clock framework for dmtimers so
-	 * do not call clk_get() for these devices.
+	 * Do not call clk_get() for OMAP1 due to no clock framework support.
 	 */
 	if (!(timer->capability & OMAP_TIMER_NEEDS_RESET)) {
 		timer->fclk = clk_get(&timer->pdev->dev, "fck");
@@ -461,6 +460,7 @@ int omap_dm_timer_stop(struct omap_dm_timer *timer)
 	if (unlikely(!timer))
 		return -EINVAL;
 
+	/* OMAP1 is not converted to clk framework so avoid clk_get_rate here */
 	if (!(timer->capability & OMAP_TIMER_NEEDS_RESET))
 		rate = clk_get_rate(timer->fclk);
 
-- 
1.7.9.5
