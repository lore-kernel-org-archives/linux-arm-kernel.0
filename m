From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 25 Apr 2012 17:28:03 +0200
Subject: [PATCH 13/33] media mx3 camera: prepare clk before enabling it
In-Reply-To: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
References: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1335367703-19929-14-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/media/video/mx3_camera.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/video/mx3_camera.c b/drivers/media/video/mx3_camera.c
index 93c35ef..e2e33df 100644
--- a/drivers/media/video/mx3_camera.c
+++ b/drivers/media/video/mx3_camera.c
@@ -508,7 +508,7 @@ static void mx3_camera_activate(struct mx3_camera_dev *mx3_cam,
 	/* ipu_csi_init_interface() */
 	csi_reg_write(mx3_cam, conf, CSI_SENS_CONF);
 
-	clk_enable(mx3_cam->clk);
+	clk_prepare_enable(mx3_cam->clk);
 	rate = clk_round_rate(mx3_cam->clk, mx3_cam->mclk);
 	dev_dbg(icd->parent, "Set SENS_CONF to %x, rate %ld\n", conf, rate);
 	if (rate)
@@ -549,7 +549,7 @@ static void mx3_camera_remove_device(struct soc_camera_device *icd)
 		*ichan = NULL;
 	}
 
-	clk_disable(mx3_cam->clk);
+	clk_disable_unprepare(mx3_cam->clk);
 
 	mx3_cam->icd = NULL;
 
-- 
1.7.10
