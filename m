From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 01 Oct 2015 14:21:40 +0900
Subject: [RESEND] drm/exynos: Staticize local function in exynos_drm_gem.c
Message-ID: <1443676900-32215-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The exynos_drm_gem_mmap_buffer() is not used outside so make it static.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/exynos/exynos_drm_gem.c
index f12fbc36b120..ba9cadb9acef 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gem.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gem.c
@@ -313,7 +313,7 @@ void exynos_drm_gem_put_dma_addr(struct drm_device *dev,
 	drm_gem_object_unreference_unlocked(obj);
 }
 
-int exynos_drm_gem_mmap_buffer(struct exynos_drm_gem_obj *exynos_gem_obj,
+static int exynos_drm_gem_mmap_buffer(struct exynos_drm_gem_obj *exynos_gem_obj,
 				      struct vm_area_struct *vma)
 {
 	struct drm_device *drm_dev = exynos_gem_obj->base.dev;
-- 
1.9.1
