From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 20 Apr 2016 19:49:01 +0200
Subject: [PATCH] AMBA: Drop redundant assignment of the system PM callbacks
Message-ID: <1461174541-21942-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of assigning the system PM callbacks to the pm_generic_* helpers,
we can rely on the PM core to get the same behaviour. Therefore let's drop
the assignments.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/amba/bus.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index f009936..1e4f57f 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -172,12 +172,6 @@ static int amba_pm_runtime_resume(struct device *dev)
 #endif /* CONFIG_PM */
 
 static const struct dev_pm_ops amba_pm = {
-	.suspend	= pm_generic_suspend,
-	.resume		= pm_generic_resume,
-	.freeze		= pm_generic_freeze,
-	.thaw		= pm_generic_thaw,
-	.poweroff	= pm_generic_poweroff,
-	.restore	= pm_generic_restore,
 	SET_RUNTIME_PM_OPS(
 		amba_pm_runtime_suspend,
 		amba_pm_runtime_resume,
-- 
1.9.1
