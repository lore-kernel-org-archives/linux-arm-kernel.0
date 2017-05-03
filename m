From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed,  3 May 2017 13:59:46 +0200
Subject: [PATCH v2 9/20] drm/sun4i: tcon: Add channel debug
In-Reply-To: <cover.d697f34bb7b0605c5e76cbc4167a64453e5e0984.1493812478.git-series.maxime.ripard@free-electrons.com>
References: <cover.d697f34bb7b0605c5e76cbc4167a64453e5e0984.1493812478.git-series.maxime.ripard@free-electrons.com>
Message-ID: <d9cecce96aa531b83f58b38df827e38ba1618858.1493812478.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While all functions have debug logs, the channel enable and disable are not
logged. Make sure this is the case.

Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 4 ++++
 1 file changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 9a83a85529ac..66a5bb9b85e9 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -54,6 +54,8 @@ EXPORT_SYMBOL(sun4i_tcon_enable);
 
 void sun4i_tcon_channel_disable(struct sun4i_tcon *tcon, int channel)
 {
+	DRM_DEBUG_DRIVER("Disabling TCON channel %d\n", channel);
+
 	/* Disable the TCON's channel */
 	if (channel == 0) {
 		regmap_update_bits(tcon->regs, SUN4I_TCON0_CTL_REG,
@@ -71,6 +73,8 @@ EXPORT_SYMBOL(sun4i_tcon_channel_disable);
 
 void sun4i_tcon_channel_enable(struct sun4i_tcon *tcon, int channel)
 {
+	DRM_DEBUG_DRIVER("Enabling TCON channel %d\n", channel);
+
 	/* Enable the TCON's channel */
 	if (channel == 0) {
 		regmap_update_bits(tcon->regs, SUN4I_TCON0_CTL_REG,
-- 
git-series 0.8.11
