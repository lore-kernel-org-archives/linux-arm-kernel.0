From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Oct 2017 11:06:11 +0200
Subject: [PATCH 04/23] drm/sun4i: tcon: Make tcon_get_clk_delay mode argument
 const
In-Reply-To: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
References: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
Message-ID: <e6f92f126640aa6de639386f9b4677db3d8bb37b.1508231063.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The drm_display_mode pointer can be mark const, so let's do it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 54e1796d2953..9b5b21ad8378 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -146,7 +146,7 @@ void sun4i_tcon_set_mux(struct sun4i_tcon *tcon, int channel,
 }
 EXPORT_SYMBOL(sun4i_tcon_set_mux);
 
-static int sun4i_tcon_get_clk_delay(struct drm_display_mode *mode,
+static int sun4i_tcon_get_clk_delay(const struct drm_display_mode *mode,
 				    int channel)
 {
 	int delay = mode->vtotal - mode->vdisplay;
-- 
git-series 0.9.1
