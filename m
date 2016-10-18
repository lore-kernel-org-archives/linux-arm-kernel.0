From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Tue, 18 Oct 2016 17:28:22 -0600
Subject: [PATCH] media: s5p-mfc collapse two error message into one
Message-ID: <20161018232822.17423-1-shuahkh@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s5p_mfc_alloc_priv_buf() prints two message to report invalid memory
configuration error. Collapse them into a single message.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/media/platform/s5p-mfc/s5p_mfc_opr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_opr.c b/drivers/media/platform/s5p-mfc/s5p_mfc_opr.c
index eee16a1..44d2325 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_opr.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_opr.c
@@ -49,8 +49,7 @@ int s5p_mfc_alloc_priv_buf(struct device *dev, dma_addr_t base,
 	}
 
 	if (b->dma < base) {
-		mfc_err("Invaling memory configuration!\n");
-		mfc_err("Allocated buffer (%pad) is lower than memory base address (%pad)\n",
+		mfc_err("Invalid memory configuration - buffer (%pad) is below base memory address(%pad)\n",
 			&b->dma, &base);
 		dma_free_coherent(dev, b->size, b->virt, b->dma);
 		return -ENOMEM;
-- 
2.7.4
