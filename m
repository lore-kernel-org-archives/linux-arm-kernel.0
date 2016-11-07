From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Mon,  7 Nov 2016 16:39:25 -0700
Subject: [PATCH v2] media: s5p-mfc include buffer size in error message
Message-ID: <20161107233925.25070-1-shuahkh@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include buffer size in s5p_mfc_alloc_priv_buf() the error message when it
fails to allocate the buffer.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
Changes since v1:
 - Left debug message as is. v1 removed the debug message.

 drivers/media/platform/s5p-mfc/s5p_mfc_opr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_opr.c b/drivers/media/platform/s5p-mfc/s5p_mfc_opr.c
index 1e72502..da4f52a 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_opr.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_opr.c
@@ -45,7 +45,8 @@ int s5p_mfc_alloc_priv_buf(struct device *dev, dma_addr_t base,
 	b->virt = dma_alloc_coherent(dev, b->size, &b->dma, GFP_KERNEL);
 
 	if (!b->virt) {
-		mfc_err("Allocating private buffer failed\n");
+		mfc_err("Allocating private buffer of size %zu failed\n",
+			b->size);
 		return -ENOMEM;
 	}
 
-- 
2.7.4
