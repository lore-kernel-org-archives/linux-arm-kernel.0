From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Tue, 24 Apr 2018 15:16:41 +0200
Subject: [PATCH] net: gemini: fix gmac_start_xmit()'s return type
Message-ID: <20180424131642.3806-1-luc.vanoostenryck@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, but the implementation in this
driver returns an 'int'.

Fix this by returning 'netdev_tx_t' in this driver too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/net/ethernet/cortina/gemini.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index bd3f6e4d1..564b9ceb1 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1188,7 +1188,7 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	return -ENOMEM;
 }
 
-static int gmac_start_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t gmac_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	unsigned short m = (1 << port->txq_order) - 1;
-- 
2.17.0
