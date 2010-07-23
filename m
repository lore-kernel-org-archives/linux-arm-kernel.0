From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 23 Jul 2010 21:58:27 +0200
Subject: [PATCH 04/11] ARM: omap: move omap_init_fb to .init.text
In-Reply-To: <1279915120-4373-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1279915120-4373-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1279915120-4373-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

omap_init_fb() is only called as arch_initcall and so can live in
.init.text.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-omap/fb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/fb.c b/arch/arm/plat-omap/fb.c
index d3eea4f..e8a390d 100644
--- a/arch/arm/plat-omap/fb.c
+++ b/arch/arm/plat-omap/fb.c
@@ -307,7 +307,7 @@ void omapfb_set_ctrl_platform_data(void *data)
 	omapfb_config.ctrl_platform_data = data;
 }
 
-static inline int omap_init_fb(void)
+static int __init omap_init_fb(void)
 {
 	const struct omap_lcd_config *conf;
 
@@ -352,7 +352,7 @@ void omapfb_set_platform_data(struct omapfb_platform_data *data)
 	omapfb_config = *data;
 }
 
-static inline int omap_init_fb(void)
+static int __init omap_init_fb(void)
 {
 	return platform_device_register(&omap_fb_device);
 }
-- 
1.7.1
