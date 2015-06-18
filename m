From: sudipm.mukherjee@gmail.com (Sudip Mukherjee)
Date: Thu, 18 Jun 2015 17:47:48 +0530
Subject: [PATCH v2 2/7] mn10300: Provide dummy dma_alloc_attrs() and
 dma_free_attrs()
In-Reply-To: <1434629873-11668-1-git-send-email-sudipm.mukherjee@gmail.com>
References: <1434629873-11668-1-git-send-email-sudipm.mukherjee@gmail.com>
Message-ID: <1434629873-11668-3-git-send-email-sudipm.mukherjee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

allmodconfig fails to build with following errors.

drivers/media/platform/sti/bdisp/bdisp-hw.c:
	In function 'bdisp_hw_free_nodes':
drivers/media/platform/sti/bdisp/bdisp-hw.c:132:3: error:
	implicit declaration of function 'dma_free_attrs'

drivers/media/platform/sti/bdisp/bdisp-hw.c:
	In function 'bdisp_hw_alloc_nodes':
drivers/media/platform/sti/bdisp/bdisp-hw.c:157:2: error:
	implicit declaration of function 'dma_alloc_attrs'

mn10300 does not provide those functions at this time.
Provide dummy implementations to avoid build errors.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---

copied from https://lkml.org/lkml/2015/4/22/346

 arch/mn10300/include/asm/dma-mapping.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/mn10300/include/asm/dma-mapping.h b/arch/mn10300/include/asm/dma-mapping.h
index a18abfc..d589c5e 100644
--- a/arch/mn10300/include/asm/dma-mapping.h
+++ b/arch/mn10300/include/asm/dma-mapping.h
@@ -183,4 +183,17 @@ static inline int dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 	return -EINVAL;
 }
 
+static inline void *dma_alloc_attrs(struct device *dev, size_t size,
+				    dma_addr_t *dma_handle, gfp_t flag,
+				    struct dma_attrs *attrs)
+{
+	return NULL;
+}
+
+static inline void dma_free_attrs(struct device *dev, size_t size,
+				  void *vaddr, dma_addr_t dma_handle,
+				  struct dma_attrs *attrs)
+{
+}
+
 #endif
-- 
1.8.1.2
