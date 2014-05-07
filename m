From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed,  7 May 2014 11:03:57 +0200
Subject: [PATCH] dma: ste_dma40: Convert to the late system PM callbacks
Message-ID: <1399453437-24195-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clients may still be active in the early phase of system PM, thus we
need to move the suspend operations to the late system PM phase.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/dma/ste_dma40.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index b539fc9..c798445 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3051,7 +3051,7 @@ static int dma40_runtime_resume(struct device *dev)
 #endif
 
 static const struct dev_pm_ops dma40_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(dma40_suspend, dma40_resume)
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(dma40_suspend, dma40_resume)
 	SET_PM_RUNTIME_PM_OPS(dma40_runtime_suspend,
 				dma40_runtime_resume,
 				NULL)
-- 
1.7.9.5
