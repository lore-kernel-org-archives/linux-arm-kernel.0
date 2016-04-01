From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 1 Apr 2016 17:12:49 +0800
Subject: [PATCH] net: mvneta: use cache_line_size() to get cacheline size
Message-ID: <1459501969-7083-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

L1_CACHE_BYTES may not be the real cacheline size, use cache_line_size
to determine the cacheline size in runtime.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Suggested-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 5880871..b1db000 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -299,7 +299,7 @@
 #define MVNETA_RX_PKT_SIZE(mtu) \
 	ALIGN((mtu) + MVNETA_MH_SIZE + MVNETA_VLAN_TAG_LEN + \
 	      ETH_HLEN + ETH_FCS_LEN,			     \
-	      L1_CACHE_BYTES)
+	      cache_line_size())
 
 #define IS_TSO_HEADER(txq, addr) \
 	((addr >= txq->tso_hdrs_phys) && \
-- 
2.8.0.rc3
