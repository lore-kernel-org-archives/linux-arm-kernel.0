From: hch@lst.de (Christoph Hellwig)
Date: Fri, 29 Dec 2017 09:18:24 +0100
Subject: [PATCH 20/67] s390: move s390_pci_dma_ops to asm/pci_dma.h
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
Message-ID: <20171229081911.2802-21-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is not needed in drivers, so move it to a private header.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/s390/include/asm/dma-mapping.h | 2 --
 arch/s390/include/asm/pci_dma.h     | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/dma-mapping.h b/arch/s390/include/asm/dma-mapping.h
index 2ec7240c1ada..bdc2455483f6 100644
--- a/arch/s390/include/asm/dma-mapping.h
+++ b/arch/s390/include/asm/dma-mapping.h
@@ -9,8 +9,6 @@
 #include <linux/dma-debug.h>
 #include <linux/io.h>
 
-extern const struct dma_map_ops s390_pci_dma_ops;
-
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 	return &dma_noop_ops;
diff --git a/arch/s390/include/asm/pci_dma.h b/arch/s390/include/asm/pci_dma.h
index e8d9161fa17a..419fac7a62c0 100644
--- a/arch/s390/include/asm/pci_dma.h
+++ b/arch/s390/include/asm/pci_dma.h
@@ -201,4 +201,7 @@ void dma_cleanup_tables(unsigned long *);
 unsigned long *dma_walk_cpu_trans(unsigned long *rto, dma_addr_t dma_addr);
 void dma_update_cpu_trans(unsigned long *entry, void *page_addr, int flags);
 
+extern const struct dma_map_ops s390_pci_dma_ops;
+
+
 #endif
-- 
2.14.2
