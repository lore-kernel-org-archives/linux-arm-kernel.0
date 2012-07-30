From: ian.molton@codethink.co.uk (Ian Molton)
Date: Mon, 30 Jul 2012 16:15:55 +0100
Subject: [PATCH 2/6] mv643xx.c: Remove magic numbers.
In-Reply-To: <1343661359-10150-1-git-send-email-ian.molton@codethink.co.uk>
References: <1343661359-10150-1-git-send-email-ian.molton@codethink.co.uk>
Message-ID: <1343661359-10150-3-git-send-email-ian.molton@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

replace magic number with RX_CSUM_WITH_HEADER.

Signed-off-by: Ian Molton <ian.molton@codethink.co.uk>
---
 drivers/net/ethernet/marvell/mv643xx_eth.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 4fbba57..92497eb 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -86,6 +86,7 @@ static char mv643xx_eth_driver_version[] = "1.4";
  * port #0, 0x0800 for port #1, and 0x0c00 for port #2.
  */
 #define PORT_CONFIG			0x0000
+#define  RX_CSUM_WITH_HEADER		0x02000000
 #define  UNICAST_PROMISCUOUS_MODE	0x00000001
 #define PORT_CONFIG_EXT			0x0004
 #define MAC_ADDR_LOW			0x0014
@@ -1607,7 +1608,7 @@ mv643xx_eth_set_features(struct net_device *dev, netdev_features_t features)
 	struct mv643xx_eth_private *mp = netdev_priv(dev);
 	bool rx_csum = features & NETIF_F_RXCSUM;
 
-	wrlp(mp, PORT_CONFIG, rx_csum ? 0x02000000 : 0x00000000);
+	wrlp(mp, PORT_CONFIG, rx_csum ? RX_CSUM_WITH_HEADER : 0x00000000);
 
 	return 0;
 }
-- 
1.7.9.5
