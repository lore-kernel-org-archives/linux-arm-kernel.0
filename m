From: jagan@amarulasolutions.com (Jagan Teki)
Date: Wed, 18 Jul 2018 16:24:42 +0530
Subject: [PATCH v3 02/18] drm/sun4i: Add support for A64 mixer1
In-Reply-To: <20180718105458.22304-1-jagan@amarulasolutions.com>
References: <20180718105458.22304-1-jagan@amarulasolutions.com>
Message-ID: <20180718105458.22304-3-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mixers in Allwinner have similar capabilities as others SoCs with DE2.

Mixer1 has 1 VI and 1 UI planes and supports HW scaling on all
planes.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- none 
Changes for v2:
- New patch

 drivers/gpu/drm/sun4i/sun8i_mixer.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index f76a5576c0e6..756280194f94 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -578,6 +578,14 @@ static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg = {
 	.mod_rate = 150000000,
 };
 
+static const struct sun8i_mixer_cfg sun50i_a64_mixer1_cfg = {
+	.ccsc		= 1,
+	.mod_rate	= 297000000,
+	.scaler_mask	= 0x3,
+	.ui_num		= 1,
+	.vi_num		= 1,
+};
+
 static const struct of_device_id sun8i_mixer_of_table[] = {
 	{
 		.compatible = "allwinner,sun8i-a83t-de2-mixer-0",
@@ -603,6 +611,10 @@ static const struct of_device_id sun8i_mixer_of_table[] = {
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
2.17.1
