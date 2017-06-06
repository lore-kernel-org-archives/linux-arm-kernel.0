From: ruxandra.radulescu@nxp.com (Ioana Radulescu)
Date: Tue, 6 Jun 2017 10:00:26 -0500
Subject: [PATCH 03/18] staging: fsl-dpaa2/eth: Fix return type of
 ndo_start_xmit
In-Reply-To: <20170606150041.10955-1-ruxandra.radulescu@nxp.com>
References: <20170606150041.10955-1-ruxandra.radulescu@nxp.com>
Message-ID: <20170606150041.10955-4-ruxandra.radulescu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ndo_start_xmit() returns a value of type netdev_tx_t. Update
our ndo function to use the correct type.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index f0ef3a7c0f73..a9e245df2488 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -551,7 +551,7 @@ static void free_tx_fd(const struct dpaa2_eth_priv *priv,
 	dev_kfree_skb(skb);
 }
 
-static int dpaa2_eth_tx(struct sk_buff *skb, struct net_device *net_dev)
+static netdev_tx_t dpaa2_eth_tx(struct sk_buff *skb, struct net_device *net_dev)
 {
 	struct dpaa2_eth_priv *priv = netdev_priv(net_dev);
 	struct dpaa2_fd fd;
-- 
2.11.0
