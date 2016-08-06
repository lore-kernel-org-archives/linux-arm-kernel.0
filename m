From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Fri,  5 Aug 2016 19:50:06 -0600
Subject: [PATCH] exynos-drm: Fix unsupported GEM memory type error message to
 be clear
Message-ID: <1470448206-16538-1-git-send-email-shuahkh@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix unsupported GEM memory type error message to include the memory type
information.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fb.c b/drivers/gpu/drm/exynos/exynos_drm_fb.c
index e016640..c9315df 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fb.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fb.c
@@ -55,11 +55,11 @@ static int check_fb_gem_memory_type(struct drm_device *drm_dev,
 	flags = exynos_gem->flags;
 
 	/*
-	 * without iommu support, not support physically non-continuous memory
+	 * without iommu support, not support physically non-contiguous memory
 	 * for framebuffer.
 	 */
 	if (IS_NONCONTIG_BUFFER(flags)) {
-		DRM_ERROR("cannot use this gem memory type for fb.\n");
+		DRM_ERROR("Non-continguous GEM memory is not supported.\n");
 		return -EINVAL;
 	}
 
-- 
2.7.4
