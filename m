From: dingtianhong@huawei.com (Ding Tianhong)
Date: Wed, 15 Apr 2015 20:30:07 +0800
Subject: [PATCH net-next 5/6] net: hip04: remove the unnecessary check
In-Reply-To: <1429101008-9464-1-git-send-email-dingtianhong@huawei.com>
References: <1429101008-9464-1-git-send-email-dingtianhong@huawei.com>
Message-ID: <1429101008-9464-6-git-send-email-dingtianhong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Testing bytes_compl should be enough, because there is no way
that pkt_compl could be 0 if bytes_compl is not 0.

Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Joe Perches <joe@perches.com>
---
 drivers/net/ethernet/hisilicon/hip04_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
index ff9d19c..a7ab1d9 100644
--- a/drivers/net/ethernet/hisilicon/hip04_eth.c
+++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
@@ -440,7 +440,7 @@ static int hip04_tx_reclaim(struct net_device *ndev, bool force)
 	smp_wmb(); /* Ensure tx_tail visible to xmit */
 
 out:
-	if (pkts_compl || bytes_compl)
+	if (bytes_compl)
 		netdev_completed_queue(ndev, pkts_compl, bytes_compl);
 
 	if (unlikely(netif_queue_stopped(ndev)) && (count < (TX_DESC_NUM - 1)))
-- 
1.8.0
