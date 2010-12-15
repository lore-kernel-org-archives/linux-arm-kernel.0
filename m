From: fernando.lugo@ti.com (Fernando Guzman Lugo)
Date: Tue, 14 Dec 2010 18:54:02 -0600
Subject: [PATCHv7 3/4] omap: iovmm - replace __iounmap with iounmap
In-Reply-To: <1292374443-4055-1-git-send-email-fernando.lugo@ti.com>
References: <1292374443-4055-1-git-send-email-fernando.lugo@ti.com>
Message-ID: <1292374443-4055-4-git-send-email-fernando.lugo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guzman Lugo, Fernando <x0095840@ti.com>

__iounmap function is wrong for OMAP architecture,
instead use iounmap which will call to the correct function.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/iovmm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index 93a34d9..fa6e643 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -821,7 +821,7 @@ void iommu_kunmap(struct iommu *obj, u32 da)
 	struct sg_table *sgt;
 	typedef void (*func_t)(const void *);
 
-	sgt = unmap_vm_area(obj, da, (func_t)__iounmap,
+	sgt = unmap_vm_area(obj, da, (func_t)iounmap,
 			    IOVMF_LINEAR | IOVMF_MMIO);
 	if (!sgt)
 		dev_dbg(obj->dev, "%s: No sgt\n", __func__);
-- 
1.7.0.4
