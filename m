From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 21 Jan 2013 12:03:51 +0000
Subject: [PATCH 15/24] ab8500-fg: Go to INIT_RECOVERY when charger removed
In-Reply-To: <1358769840-4763-1-git-send-email-lee.jones@linaro.org>
References: <1358769840-4763-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1358769840-4763-16-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Bergstr?m <martin.bergstrom@stericsson.com>

When the charger is removed we need to go to INIT_RECOVERY
state instead of directly to RECOVERY state.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Martin Bergstrom <martin.bergstrom@stericsson.com>
Reviewed-by: Marcus COOPER <marcus.xm.cooper@stericsson.com>
Reviewed-by: Jonas ABERG <jonas.aberg@stericsson.com>
Tested-by: Jonas ABERG <jonas.aberg@stericsson.com>
---
 drivers/power/ab8500_fg.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/ab8500_fg.c b/drivers/power/ab8500_fg.c
index 238eeee..0378aab 100644
--- a/drivers/power/ab8500_fg.c
+++ b/drivers/power/ab8500_fg.c
@@ -1450,7 +1450,7 @@ static void ab8500_fg_algorithm_discharging(struct ab8500_fg *di)
 
 			if (di->recovery_needed) {
 				ab8500_fg_discharge_state_to(di,
-					AB8500_FG_DISCHARGE_RECOVERY);
+					AB8500_FG_DISCHARGE_INIT_RECOVERY);
 
 				queue_delayed_work(di->fg_wq,
 					&di->fg_periodic_work, 0);
-- 
1.7.9.5
