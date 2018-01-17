From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Wed, 17 Jan 2018 21:14:17 +0100
Subject: [PATCH v3 08/12] drm/sun4i: Add support for A83T second TCON
In-Reply-To: <20180117201421.25954-1-jernej.skrabec@siol.net>
References: <20180117201421.25954-1-jernej.skrabec@siol.net>
Message-ID: <20180117201421.25954-9-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This TCON is connected to HDMI encoder.

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 0815c528d08e..adfa39f372cf 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -1154,6 +1154,10 @@ static const struct sun4i_tcon_quirks sun8i_a83t_lcd_quirks = {
 	.has_channel_0		= true,
 };
 
+static const struct sun4i_tcon_quirks sun8i_a83t_tv_quirks = {
+	.has_channel_1		= true,
+};
+
 static const struct sun4i_tcon_quirks sun8i_v3s_quirks = {
 	.has_channel_0		= true,
 };
@@ -1167,6 +1171,7 @@ const struct of_device_id sun4i_tcon_of_table[] = {
 	{ .compatible = "allwinner,sun7i-a20-tcon", .data = &sun7i_a20_quirks },
 	{ .compatible = "allwinner,sun8i-a33-tcon", .data = &sun8i_a33_quirks },
 	{ .compatible = "allwinner,sun8i-a83t-tcon-lcd", .data = &sun8i_a83t_lcd_quirks },
+	{ .compatible = "allwinner,sun8i-a83t-tcon-tv", .data = &sun8i_a83t_tv_quirks },
 	{ .compatible = "allwinner,sun8i-v3s-tcon", .data = &sun8i_v3s_quirks },
 	{ }
 };
-- 
2.15.1
