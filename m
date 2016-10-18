From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Mon, 17 Oct 2016 18:43:37 -0600
Subject: [PATCH] media: s5p-mfc include buffer size in error message
Message-ID: <20161018004337.26831-1-shuahkh@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include buffer size in s5p_mfc_alloc_priv_buf() the error message when it
fails to allocate the buffer. Remove the debug message that does the same.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/media/platform/s5p-mfc/s5p_mfc_opr.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_opr.c b/drivers/media/platform/s5p-mfc/s5p_mfc_opr.c
index 1e72502..eee16a1 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_opr.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_opr.c
@@ -40,12 +40,11 @@ void s5p_mfc_init_regs(struct s5p_mfc_dev *dev)
 int s5p_mfc_alloc_priv_buf(struct device *dev, dma_addr_t base,
 					struct s5p_mfc_priv_buf *b)
 {
-	mfc_debug(3, "Allocating priv: %zu\n", b->size);
-
 	b->virt = dma_alloc_coherent(dev, b->size, &b->dma, GFP_KERNEL);
 
 	if (!b->virt) {
-		mfc_err("Allocating private buffer failed\n");
+		mfc_err("Allocating private buffer of size %zu failed\n",
+			b->size);
 		return -ENOMEM;
 	}
 
-- 
2.7.4
