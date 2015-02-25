From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 25 Feb 2015 18:44:51 +0100
Subject: [PATCH] drm: atmel-hlcdc: remove clock polarity from crtc driver
Message-ID: <1424886291-15747-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove this configuration bit in crtc driver as the rising edge clock is widely
used.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index 0409b907de5d..b3e3068c6ec0 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -153,7 +153,7 @@ static int atmel_hlcdc_crtc_mode_set(struct drm_crtc *c,
 		     (adj->crtc_hdisplay - 1) |
 		     ((adj->crtc_vdisplay - 1) << 16));
 
-	cfg = ATMEL_HLCDC_CLKPOL;
+	cfg = 0;
 
 	prate = clk_get_rate(crtc->dc->hlcdc->sys_clk);
 	mode_rate = mode->crtc_clock * 1000;
-- 
2.1.3
