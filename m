From: joelf@ti.com (Joel Fernandes)
Date: Tue, 22 Apr 2014 20:27:07 -0500
Subject: [PATCH 6/8] ARM: OMAP2+: timer: Fix error message to not use hwmod
 structure
In-Reply-To: <1398216429-4681-1-git-send-email-joelf@ti.com>
References: <1398216429-4681-1-git-send-email-joelf@ti.com>
Message-ID: <1398216429-4681-7-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

oh->name is no longer used, correct the error message.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/mach-omap2/timer.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 4fcfd7a..519ccfd 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -331,8 +331,8 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 	if (clk_get_parent(timer->fclk) != src) {
 		r = clk_set_parent(timer->fclk, src);
 		if (r < 0) {
-			pr_warn("%s: %s cannot set source\n", __func__,
-				oh->name);
+			pr_warn("%s: cannot set timer's source\n", __func__);
+			WARN_ON(1);
 			clk_put(src);
 			return r;
 		}
-- 
1.7.9.5
