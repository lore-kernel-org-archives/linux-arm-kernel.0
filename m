From: maxin.john@gmail.com (Maxin B. John)
Date: Mon, 8 Aug 2011 13:15:46 +0300
Subject: [PATCH] arch:arm:plat-omap:iovmm: remove unused variable 'va'
Message-ID: <20110808101546.GA25572@maxin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pointer "va" returned from "phys_to_virt(pa)" is never used in
"sgtable_fill_kmalloc()".So,it is safe to remove this set-but-unused variable.

Signed-off-by: Maxin B. John <maxin.john@gmail.com>
---
diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index c60737c..79e7fed 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -423,9 +423,6 @@ static void sgtable_fill_kmalloc(struct sg_table *sgt, u32 pa, u32 da,
 {
 	unsigned int i;
 	struct scatterlist *sg;
-	void *va;
-
-	va = phys_to_virt(pa);
 
 	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
 		unsigned bytes;
