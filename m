From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  7 Mar 2017 09:56:27 +0100
Subject: [PATCH 8/15] drm/sun4i: tcon: Add channel debug
In-Reply-To: <cover.bc06ffa88f847ddd9ddd7c259415d5f61b55307b.1488876832.git-series.maxime.ripard@free-electrons.com>
References: <cover.bc06ffa88f847ddd9ddd7c259415d5f61b55307b.1488876832.git-series.maxime.ripard@free-electrons.com>
Message-ID: <71ebb24fd6b0efc1af7de732aa4aac9d5a2ee4f1.1488876832.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While all functions have debug logs, the channel enable and disable are not
logged. Make sure this is the case.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 4 ++++
 1 file changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 505520baa585..7461ae107e54 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -55,6 +55,8 @@ EXPORT_SYMBOL(sun4i_tcon_enable);
 
 void sun4i_tcon_channel_disable(struct sun4i_tcon *tcon, int channel)
 {
+	DRM_DEBUG_DRIVER("Disabling TCON channel %d\n", channel);
+
 	/* Disable the TCON's channel */
 	if (channel == 0) {
 		regmap_update_bits(tcon->regs, SUN4I_TCON0_CTL_REG,
@@ -72,6 +74,8 @@ EXPORT_SYMBOL(sun4i_tcon_channel_disable);
 
 void sun4i_tcon_channel_enable(struct sun4i_tcon *tcon, int channel)
 {
+	DRM_DEBUG_DRIVER("Enabling TCON channel %d\n", channel);
+
 	/* Enable the TCON's channel */
 	if (channel == 0) {
 		regmap_update_bits(tcon->regs, SUN4I_TCON0_CTL_REG,
-- 
git-series 0.8.11
