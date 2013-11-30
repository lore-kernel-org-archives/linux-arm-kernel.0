From: gsi@denx.de (Gerhard Sittig)
Date: Sat, 30 Nov 2013 23:51:33 +0100
Subject: [PATCH v6 13/17] [media] fsl-viu: adjust for OF based clock lookup
In-Reply-To: <1385851897-23475-1-git-send-email-gsi@denx.de>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
Message-ID: <1385851897-23475-14-git-send-email-gsi@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

after device tree based clock lookup became available, the VIU driver
need no longer use the previous global "viu_clk" name, but should use
the "ipg" clock name specific to the OF node

Cc: Mauro Carvalho Chehab <m.chehab@samsung.com>
Cc: linux-media at vger.kernel.org
Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/media/platform/fsl-viu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/fsl-viu.c b/drivers/media/platform/fsl-viu.c
index 6a232239ee8c..dbf0ce38a8e7 100644
--- a/drivers/media/platform/fsl-viu.c
+++ b/drivers/media/platform/fsl-viu.c
@@ -1580,7 +1580,7 @@ static int viu_of_probe(struct platform_device *op)
 	}
 
 	/* enable VIU clock */
-	clk = devm_clk_get(&op->dev, "viu_clk");
+	clk = devm_clk_get(&op->dev, "ipg");
 	if (IS_ERR(clk)) {
 		dev_err(&op->dev, "failed to lookup the clock!\n");
 		ret = PTR_ERR(clk);
-- 
1.7.10.4
