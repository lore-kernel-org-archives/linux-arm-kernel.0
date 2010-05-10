From: Hiroshi.DOYU@nokia.com (Hiroshi DOYU)
Date: Mon, 10 May 2010 12:16:06 +0300
Subject: [PATCH] omap iommu: missing check for TLB valid entry
In-Reply-To: <1273482972-5586-1-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1273482972-5586-1-git-send-email-Hiroshi.DOYU@nokia.com>
Message-ID: <1273482972-5586-3-git-send-email-Hiroshi.DOYU@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kanigeri, Hari <h-kanigeri2@ti.com>

Added the missing TLB valid entry setting for cam register

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/iommu2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index 4f63dc6..d29ebff 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -184,7 +184,7 @@ static struct cr_regs *omap2_alloc_cr(struct iommu *obj, struct iotlb_entry *e)
 	if (!cr)
 		return ERR_PTR(-ENOMEM);
 
-	cr->cam = (e->da & MMU_CAM_VATAG_MASK) | e->prsvd | e->pgsz;
+	cr->cam = (e->da & MMU_CAM_VATAG_MASK) | e->prsvd | e->pgsz | e->valid;
 	cr->ram = e->pa | e->endian | e->elsz | e->mixed;
 
 	return cr;
-- 
1.7.1.rc1
