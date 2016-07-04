From: arnd@arndb.de (Arnd Bergmann)
Date: Mon,  4 Jul 2016 15:19:41 +0200
Subject: [PATCH net-next] lpc_eth: remove unused variable
Message-ID: <20160704132018.1130907-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A cleanup patch removed the only user of a local variable, as
indicated by a gcc warning.

drivers/net/ethernet/nxp/lpc_eth.c: In function 'lpc_eth_ioctl':
drivers/net/ethernet/nxp/lpc_eth.c:1183:24: error: unused variable 'pldat' [-Werror=unused-variable]

This removes the variable as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: f786f3564c4f ("net: ethernet: lpc_eth: use phydev from struct net_device")
---
 drivers/net/ethernet/nxp/lpc_eth.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/nxp/lpc_eth.c b/drivers/net/ethernet/nxp/lpc_eth.c
index ad5464fa8ac7..660d113f8b9a 100644
--- a/drivers/net/ethernet/nxp/lpc_eth.c
+++ b/drivers/net/ethernet/nxp/lpc_eth.c
@@ -1180,7 +1180,6 @@ static void lpc_eth_set_multicast_list(struct net_device *ndev)
 
 static int lpc_eth_ioctl(struct net_device *ndev, struct ifreq *req, int cmd)
 {
-	struct netdata_local *pldat = netdev_priv(ndev);
 	struct phy_device *phydev = ndev->phydev;
 
 	if (!netif_running(ndev))
-- 
2.9.0
