From: CARLOS.PALMINHA@synopsys.com (Carlos Palminha)
Date: Fri, 12 Feb 2016 13:50:01 +0000
Subject: [PATCH 01/17] drm/virtio: removed optional dummy encoder mode_fixup
 function.
In-Reply-To: <1455285017-2771-1-git-send-email-palminha@synopsys.com>
References: <1455285017-2771-1-git-send-email-palminha@synopsys.com>
Message-ID: <1455285017-2771-2-git-send-email-palminha@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 drivers/gpu/drm/virtio/virtgpu_display.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index a165f03..429aa31 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -282,13 +282,6 @@ static const struct drm_crtc_helper_funcs virtio_gpu_crtc_helper_funcs = {
 	.atomic_check  = virtio_gpu_crtc_atomic_check,
 };
 
-static bool virtio_gpu_enc_mode_fixup(struct drm_encoder *encoder,
-				      const struct drm_display_mode *mode,
-				      struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static void virtio_gpu_enc_mode_set(struct drm_encoder *encoder,
 				    struct drm_display_mode *mode,
 				    struct drm_display_mode *adjusted_mode)
@@ -362,7 +355,6 @@ virtio_gpu_best_encoder(struct drm_connector *connector)
 }
 
 static const struct drm_encoder_helper_funcs virtio_gpu_enc_helper_funcs = {
-	.mode_fixup = virtio_gpu_enc_mode_fixup,
 	.mode_set   = virtio_gpu_enc_mode_set,
 	.enable     = virtio_gpu_enc_enable,
 	.disable    = virtio_gpu_enc_disable,
-- 
2.5.0
