From: hch@lst.de (Christoph Hellwig)
Date: Wed, 16 May 2018 07:43:37 +0200
Subject: [PATCH 03/14] dax: make the dax_iomap_fault prototype consistent
In-Reply-To: <20180516054348.15950-1-hch@lst.de>
References: <20180516054348.15950-1-hch@lst.de>
Message-ID: <20180516054348.15950-4-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dax.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dax.h b/include/linux/dax.h
index dc65ece825ee..a292bccdc274 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -183,7 +183,7 @@ void dax_flush(struct dax_device *dax_dev, void *addr, size_t size);
 
 ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops);
-int dax_iomap_fault(struct vm_fault *vmf, enum page_entry_size pe_size,
+vm_fault_t dax_iomap_fault(struct vm_fault *vmf, enum page_entry_size pe_size,
 		    pfn_t *pfnp, int *errp, const struct iomap_ops *ops);
 vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
 		enum page_entry_size pe_size, pfn_t pfn);
-- 
2.17.0
