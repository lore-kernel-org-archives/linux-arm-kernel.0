From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 15 Dec 2015 15:16:06 +0100
Subject: [PATCH] soc: mediatek: SCPSYS: use module_platform_driver
Message-ID: <1450188966-2921-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With regulator support to the scpsys driver needs to be able to defer
probe. Probe deferral is incompatible with module_platform_driver_probe,
so use -module_platform_driver.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/soc/mediatek/mtk-scpsys.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index e425619..e6752749 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -542,6 +542,7 @@ static const struct of_device_id of_scpsys_match_tbl[] = {
 };
 
 static struct platform_driver scpsys_drv = {
+	.probe = scpsys_probe,
 	.driver = {
 		.name = "mtk-scpsys",
 		.owner = THIS_MODULE,
@@ -549,4 +550,4 @@ static struct platform_driver scpsys_drv = {
 	},
 };
 
-module_platform_driver_probe(scpsys_drv, scpsys_probe);
+module_platform_driver(scpsys_drv);
-- 
2.6.2
