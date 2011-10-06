From: vjaquez@igalia.com (=?UTF-8?q?V=C3=ADctor=20Manuel=20J=C3=A1quez=20Leal?=)
Date: Thu,  6 Oct 2011 12:48:23 +0200
Subject: [PATCH] omap: dmtimer: convert printk to pr_*
Message-ID: <1317898106-1891-1-git-send-email-vjaquez@igalia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert all the printk(<level>) messages in the driver to pr_<level>().

Signed-off-by: V?ctor Manuel J?quez Leal <vjaquez@igalia.com>
---
 arch/arm/plat-omap/dmtimer.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index ee9f6eb..34384b0 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -322,7 +322,7 @@ static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *timer)
 	while (!(omap_dm_timer_read_reg(timer, OMAP_TIMER_SYS_STAT_REG) & 1)) {
 		c++;
 		if (c > 100000) {
-			printk(KERN_ERR "Timer failed to reset\n");
+			pr_err("Timer failed to reset\n");
 			return;
 		}
 	}
@@ -397,8 +397,7 @@ struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 	spin_lock_irqsave(&dm_timer_lock, flags);
 	if (id <= 0 || id > dm_timer_count || dm_timers[id-1].reserved) {
 		spin_unlock_irqrestore(&dm_timer_lock, flags);
-		printk("BUG: warning at %s:%d/%s(): unable to get timer %d\n",
-		       __FILE__, __LINE__, __func__, id);
+		pr_warning("unable to get timer %d\n", id);
 		dump_stack();
 		return NULL;
 	}
-- 
1.7.6.3
