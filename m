From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 23 Apr 2012 11:23:33 +0200
Subject: [PATCH 01/10] mtd: mxc_nand: set owner field to prevent module
 unloading when in use
In-Reply-To: <20120423092240.GA18013@pengutronix.de>
References: <20120423092240.GA18013@pengutronix.de>
Message-ID: <1335173022-22371-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/mtd/nand/mxc_nand.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index cc0678a..7d82cc4 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -1275,6 +1275,7 @@ static int __devexit mxcnd_remove(struct platform_device *pdev)
 static struct platform_driver mxcnd_driver = {
 	.driver = {
 		   .name = DRIVER_NAME,
+		   .owner = THIS_MODULE,
 	},
 	.remove = __devexit_p(mxcnd_remove),
 };
-- 
1.7.10
