From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon,  8 Apr 2013 18:04:34 +0200
Subject: [PATCH 3/7] staging: drm/imx: ipu-di: add comments explaining signal
 generator configuration
In-Reply-To: <1365437078-22579-1-git-send-email-p.zabel@pengutronix.de>
References: <1365437078-22579-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1365437078-22579-4-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/imx-drm/ipu-v3/ipu-di.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-di.c b/drivers/staging/imx-drm/ipu-v3/ipu-di.c
index ec340da..26534b7 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-di.c
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-di.c
@@ -413,9 +413,11 @@ static void ipu_di_sync_config_noninterlaced(struct ipu_di *di,
 		sig->v_end_width;
 	struct di_sync_config cfg[] = {
 		{
+			/* 1: INT_HSYNC */
 			.run_count = h_total - 1,
 			.run_src = DI_SYNC_CLK,
 		} , {
+			/* PIN2: HSYNC */
 			.run_count = h_total - 1,
 			.run_src = DI_SYNC_CLK,
 			.offset_count = div * sig->v_to_h_sync,
@@ -424,23 +426,28 @@ static void ipu_di_sync_config_noninterlaced(struct ipu_di *di,
 			.cnt_polarity_trigger_src = DI_SYNC_CLK,
 			.cnt_down = sig->h_sync_width * 2,
 		} , {
+			/* PIN3: VSYNC */
 			.run_count = v_total - 1,
 			.run_src = DI_SYNC_INT_HSYNC,
 			.cnt_polarity_gen_en = 1,
 			.cnt_polarity_trigger_src = DI_SYNC_INT_HSYNC,
 			.cnt_down = sig->v_sync_width * 2,
 		} , {
+			/* 4: Line Active */
 			.run_src = DI_SYNC_HSYNC,
 			.offset_count = sig->v_sync_width + sig->v_start_width,
 			.offset_src = DI_SYNC_HSYNC,
 			.repeat_count = sig->height,
 			.cnt_clr_src = DI_SYNC_VSYNC,
 		} , {
+			/* 5: DE, referenced by DC */
 			.run_src = DI_SYNC_CLK,
 			.offset_count = sig->h_sync_width + sig->h_start_width,
 			.offset_src = DI_SYNC_CLK,
 			.repeat_count = sig->width,
-			.cnt_clr_src = 5,
+			.cnt_clr_src = 5, /* Line Active */
+		} , {
+			/* unused */
 		} , {
 			/* unused */
 		} , {
-- 
1.8.2.rc2
