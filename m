From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 21 Dec 2014 22:14:27 +0100
Subject: [PATCH 06/28] dma: drop owner assignment from platform_drivers
In-Reply-To: <1419196495-9626-1-git-send-email-wsa@the-dreams.de>
References: <1419196495-9626-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1419196495-9626-7-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This platform_driver does not need to set an owner, it will be populated by the
driver core.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
Generated with coccinelle. SmPL file is in the introductory msg. The big
cleanup was pulled in this merge window. This series catches the bits fallen
through. The patches shall go in via the subsystem trees.

 drivers/dma/at_xdmac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index b60d77a22df6..1c4c96b7e2bf 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1507,7 +1507,6 @@ static struct platform_driver at_xdmac_driver = {
 	.remove		= at_xdmac_remove,
 	.driver = {
 		.name		= "at_xdmac",
-		.owner		= THIS_MODULE,
 		.of_match_table	= of_match_ptr(atmel_xdmac_dt_ids),
 		.pm		= &atmel_xdmac_dev_pm_ops,
 	}
-- 
2.1.3
