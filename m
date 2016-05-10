From: john@metanate.com (John Keeping)
Date: Tue, 10 May 2016 17:03:56 +0100
Subject: [PATCH 3/3] drm/rockchip: fix "should it be static?" warnings
In-Reply-To: <20160510160356.1167-1-john@metanate.com>
References: <20160510160356.1167-1-john@metanate.com>
Message-ID: <20160510160356.1167-4-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Combined with the previous commit, this fixes all of the sparse warnings
in drm/rockchip.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 4 ++--
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c  | 6 +++---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 4 ++--
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 399adf3c4224..b253f65c3e14 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -287,7 +287,7 @@ static void rockchip_drm_preclose(struct drm_device *dev,
 		rockchip_drm_crtc_cancel_pending_vblank(crtc, file_priv);
 }
 
-void rockchip_drm_lastclose(struct drm_device *dev)
+static void rockchip_drm_lastclose(struct drm_device *dev)
 {
 	struct rockchip_drm_private *priv = dev->dev_private;
 
@@ -307,7 +307,7 @@ static const struct file_operations rockchip_drm_driver_fops = {
 	.release = drm_release,
 };
 
-const struct vm_operations_struct rockchip_drm_vm_ops = {
+static const struct vm_operations_struct rockchip_drm_vm_ops = {
 	.open = drm_gem_vm_open,
 	.close = drm_gem_vm_close,
 };
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index 85aa87ee12f5..96d91f16e001 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -275,9 +275,9 @@ void rockchip_drm_atomic_work(struct work_struct *work)
 	rockchip_atomic_commit_complete(commit);
 }
 
-int rockchip_drm_atomic_commit(struct drm_device *dev,
-			       struct drm_atomic_state *state,
-			       bool nonblock)
+static int rockchip_drm_atomic_commit(struct drm_device *dev,
+				      struct drm_atomic_state *state,
+				      bool nonblock)
 {
 	struct rockchip_drm_private *private = dev->dev_private;
 	struct rockchip_atomic_commit *commit = &private->commit;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index bf55cda356ba..949171a80631 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -779,7 +779,7 @@ static const struct drm_plane_helper_funcs plane_helper_funcs = {
 	.atomic_disable = vop_plane_atomic_disable,
 };
 
-void vop_atomic_plane_reset(struct drm_plane *plane)
+static void vop_atomic_plane_reset(struct drm_plane *plane)
 {
 	struct vop_plane_state *vop_plane_state =
 					to_vop_plane_state(plane->state);
@@ -796,7 +796,7 @@ void vop_atomic_plane_reset(struct drm_plane *plane)
 	plane->state->plane = plane;
 }
 
-struct drm_plane_state *
+static struct drm_plane_state *
 vop_atomic_plane_duplicate_state(struct drm_plane *plane)
 {
 	struct vop_plane_state *old_vop_plane_state;
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 3166b46a5893..52661d116ec2 100644
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
2.8.2.565.gdb84f68.dirty
