From: stigge@antcom.de (Roland Stigge)
Date: Sun,  1 Apr 2012 13:33:52 +0200
Subject: [PATCH RESEND] net: lpc_eth: Fix rename of dev_hw_addr_random
Message-ID: <1333280032-22618-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In parallel to the integration of lpc_eth.c, dev_hw_addr_random() has been
renamed to eth_hw_addr_random(). This patch fixes the resulting current compile
error in the new driver lpc_eth.c.

Signed-off-by: Roland Stigge <stigge@antcom.de>

---

 Applies to v3.4-rc1

 drivers/net/ethernet/nxp/lpc_eth.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.orig/drivers/net/ethernet/nxp/lpc_eth.c
+++ linux-2.6/drivers/net/ethernet/nxp/lpc_eth.c
@@ -1441,7 +1441,7 @@ static int lpc_eth_drv_probe(struct plat
 	}
 #endif
 	if (!is_valid_ether_addr(ndev->dev_addr))
-		dev_hw_addr_random(ndev, ndev->dev_addr);
+		eth_hw_addr_random(ndev);
 
 	/* Reset the ethernet controller */
 	__lpc_eth_reset(pldat);
