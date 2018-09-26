From: yuehaibing@huawei.com (YueHaibing)
Date: Wed, 26 Sep 2018 18:32:29 +0800
Subject: [PATCH net-next] can: xilinx: fix return type of ndo_start_xmit
 function
Message-ID: <20180926103229.13204-1-yuehaibing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, so make sure the implementation in
this driver has returns 'netdev_tx_t' value, and change the function
return type to netdev_tx_t.

Found by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/can/xilinx_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 045f084..6de5004 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -612,7 +612,7 @@ static int xcan_start_xmit_mailbox(struct sk_buff *skb, struct net_device *ndev)
  *
  * Return: NETDEV_TX_OK on success and NETDEV_TX_BUSY when the tx queue is full
  */
-static int xcan_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t xcan_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct xcan_priv *priv = netdev_priv(ndev);
 	int ret;
-- 
1.8.3.1
