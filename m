From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 May 2015 15:07:35 +0200
Subject: [PATCH v2 4/5] dmaengine: mv_xor: Enlarge descriptor pool size
In-Reply-To: <1432645656-20504-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1432645656-20504-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1432645656-20504-5-git-send-email-maxime.ripard@free-electrons.com>
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
index ac1ce87935de..6b10c8c647b9 100644
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
2.4.1
