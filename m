From: dacohen@gmail.com (David Cohen)
Date: Sat, 12 Feb 2011 12:02:29 +0200
Subject: [PATCH] omap iommu: print module name on error messages
Message-ID: <1297504949-26233-1-git-send-email-dacohen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP IOMMU generic layer doesn't need ot print function name during
error messages. Print module name instead which is more useful.

Signed-off-by: David Cohen <dacohen@gmail.com>
---
 arch/arm/plat-omap/iommu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index b1107c0..f55f458 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -806,7 +806,7 @@ static irqreturn_t iommu_fault_handler(int irq, void *data)
 	iopgd = iopgd_offset(obj, da);
 
 	if (!iopgd_is_table(*iopgd)) {
-		dev_err(obj->dev, "%s: da:%08x pgd:%p *pgd:%08x\n", __func__,
+		dev_err(obj->dev, "%s: da:%08x pgd:%p *pgd:%08x\n", obj->name,
 			da, iopgd, *iopgd);
 		return IRQ_NONE;
 	}
@@ -814,7 +814,7 @@ static irqreturn_t iommu_fault_handler(int irq, void *data)
 	iopte = iopte_offset(iopgd, da);
 
 	dev_err(obj->dev, "%s: da:%08x pgd:%p *pgd:%08x pte:%p *pte:%08x\n",
-		__func__, da, iopgd, *iopgd, iopte, *iopte);
+		obj->name, da, iopgd, *iopgd, iopte, *iopte);
 
 	return IRQ_NONE;
 }
-- 
1.7.1
