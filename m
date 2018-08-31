From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Fri, 31 Aug 2018 16:10:03 +0800
Subject: [PATCH net-next v2 2/3] net: mvneta: enable NETIF_F_RXCSUM by default
In-Reply-To: <20180831160810.2539ef4c@xhacker.debian>
References: <20180831160810.2539ef4c@xhacker.debian>
Message-ID: <20180831161003.3f0dc351@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code and HW supports NETIF_F_RXCSUM, so let's enable it by default.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 814aee92a1d3..bcd20ebb2ebd 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -4595,7 +4595,8 @@ static int mvneta_probe(struct platform_device *pdev)
 		}
 	}
 
-	dev->features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | NETIF_F_TSO;
+	dev->features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
+			NETIF_F_TSO | NETIF_F_RXCSUM;
 	dev->hw_features |= dev->features;
 	dev->vlan_features |= dev->features;
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
-- 
2.18.0
