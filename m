From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 3 Dec 2014 14:43:14 +0100
Subject: [PATCH] mmc: atmel-mci: use SET_RUNTIME_PM_OPS() macro
Message-ID: <1417614194-28409-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use SET_RUNTIME_PM_OPS() since SET_PM_RUNTIME_PM_OPS() has been dropped.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---

Hi Ulf,

Can you take this patch which fixes a compilation error that has appeared only
on next-20141203.

Thanks

Regards

 drivers/mmc/host/atmel-mci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 62aba9a..03d7c75 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2561,7 +2561,7 @@ static int atmci_runtime_resume(struct device *dev)
 static const struct dev_pm_ops atmci_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
 				pm_runtime_force_resume)
-	SET_PM_RUNTIME_PM_OPS(atmci_runtime_suspend, atmci_runtime_resume, NULL)
+	SET_RUNTIME_PM_OPS(atmci_runtime_suspend, atmci_runtime_resume, NULL)
 };
 
 static struct platform_driver atmci_driver = {
-- 
2.0.3
