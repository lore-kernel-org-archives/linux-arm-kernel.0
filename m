From: xypron.glpk@gmx.de (Heinrich Schuchardt)
Date: Sun, 31 Jul 2016 10:24:29 +0200
Subject: [PATCH 1/1] net: bcm63xx: avoid possible null pointer dereference
Message-ID: <1469953469-20782-1-git-send-email-xypron.glpk@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If dev_get_platdata has failed pd is null.
Do not dereference a null pointer.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 drivers/net/ethernet/broadcom/bcm63xx_enet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
index 87c6b5b..6c8bc5f 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -1859,7 +1859,7 @@ static int bcm_enet_probe(struct platform_device *pdev)
 	} else {
 
 		/* run platform code to initialize PHY device */
-		if (pd->mii_config &&
+		if (pd && pd->mii_config &&
 		    pd->mii_config(dev, 1, bcm_enet_mdio_read_mii,
 				   bcm_enet_mdio_write_mii)) {
 			dev_err(&pdev->dev, "unable to configure mdio bus\n");
-- 
2.8.1
