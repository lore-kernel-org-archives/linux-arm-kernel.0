From: yuehaibing@huawei.com (YueHaibing)
Date: Thu, 20 Sep 2018 20:33:04 +0800
Subject: [PATCH net-next 20/22] rionet: fix return type of ndo_start_xmit
 function
In-Reply-To: <20180920123306.14772-1-yuehaibing@huawei.com>
References: <20180920123306.14772-1-yuehaibing@huawei.com>
Message-ID: <20180920123306.14772-21-yuehaibing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, so make sure the implementation in
this driver has returns 'netdev_tx_t' value, and change the function
return type to netdev_tx_t.

Found by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/rionet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/rionet.c b/drivers/net/rionet.c
index e9f101c..de391c7 100644
--- a/drivers/net/rionet.c
+++ b/drivers/net/rionet.c
@@ -170,7 +170,8 @@ static int rionet_queue_tx_msg(struct sk_buff *skb, struct net_device *ndev,
 	return 0;
 }
 
-static int rionet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t
+rionet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	int i;
 	struct rionet_private *rnet = netdev_priv(ndev);
-- 
1.8.3.1
