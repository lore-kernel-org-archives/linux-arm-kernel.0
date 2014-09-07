From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun,  7 Sep 2014 19:19:30 +0200
Subject: [PATCH v6 2/7] net: cpsw: Add missing return value
In-Reply-To: <1410110375-3570-1-git-send-email-mpa@pengutronix.de>
References: <1410110375-3570-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1410110375-3570-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ret is set 0 at this point, so jumping to that error label would result
in a return value of 0. Set ret to -ENOMEM to return a proper error
value.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Reviewed-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/net/ethernet/ti/cpsw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 999fb72688d2..f09b4639ad31 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -2063,6 +2063,7 @@ static int cpsw_probe(struct platform_device *pdev)
 	priv->irq_enabled = true;
 	if (!priv->cpts) {
 		dev_err(&pdev->dev, "error allocating cpts\n");
+		ret = -ENOMEM;
 		goto clean_ndev_ret;
 	}
 
-- 
2.1.0
