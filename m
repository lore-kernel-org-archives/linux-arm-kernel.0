From: jagan@amarulasolutions.com (Jagan Teki)
Date: Fri, 18 May 2018 15:15:16 +0530
Subject: [PATCH v2 06/26] drm/sun4i: Add support for A64 mixer1
In-Reply-To: <20180518094536.17201-1-jagan@amarulasolutions.com>
References: <20180518094536.17201-1-jagan@amarulasolutions.com>
Message-ID: <20180518094536.17201-7-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mixers in Allwinner have similar capabilities as others SoCs with DE2.

Mixer1 has 1 VI and 1 UI planes and supports HW scaling on all
planes.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- New patch

 drivers/gpu/drm/sun4i/sun8i_mixer.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 36d90c76317a..5b02c6ee2be6 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -508,6 +508,15 @@ static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg = {
 	.mod_rate = 150000000,
 };
 
+static const struct sun8i_mixer_cfg sun50i_a64_mixer1_cfg = {
+	.ccsc		= 1,
+	.index		= 1,
+	.mod_rate	= 297000000,
+	.scaler_mask	= 0x3,
+	.ui_num		= 1,
+	.vi_num		= 1,
+};
+
 static const struct of_device_id sun8i_mixer_of_table[] = {
 	{
 		.compatible = "allwinner,sun8i-a83t-de2-mixer-0",
@@ -525,6 +534,10 @@ static const struct of_device_id sun8i_mixer_of_table[] = {
 		.compatible = "allwinner,sun8i-v3s-de2-mixer",
 		.data = &sun8i_v3s_mixer_cfg,
 	},
+	{
+		.compatible = "allwinner,sun50i-a64-de2-mixer-1",
+		.data = &sun50i_a64_mixer1_cfg,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun8i_mixer_of_table);
-- 
2.14.3
