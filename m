From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 19 Jun 2015 14:23:29 +0900
Subject: [PATCH] drm/exynos: Remove unused vma field of exynos_drm_gem_obj
Message-ID: <1434691409-9509-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The field 'vma' of 'exynos_drm_gem_obj' structure was introduced in
2a3098ff6c21 ("drm/exynos: add userptr feature for g2d module") but is
not referenced anywhere.

One instance of 'exynos_drm_gem_obj' may be mapped to multiple
user-space VMAs so 'vma' field does not look useful anyway.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_gem.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.h b/drivers/gpu/drm/exynos/exynos_drm_gem.h
index 308173cb4f0a..6f42e2248288 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gem.h
+++ b/drivers/gpu/drm/exynos/exynos_drm_gem.h
@@ -61,7 +61,6 @@ struct exynos_drm_gem_buf {
  *	or at framebuffer creation.
  * @size: size requested from user, in bytes and this size is aligned
  *	in page unit.
- * @vma: a pointer to vm_area.
  * @flags: indicate memory type to allocated buffer and cache attruibute.
  *
  * P.S. this object would be transferred to user as kms_bo.handle so
@@ -71,7 +70,6 @@ struct exynos_drm_gem_obj {
 	struct drm_gem_object		base;
 	struct exynos_drm_gem_buf	*buffer;
 	unsigned long			size;
-	struct vm_area_struct		*vma;
 	unsigned int			flags;
 };
 
-- 
1.9.1
