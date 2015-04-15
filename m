From: dingtianhong@huawei.com (Ding Tianhong)
Date: Wed, 15 Apr 2015 20:30:04 +0800
Subject: [PATCH net-next 2/6] net: hip04: use the big endian for tx and rx desc
In-Reply-To: <1429101008-9464-1-git-send-email-dingtianhong@huawei.com>
References: <1429101008-9464-1-git-send-email-dingtianhong@huawei.com>
Message-ID: <1429101008-9464-3-git-send-email-dingtianhong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The hip04 ethernet use the big endian for tx and rx, so set desc to
big endian and remove the unused next_addr.

Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Joe Perches <joe@perches.com>
---
 drivers/net/ethernet/hisilicon/hip04_eth.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
index b0a7f03..6473462 100644
--- a/drivers/net/ethernet/hisilicon/hip04_eth.c
+++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
@@ -132,19 +132,18 @@
 #define HIP04_MIN_TX_COALESCE_FRAMES	1
 
 struct tx_desc {
-	u32 send_addr;
-	u32 send_size;
-	u32 next_addr;
-	u32 cfg;
-	u32 wb_addr;
+	__be32 send_addr;
+	__be32 send_size;
+	__be32 cfg;
+	__be32 wb_addr;
 } __aligned(64);
 
 struct rx_desc {
-	u16 reserved_16;
-	u16 pkt_len;
-	u32 reserve1[3];
-	u32 pkt_err;
-	u32 reserve2[4];
+	__be16 reserved_16;
+	__be16 pkt_len;
+	__be32 reserve1[3];
+	__be32 pkt_err;
+	__be32 reserve2[4];
 };
 
 struct hip04_priv {
-- 
1.8.0
