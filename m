From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 Nov 2017 16:41:36 +0100
Subject: [PATCH v2 12/18] drm/sun4i: Add A83T support
In-Reply-To: <cover.d89f3ea4e1698f9343aef4852977c80edc75f21a.1511797218.git-series.maxime.ripard@free-electrons.com>
References: <cover.d89f3ea4e1698f9343aef4852977c80edc75f21a.1511797218.git-series.maxime.ripard@free-electrons.com>
Message-ID: <3a7cfb438e479000986948caf3c14461be6bbe40.1511797218.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the A83T display pipeline.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 5a1376965270..83b83e070fd5 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -388,6 +388,11 @@ static int sun8i_mixer_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct sun8i_mixer_cfg sun8i_a83t_mixer_cfg = {
+	.vi_num = 1,
+	.ui_num = 3,
+};
+
 static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg = {
 	.vi_num = 2,
 	.ui_num = 1,
@@ -396,7 +401,7 @@ static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg = {
 static const struct of_device_id sun8i_mixer_of_table[] = {
 	{
 		.compatible = "allwinner,sun8i-a83t-de2-mixer",
-		.data = &sun8i_v3s_mixer_cfg,
+		.data = &sun8i_a83t_mixer_cfg,
 	},
 	{
 		.compatible = "allwinner,sun8i-v3s-de2-mixer",
-- 
git-series 0.9.1
