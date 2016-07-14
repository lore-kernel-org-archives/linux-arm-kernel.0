From: mark.yao@rock-chips.com (Mark Yao)
Date: Thu, 14 Jul 2016 11:31:27 +0800
Subject: [PATCH 3/6] drm/rockchip: fix "should it be static?" warnings
In-Reply-To: <1468467090-6108-1-git-send-email-mark.yao@rock-chips.com>
References: <1468467090-6108-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1468467090-6108-4-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: John Keeping <john@metanate.com>

Combined with the previous commit, this fixes all of the sparse warnings
in drm/rockchip.

Signed-off-by: John Keeping <john@metanate.com>
Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c  | 2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 4 ++--
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index d665fb0..7216180 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -257,7 +257,7 @@ static void rockchip_drm_unbind(struct device *dev)
 	dev_set_drvdata(dev, NULL);
 }
 
-void rockchip_drm_lastclose(struct drm_device *dev)
+static void rockchip_drm_lastclose(struct drm_device *dev)
 {
 	struct rockchip_drm_private *priv = dev->dev_private;
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index 4fe2ab3..b33debc 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -246,7 +246,7 @@ rockchip_atomic_commit_tail(struct drm_atomic_state *state)
 	drm_atomic_helper_cleanup_planes(dev, state);
 }
 
-struct drm_mode_config_helper_funcs rockchip_mode_config_helpers = {
+static struct drm_mode_config_helper_funcs rockchip_mode_config_helpers = {
 	.atomic_commit_tail = rockchip_atomic_commit_tail,
 };
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 6255e5b..e01c435 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -798,7 +798,7 @@ static const struct drm_plane_helper_funcs plane_helper_funcs = {
 	.atomic_disable = vop_plane_atomic_disable,
 };
 
-void vop_atomic_plane_reset(struct drm_plane *plane)
+static void vop_atomic_plane_reset(struct drm_plane *plane)
 {
 	struct vop_plane_state *vop_plane_state =
 					to_vop_plane_state(plane->state);
@@ -815,7 +815,7 @@ void vop_atomic_plane_reset(struct drm_plane *plane)
 	plane->state->plane = plane;
 }
 
-struct drm_plane_state *
+static struct drm_plane_state *
 vop_atomic_plane_duplicate_state(struct drm_plane *plane)
 {
 	struct vop_plane_state *old_vop_plane_state;
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 3166b46..52661d1 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -299,7 +299,7 @@ static int vop_remove(struct platform_device *pdev)
 	return 0;
 }
 
-struct platform_driver vop_platform_driver = {
+static struct platform_driver vop_platform_driver = {
 	.probe = vop_probe,
 	.remove = vop_remove,
 	.driver = {
-- 
1.9.1
