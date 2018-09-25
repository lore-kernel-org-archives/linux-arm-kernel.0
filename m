From: hch@lst.de (Christoph Hellwig)
Date: Tue, 25 Sep 2018 13:30:05 -0700
Subject: [PATCH 1/5] arm: remove the unused BIOVEC_MERGEABLE define
In-Reply-To: <20180925203009.1838-1-hch@lst.de>
References: <20180925203009.1838-1-hch@lst.de>
Message-ID: <20180925203009.1838-2-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/io.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 3c835d6263fa..e58ca25eddb7 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -459,13 +459,6 @@ extern void pci_iounmap(struct pci_dev *dev, void __iomem *addr);
 
 #include <asm-generic/io.h>
 
-/*
- * can the hardware map this into one segment or not, given no other
- * constraints.
- */
-#define BIOVEC_MERGEABLE(vec1, vec2)	\
-	((bvec_to_phys((vec1)) + (vec1)->bv_len) == bvec_to_phys((vec2)))
-
 struct bio_vec;
 extern bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
 				      const struct bio_vec *vec2);
-- 
2.19.0
