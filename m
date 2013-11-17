From: gsi@denx.de (Gerhard Sittig)
Date: Mon, 18 Nov 2013 00:06:13 +0100
Subject: [PATCH v5 13/17] [media] fsl-viu: adjust for OF based clock lookup
In-Reply-To: <1384729577-7336-1-git-send-email-gsi@denx.de>
References: <1384729577-7336-1-git-send-email-gsi@denx.de>
Message-ID: <1384729577-7336-14-git-send-email-gsi@denx.de>
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
index fe9898ca3c84..c1e84aeb2e25 100644
--- a/drivers/media/platform/fsl-viu.c
+++ b/drivers/media/platform/fsl-viu.c
@@ -1578,7 +1578,7 @@ static int viu_of_probe(struct platform_device *op)
 	}
 
 	/* enable VIU clock */
-	clk = devm_clk_get(&op->dev, "viu_clk");
+	clk = devm_clk_get(&op->dev, "ipg");
 	if (IS_ERR(clk)) {
 		dev_err(&op->dev, "failed to lookup the clock!\n");
 		ret = PTR_ERR(clk);
-- 
1.7.10.4
