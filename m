From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Thu, 26 Apr 2018 23:13:38 +0200
Subject: [PATCH 3/3] can: xilinx: fix xcan_start_xmit()'s return type
In-Reply-To: <20180426211339.30821-1-luc.vanoostenryck@gmail.com>
References: <20180426211339.30821-1-luc.vanoostenryck@gmail.com>
Message-ID: <20180426211339.30821-4-luc.vanoostenryck@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, but the implementation in this
driver returns an 'int'.

Fix this by returning 'netdev_tx_t' in this driver too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/net/can/xilinx_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 89aec07c2..a19648606 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -386,7 +386,7 @@ static int xcan_do_set_mode(struct net_device *ndev, enum can_mode mode)
  *
  * Return: 0 on success and failure value on error
  */
-static int xcan_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t xcan_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct xcan_priv *priv = netdev_priv(ndev);
 	struct net_device_stats *stats = &ndev->stats;
-- 
2.17.0
