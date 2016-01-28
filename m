From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 28 Jan 2016 14:25:42 -0700
Subject: [PATCH net-next 18/40] net: fec: clear cbd_sc after transmission to
 help with debugging
In-Reply-To: <1454016364-30985-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1454016364-30985-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1454016364-30985-19-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the tx queue is dumped, it is easier to see that this
entry is idle.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index fcbbf0d..1759705 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1161,6 +1161,7 @@ static void fec_txq(struct net_device *ndev, struct fec_enet_private *fep,
 			}
 			break;
 		}
+		bdp->cbd_sc = (bdp == txq->bd.last) ? BD_SC_WRAP : 0;
 
 		index = fec_enet_get_bd_index(bdp, &txq->bd);
 
-- 
2.5.0
