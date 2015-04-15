From: dingtianhong@huawei.com (Ding Tianhong)
Date: Wed, 15 Apr 2015 20:30:03 +0800
Subject: [PATCH net-next 1/6] net: hip04: Set more appropriate value for tx
 coalesce num
In-Reply-To: <1429101008-9464-1-git-send-email-dingtianhong@huawei.com>
References: <1429101008-9464-1-git-send-email-dingtianhong@huawei.com>
Message-ID: <1429101008-9464-2-git-send-email-dingtianhong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According Arnd's suggestion, the user might set the tx coalesce value
in large range for different workloads, so we should define them to
appropriate value.

Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Joe Perches <joe@perches.com>
---
 drivers/net/ethernet/hisilicon/hip04_eth.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
index b72d238..b0a7f03 100644
--- a/drivers/net/ethernet/hisilicon/hip04_eth.c
+++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
@@ -126,10 +126,10 @@
 #define DRV_NAME			"hip04-ether"
 #define DRV_VERSION			"v1.0"
 
-#define HIP04_MAX_TX_COALESCE_USECS	200
-#define HIP04_MIN_TX_COALESCE_USECS	100
-#define HIP04_MAX_TX_COALESCE_FRAMES	200
-#define HIP04_MIN_TX_COALESCE_FRAMES	100
+#define HIP04_MAX_TX_COALESCE_USECS	100000
+#define HIP04_MIN_TX_COALESCE_USECS	1
+#define HIP04_MAX_TX_COALESCE_FRAMES	(TX_DESC_NUM - 1)
+#define HIP04_MIN_TX_COALESCE_FRAMES	1
 
 struct tx_desc {
 	u32 send_addr;
-- 
1.8.0
