From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Sun,  7 Oct 2018 11:38:50 +0200
Subject: [PATCH v2 14/29] drm/sun4i: Add support for H6 DE3 mixer 0
In-Reply-To: <20181007093905.11253-1-jernej.skrabec@siol.net>
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
Message-ID: <20181007093905.11253-15-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mixer 0 has 1 VI and 3 UI planes, scaler on all planes and can output
4K image @60Hz. It also support 10 bit colors, which are not yet
implemented.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 64daeb017d10..ace8b6cb8a8b 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -613,6 +613,15 @@ static const struct sun8i_mixer_cfg sun50i_a64_mixer1_cfg = {
 	.vi_num		= 1,
 };
 
+static const struct sun8i_mixer_cfg sun50i_h6_mixer0_cfg = {
+	.ccsc		= 0,
+	.is_de3		= true,
+	.mod_rate	= 600000000,
+	.scaler_mask	= 0xf,
+	.ui_num		= 3,
+	.vi_num		= 1,
+};
+
 static const struct of_device_id sun8i_mixer_of_table[] = {
 	{
 		.compatible = "allwinner,sun8i-a83t-de2-mixer-0",
@@ -646,6 +655,10 @@ static const struct of_device_id sun8i_mixer_of_table[] = {
 		.compatible = "allwinner,sun50i-a64-de2-mixer-1",
 		.data = &sun50i_a64_mixer1_cfg,
 	},
+	{
+		.compatible = "allwinner,sun50i-h6-de3-mixer-0",
+		.data = &sun50i_h6_mixer0_cfg,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun8i_mixer_of_table);
-- 
2.19.0
