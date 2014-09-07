From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun,  7 Sep 2014 19:19:32 +0200
Subject: [PATCH v6 4/7] net: cpsw: Replace pr_err by dev_err
In-Reply-To: <1410110375-3570-1-git-send-email-mpa@pengutronix.de>
References: <1410110375-3570-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1410110375-3570-5-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use dev_err instead of pr_err.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Reviewed-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/net/ethernet/ti/cpsw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index f09b4639ad31..0bc2c2a2c236 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1921,7 +1921,7 @@ static int cpsw_probe_dt(struct cpsw_platform_data *data,
 		mdio = of_find_device_by_node(mdio_node);
 		of_node_put(mdio_node);
 		if (!mdio) {
-			pr_err("Missing mdio platform device\n");
+			dev_err(&pdev->dev, "Missing mdio platform device\n");
 			return -EINVAL;
 		}
 		snprintf(slave_data->phy_id, sizeof(slave_data->phy_id),
-- 
2.1.0
