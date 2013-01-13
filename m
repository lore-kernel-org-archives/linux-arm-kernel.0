From: linux@prisktech.co.nz (Tony Prisk)
Date: Sun, 13 Jan 2013 19:19:20 +1300
Subject: [PATCH] mmc: vt8500: Remove erroneous __exitp in wmt_mci_driver
Message-ID: <1358057960-24540-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the __devinit/__devexit attributes having been removed, this
__exitp attribute causes an unused function warning and should be
removed as well.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 drivers/mmc/host/wmt-sdmmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index 154f0e8..c6d0015 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -1012,7 +1012,7 @@ static const struct dev_pm_ops wmt_mci_pm = {
 
 static struct platform_driver wmt_mci_driver = {
 	.probe = wmt_mci_probe,
-	.remove = __exit_p(wmt_mci_remove),
+	.remove = wmt_mci_remove,
 	.driver = {
 		.name = DRIVER_NAME,
 		.owner = THIS_MODULE,
-- 
1.7.9.5
