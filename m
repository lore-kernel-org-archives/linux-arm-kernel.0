From: x0095840@ti.com (Fernando Guzman Lugo)
Date: Mon, 25 Oct 2010 14:10:05 -0500
Subject: [PATCHv5 3/4] omap: iovmm - replace __iounmap with omap_iounmap
In-Reply-To: <1288033806-1496-3-git-send-email-x0095840@ti.com>
References: <1288033806-1496-1-git-send-email-x0095840@ti.com>
	<1288033806-1496-2-git-send-email-x0095840@ti.com>
	<1288033806-1496-3-git-send-email-x0095840@ti.com>
Message-ID: <1288033806-1496-4-git-send-email-x0095840@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Omap platform is omap_iounmap function.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 arch/arm/plat-omap/iovmm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index 93a34d9..5489ca9 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -821,7 +821,7 @@ void iommu_kunmap(struct iommu *obj, u32 da)
 	struct sg_table *sgt;
 	typedef void (*func_t)(const void *);
 
-	sgt = unmap_vm_area(obj, da, (func_t)__iounmap,
+	sgt = unmap_vm_area(obj, da, (func_t)omap_iounmap,
 			    IOVMF_LINEAR | IOVMF_MMIO);
 	if (!sgt)
 		dev_dbg(obj->dev, "%s: No sgt\n", __func__);
-- 
1.6.3.3
