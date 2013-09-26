From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Thu, 26 Sep 2013 19:18:15 +0530
Subject: [PATCH] clk: wm831x: get rid of the implementation of remove function
Message-ID: <1380203295-11030-1-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The remove function implemented for platform driver's remove callback
just return 0 as part of its implementation.

Remove this APIs and do not pass the valid .remove for platform driver.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
I was referring this driver for clock driver implementation for Palma and
realise that this remove function can be removed.
This is just outcome of code reading.

 drivers/clk/clk-wm831x.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk-wm831x.c b/drivers/clk/clk-wm831x.c
index 805b4c3..b131041 100644
--- a/drivers/clk/clk-wm831x.c
+++ b/drivers/clk/clk-wm831x.c
@@ -391,14 +391,8 @@ static int wm831x_clk_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int wm831x_clk_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
 static struct platform_driver wm831x_clk_driver = {
 	.probe = wm831x_clk_probe,
-	.remove = wm831x_clk_remove,
 	.driver		= {
 		.name	= "wm831x-clk",
 		.owner	= THIS_MODULE,
-- 
1.7.1.1
