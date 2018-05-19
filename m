From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Sat, 19 May 2018 20:31:21 +0200
Subject: [PATCH 09/15] drm/sun4i: Add support for R40 mixers
In-Reply-To: <20180519183127.2718-1-jernej.skrabec@siol.net>
References: <20180519183127.2718-1-jernej.skrabec@siol.net>
Message-ID: <20180519183127.2718-10-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both mixers have similar capabilities as others SoCs with DE2.

First mixer has 1 VI and 3 UI planes and supports HW scaling on all
planes.

Second mixer has 1 VI and 1 UI planes and also supports HW scaling on
all planes.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 36d90c76317a..78aa878e305c 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -500,6 +500,24 @@ static const struct sun8i_mixer_cfg sun8i_h3_mixer0_cfg = {
 	.vi_num		= 1,
 };
 
+static const struct sun8i_mixer_cfg sun8i_r40_mixer0_cfg = {
+	.ccsc		= 0,
+	.index		= 0,
+	.mod_rate	= 297000000,
+	.scaler_mask	= 0xf,
+	.ui_num		= 3,
+	.vi_num		= 1,
+};
+
+static const struct sun8i_mixer_cfg sun8i_r40_mixer1_cfg = {
+	.ccsc		= 1,
+	.index		= 1,
+	.mod_rate	= 297000000,
+	.scaler_mask	= 0x3,
+	.ui_num		= 1,
+	.vi_num		= 1,
+};
+
 static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg = {
 	.vi_num = 2,
 	.ui_num = 1,
@@ -521,6 +539,14 @@ static const struct of_device_id sun8i_mixer_of_table[] = {
 		.compatible = "allwinner,sun8i-h3-de2-mixer-0",
 		.data = &sun8i_h3_mixer0_cfg,
 	},
+	{
+		.compatible = "allwinner,sun8i-r40-de2-mixer-0",
+		.data = &sun8i_r40_mixer0_cfg,
+	},
+	{
+		.compatible = "allwinner,sun8i-r40-de2-mixer-1",
+		.data = &sun8i_r40_mixer1_cfg,
+	},
 	{
 		.compatible = "allwinner,sun8i-v3s-de2-mixer",
 		.data = &sun8i_v3s_mixer_cfg,
-- 
2.17.0
