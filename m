From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 12 May 2015 17:37:38 +0200
Subject: [PATCH 3/8] dmaengine: mv_xor: Enlarge descriptor pool size
In-Reply-To: <1431445063-20226-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1431445063-20226-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1431445063-20226-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lior Amsalem <alior@marvell.com>

Now that we have 2 channels assigned to 2 CPUs and all requests are chained
on same channels, we need much more descriptors available to satisfy
async_tx workload.

3072 descriptors was found in our lab as the number of descriptors which
allow the async_tx stack to work without waiting for free descriptors on
submission of new requests.

Signed-off-by: Lior Amsalem <alior@marvell.com>
Reviewed-by: Nadav Haklai <nadavh@marvell.com>
Tested-by: Nadav Haklai <nadavh@marvell.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/dma/mv_xor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/mv_xor.h b/drivers/dma/mv_xor.h
index 89a8c85539a1..145ba2f895f7 100644
--- a/drivers/dma/mv_xor.h
+++ b/drivers/dma/mv_xor.h
@@ -19,7 +19,7 @@
 #include <linux/dmaengine.h>
 #include <linux/interrupt.h>
 
-#define MV_XOR_POOL_SIZE		PAGE_SIZE
+#define MV_XOR_POOL_SIZE		(MV_XOR_SLOT_SIZE * 3072)
 #define MV_XOR_SLOT_SIZE		64
 #define MV_XOR_THRESHOLD		1
 #define MV_XOR_MAX_CHANNELS             2
-- 
2.4.0
