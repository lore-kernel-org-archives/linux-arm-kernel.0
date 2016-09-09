From: robin.murphy@arm.com (Robin Murphy)
Date: Fri,  9 Sep 2016 19:17:46 +0100
Subject: [PATCH 21/20] drm/exynos: Fix iommu_dma_init_domain prototype change
In-Reply-To: <cover.1473173789.git.robin.murphy@arm.com>
References: <cover.1473173789.git.robin.murphy@arm.com>
Message-ID: <47cdafe035630f29aa1e8ff121c5a5306a2f1eb2.1473444220.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When adding an extra argument to a function, one really should try a bit
harder to catch *all* the callers...

CC: Marek Szyprowski <m.szyprowski@samsung.com>
CC: Inki Dae <inki.dae@samsung.com>
CC: David Airlie <airlied@linux.ie>
CC: dri-devel at lists.freedesktop.org
Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---

Ideally, this should be squashed into "iommu/dma: Avoid PCI host bridge
windows" to avoid potential bisection breakage. Sorry!

 drivers/gpu/drm/exynos/exynos_drm_iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_iommu.h b/drivers/gpu/drm/exynos/exynos_drm_iommu.h
index c8de4913fdbe..87f6b5672e11 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_iommu.h
+++ b/drivers/gpu/drm/exynos/exynos_drm_iommu.h
@@ -66,7 +66,7 @@ static inline int __exynos_iommu_create_mapping(struct exynos_drm_private *priv,
 	if (ret)
 		goto free_domain;
 
-	ret = iommu_dma_init_domain(domain, start, size);
+	ret = iommu_dma_init_domain(domain, start, size, NULL);
 	if (ret)
 		goto put_cookie;
 
-- 
2.8.1.dirty
