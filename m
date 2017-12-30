From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Sat, 30 Dec 2017 22:02:00 +0100
Subject: [PATCH 08/11] drm/sun4i: Add support for A83T second DE2 mixer
In-Reply-To: <20171230210203.24115-1-jernej.skrabec@siol.net>
References: <20171230210203.24115-1-jernej.skrabec@siol.net>
Message-ID: <20171230210203.24115-9-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It supports 1 VI and 1 UI plane and HW scaling on both planes.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 2cbb2de6d39c..9b0256d31a61 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -485,6 +485,13 @@ static const struct sun8i_mixer_cfg sun8i_a83t_mixer0_cfg = {
 	.vi_num		= 1,
 };
 
+static const struct sun8i_mixer_cfg sun8i_a83t_mixer1_cfg = {
+	.ccsc		= 1,
+	.scaler_mask	= 0x3,
+	.ui_num		= 1,
+	.vi_num		= 1,
+};
+
 static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg = {
 	.vi_num = 2,
 	.ui_num = 1,
@@ -498,6 +505,10 @@ static const struct of_device_id sun8i_mixer_of_table[] = {
 		.compatible = "allwinner,sun8i-a83t-de2-mixer-0",
 		.data = &sun8i_a83t_mixer0_cfg,
 	},
+	{
+		.compatible = "allwinner,sun8i-a83t-de2-mixer-1",
+		.data = &sun8i_a83t_mixer1_cfg,
+	},
 	{
 		.compatible = "allwinner,sun8i-v3s-de2-mixer",
 		.data = &sun8i_v3s_mixer_cfg,
-- 
2.15.1
