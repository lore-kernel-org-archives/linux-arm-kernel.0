From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 22 Apr 2014 16:42:19 +0200
Subject: [PATCH 2/4] drm: Constify struct drm_fb_helper_funcs
In-Reply-To: <1398177741-28482-1-git-send-email-thierry.reding@gmail.com>
References: <1398177741-28482-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1398177741-28482-2-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

There's no need for this to be modifiable. Make it const so that it can
be put into the .rodata section.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpu/drm/armada/armada_fbdev.c     | 2 +-
 drivers/gpu/drm/ast/ast_fb.c              | 2 +-
 drivers/gpu/drm/bochs/bochs_fbdev.c       | 2 +-
 drivers/gpu/drm/cirrus/cirrus_fbdev.c     | 2 +-
 drivers/gpu/drm/drm_fb_cma_helper.c       | 2 +-
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 2 +-
 drivers/gpu/drm/gma500/framebuffer.c      | 2 +-
 drivers/gpu/drm/i915/intel_fbdev.c        | 2 +-
 drivers/gpu/drm/mgag200/mgag200_fb.c      | 2 +-
 drivers/gpu/drm/msm/msm_fbdev.c           | 2 +-
 drivers/gpu/drm/nouveau/nouveau_fbcon.c   | 2 +-
 drivers/gpu/drm/omapdrm/omap_fbdev.c      | 2 +-
 drivers/gpu/drm/qxl/qxl_fb.c              | 2 +-
 drivers/gpu/drm/radeon/radeon_fb.c        | 2 +-
 drivers/gpu/drm/tegra/fb.c                | 2 +-
 drivers/gpu/drm/udl/udl_fb.c              | 2 +-
 include/drm/drm_fb_helper.h               | 2 +-
 17 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_fbdev.c b/drivers/gpu/drm/armada/armada_fbdev.c
index 948cb14c561e..21aa1261dba2 100644
--- a/drivers/gpu/drm/armada/armada_fbdev.c
+++ b/drivers/gpu/drm/armada/armada_fbdev.c
@@ -131,7 +131,7 @@ static int armada_fb_probe(struct drm_fb_helper *fbh,
 	return ret;
 }
 
-static struct drm_fb_helper_funcs armada_fb_helper_funcs = {
+static const struct drm_fb_helper_funcs armada_fb_helper_funcs = {
 	.gamma_set	= armada_drm_crtc_gamma_set,
 	.gamma_get	= armada_drm_crtc_gamma_get,
 	.fb_probe	= armada_fb_probe,
diff --git a/drivers/gpu/drm/ast/ast_fb.c b/drivers/gpu/drm/ast/ast_fb.c
index a28640f47c27..2113894e4ff8 100644
--- a/drivers/gpu/drm/ast/ast_fb.c
+++ b/drivers/gpu/drm/ast/ast_fb.c
@@ -287,7 +287,7 @@ static void ast_fb_gamma_get(struct drm_crtc *crtc, u16 *red, u16 *green,
 	*blue = ast_crtc->lut_b[regno] << 8;
 }
 
-static struct drm_fb_helper_funcs ast_fb_helper_funcs = {
+static const struct drm_fb_helper_funcs ast_fb_helper_funcs = {
 	.gamma_set = ast_fb_gamma_set,
 	.gamma_get = ast_fb_gamma_get,
 	.fb_probe = astfb_create,
diff --git a/drivers/gpu/drm/bochs/bochs_fbdev.c b/drivers/gpu/drm/bochs/bochs_fbdev.c
index 561b84474122..17e5c17f2730 100644
--- a/drivers/gpu/drm/bochs/bochs_fbdev.c
+++ b/drivers/gpu/drm/bochs/bochs_fbdev.c
@@ -179,7 +179,7 @@ void bochs_fb_gamma_get(struct drm_crtc *crtc, u16 *red, u16 *green,
 	*blue  = regno;
 }
 
-static struct drm_fb_helper_funcs bochs_fb_helper_funcs = {
+static const struct drm_fb_helper_funcs bochs_fb_helper_funcs = {
 	.gamma_set = bochs_fb_gamma_set,
 	.gamma_get = bochs_fb_gamma_get,
 	.fb_probe = bochsfb_create,
diff --git a/drivers/gpu/drm/cirrus/cirrus_fbdev.c b/drivers/gpu/drm/cirrus/cirrus_fbdev.c
index 32bbba0a787b..2bd0291168e4 100644
--- a/drivers/gpu/drm/cirrus/cirrus_fbdev.c
+++ b/drivers/gpu/drm/cirrus/cirrus_fbdev.c
@@ -288,7 +288,7 @@ static int cirrus_fbdev_destroy(struct drm_device *dev,
 	return 0;
 }
 
-static struct drm_fb_helper_funcs cirrus_fb_helper_funcs = {
+static const struct drm_fb_helper_funcs cirrus_fb_helper_funcs = {
 	.gamma_set = cirrus_crtc_fb_gamma_set,
 	.gamma_get = cirrus_crtc_fb_gamma_get,
 	.fb_probe = cirrusfb_create,
diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c b/drivers/gpu/drm/drm_fb_cma_helper.c
index 61b5a47ad239..b74f9e58b69d 100644
--- a/drivers/gpu/drm/drm_fb_cma_helper.c
+++ b/drivers/gpu/drm/drm_fb_cma_helper.c
@@ -327,7 +327,7 @@ err_drm_gem_cma_free_object:
 	return ret;
 }
 
-static struct drm_fb_helper_funcs drm_fb_cma_helper_funcs = {
+static const struct drm_fb_helper_funcs drm_fb_cma_helper_funcs = {
 	.fb_probe = drm_fbdev_cma_create,
 };
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
index addbf7536da4..7ccf04917f47 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
@@ -233,7 +233,7 @@ out:
 	return ret;
 }
 
-static struct drm_fb_helper_funcs exynos_drm_fb_helper_funcs = {
+static const struct drm_fb_helper_funcs exynos_drm_fb_helper_funcs = {
 	.fb_probe =	exynos_drm_fbdev_create,
 };
 
diff --git a/drivers/gpu/drm/gma500/framebuffer.c b/drivers/gpu/drm/gma500/framebuffer.c
index e7fcc148f333..76e4d777d01d 100644
--- a/drivers/gpu/drm/gma500/framebuffer.c
+++ b/drivers/gpu/drm/gma500/framebuffer.c
@@ -561,7 +561,7 @@ static int psbfb_probe(struct drm_fb_helper *helper,
 	return psbfb_create(psb_fbdev, sizes);
 }
 
-static struct drm_fb_helper_funcs psb_fb_helper_funcs = {
+static const struct drm_fb_helper_funcs psb_fb_helper_funcs = {
 	.gamma_set = psbfb_gamma_set,
 	.gamma_get = psbfb_gamma_get,
 	.fb_probe = psbfb_probe,
diff --git a/drivers/gpu/drm/i915/intel_fbdev.c b/drivers/gpu/drm/i915/intel_fbdev.c
index b4d44e62f0c7..336a89f2549e 100644
--- a/drivers/gpu/drm/i915/intel_fbdev.c
+++ b/drivers/gpu/drm/i915/intel_fbdev.c
@@ -429,7 +429,7 @@ out:
 	return true;
 }
 
-static struct drm_fb_helper_funcs intel_fb_helper_funcs = {
+static const struct drm_fb_helper_funcs intel_fb_helper_funcs = {
 	.initial_config = intel_fb_initial_config,
 	.gamma_set = intel_crtc_fb_gamma_set,
 	.gamma_get = intel_crtc_fb_gamma_get,
diff --git a/drivers/gpu/drm/mgag200/mgag200_fb.c b/drivers/gpu/drm/mgag200/mgag200_fb.c
index 13b7dd83faa9..a4319aba9180 100644
--- a/drivers/gpu/drm/mgag200/mgag200_fb.c
+++ b/drivers/gpu/drm/mgag200/mgag200_fb.c
@@ -272,7 +272,7 @@ static int mga_fbdev_destroy(struct drm_device *dev,
 	return 0;
 }
 
-static struct drm_fb_helper_funcs mga_fb_helper_funcs = {
+static const struct drm_fb_helper_funcs mga_fb_helper_funcs = {
 	.gamma_set = mga_crtc_fb_gamma_set,
 	.gamma_get = mga_crtc_fb_gamma_get,
 	.fb_probe = mgag200fb_create,
diff --git a/drivers/gpu/drm/msm/msm_fbdev.c b/drivers/gpu/drm/msm/msm_fbdev.c
index 6c6d7d4c9b4e..841665862f2f 100644
--- a/drivers/gpu/drm/msm/msm_fbdev.c
+++ b/drivers/gpu/drm/msm/msm_fbdev.c
@@ -180,7 +180,7 @@ static void msm_crtc_fb_gamma_get(struct drm_crtc *crtc,
 	DBG("fbdev: get gamma");
 }
 
-static struct drm_fb_helper_funcs msm_fb_helper_funcs = {
+static const struct drm_fb_helper_funcs msm_fb_helper_funcs = {
 	.gamma_set = msm_crtc_fb_gamma_set,
 	.gamma_get = msm_crtc_fb_gamma_get,
 	.fb_probe = msm_fbdev_create,
diff --git a/drivers/gpu/drm/nouveau/nouveau_fbcon.c b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
index 64a42cfd3717..8e9c07b7fc89 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fbcon.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
@@ -438,7 +438,7 @@ void nouveau_fbcon_gpu_lockup(struct fb_info *info)
 	info->flags |= FBINFO_HWACCEL_DISABLED;
 }
 
-static struct drm_fb_helper_funcs nouveau_fbcon_helper_funcs = {
+static const struct drm_fb_helper_funcs nouveau_fbcon_helper_funcs = {
 	.gamma_set = nouveau_fbcon_gamma_set,
 	.gamma_get = nouveau_fbcon_gamma_get,
 	.fb_probe = nouveau_fbcon_create,
diff --git a/drivers/gpu/drm/omapdrm/omap_fbdev.c b/drivers/gpu/drm/omapdrm/omap_fbdev.c
index 1388ca7f87e8..4cb12083eb12 100644
--- a/drivers/gpu/drm/omapdrm/omap_fbdev.c
+++ b/drivers/gpu/drm/omapdrm/omap_fbdev.c
@@ -281,7 +281,7 @@ fail:
 	return ret;
 }
 
-static struct drm_fb_helper_funcs omap_fb_helper_funcs = {
+static const struct drm_fb_helper_funcs omap_fb_helper_funcs = {
 	.fb_probe = omap_fbdev_create,
 };
 
diff --git a/drivers/gpu/drm/qxl/qxl_fb.c b/drivers/gpu/drm/qxl/qxl_fb.c
index f437b30ce689..cf89614c72be 100644
--- a/drivers/gpu/drm/qxl/qxl_fb.c
+++ b/drivers/gpu/drm/qxl/qxl_fb.c
@@ -660,7 +660,7 @@ static int qxl_fbdev_destroy(struct drm_device *dev, struct qxl_fbdev *qfbdev)
 	return 0;
 }
 
-static struct drm_fb_helper_funcs qxl_fb_helper_funcs = {
+static const struct drm_fb_helper_funcs qxl_fb_helper_funcs = {
 	.fb_probe = qxl_fb_find_or_create_single,
 };
 
diff --git a/drivers/gpu/drm/radeon/radeon_fb.c b/drivers/gpu/drm/radeon/radeon_fb.c
index 665ced3b7313..ad97afdbc4c7 100644
--- a/drivers/gpu/drm/radeon/radeon_fb.c
+++ b/drivers/gpu/drm/radeon/radeon_fb.c
@@ -331,7 +331,7 @@ static int radeon_fbdev_destroy(struct drm_device *dev, struct radeon_fbdev *rfb
 	return 0;
 }
 
-static struct drm_fb_helper_funcs radeon_fb_helper_funcs = {
+static const struct drm_fb_helper_funcs radeon_fb_helper_funcs = {
 	.gamma_set = radeon_crtc_fb_gamma_set,
 	.gamma_get = radeon_crtc_fb_gamma_get,
 	.fb_probe = radeonfb_create,
diff --git a/drivers/gpu/drm/tegra/fb.c b/drivers/gpu/drm/tegra/fb.c
index f7fca09d4921..75bed72a9755 100644
--- a/drivers/gpu/drm/tegra/fb.c
+++ b/drivers/gpu/drm/tegra/fb.c
@@ -267,7 +267,7 @@ release:
 	return err;
 }
 
-static struct drm_fb_helper_funcs tegra_fb_helper_funcs = {
+static const struct drm_fb_helper_funcs tegra_fb_helper_funcs = {
 	.fb_probe = tegra_fbdev_probe,
 };
 
diff --git a/drivers/gpu/drm/udl/udl_fb.c b/drivers/gpu/drm/udl/udl_fb.c
index 377176372da8..0647c8cc368b 100644
--- a/drivers/gpu/drm/udl/udl_fb.c
+++ b/drivers/gpu/drm/udl/udl_fb.c
@@ -550,7 +550,7 @@ out:
 	return ret;
 }
 
-static struct drm_fb_helper_funcs udl_fb_helper_funcs = {
+static const struct drm_fb_helper_funcs udl_fb_helper_funcs = {
 	.fb_probe = udlfb_create,
 };
 
diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index 6e622f7d481d..e8c8eeb3a253 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -87,7 +87,7 @@ struct drm_fb_helper {
 	struct drm_fb_helper_crtc *crtc_info;
 	int connector_count;
 	struct drm_fb_helper_connector **connector_info;
-	struct drm_fb_helper_funcs *funcs;
+	const struct drm_fb_helper_funcs *funcs;
 	struct fb_info *fbdev;
 	u32 pseudo_palette[17];
 	struct list_head kernel_fb_list;
-- 
1.9.2
