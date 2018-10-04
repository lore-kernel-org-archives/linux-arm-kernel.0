From: daniel.vetter@ffwll.ch (Daniel Vetter)
Date: Thu,  4 Oct 2018 22:24:34 +0200
Subject: [PATCH 09/21] drm/atmel: Drop transitional hooks
In-Reply-To: <20181004202446.22905-1-daniel.vetter@ffwll.ch>
References: <20181004202446.22905-1-daniel.vetter@ffwll.ch>
Message-ID: <20181004202446.22905-10-daniel.vetter@ffwll.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These do absolutely nothing for atomic drivers.

Reviewed-by: Ville Syrj?l? <ville.syrjala@linux.intel.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index 9e34bce089d0..96f4082671fe 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -364,9 +364,7 @@ static void atmel_hlcdc_crtc_atomic_flush(struct drm_crtc *crtc,
 
 static const struct drm_crtc_helper_funcs lcdc_crtc_helper_funcs = {
 	.mode_valid = atmel_hlcdc_crtc_mode_valid,
-	.mode_set = drm_helper_crtc_mode_set,
 	.mode_set_nofb = atmel_hlcdc_crtc_mode_set_nofb,
-	.mode_set_base = drm_helper_crtc_mode_set_base,
 	.atomic_check = atmel_hlcdc_crtc_atomic_check,
 	.atomic_begin = atmel_hlcdc_crtc_atomic_begin,
 	.atomic_flush = atmel_hlcdc_crtc_atomic_flush,
-- 
2.19.0.rc2
