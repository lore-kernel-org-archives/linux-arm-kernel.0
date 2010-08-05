From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  5 Aug 2010 16:08:37 +0200
Subject: [PATCH 03/19] ARM: omap: move omap_init_fb to .init.text
In-Reply-To: <20100805140813.GA13859@pengutronix.de>
References: <20100805140813.GA13859@pengutronix.de>
Message-ID: <1281017333-5563-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

omap_init_fb() is only called as arch_initcall and so can live in
.init.text.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-omap/fb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/fb.c b/arch/arm/plat-omap/fb.c
index 0054b95..a727133 100644
--- a/arch/arm/plat-omap/fb.c
+++ b/arch/arm/plat-omap/fb.c
@@ -336,7 +336,7 @@ void omapfb_set_ctrl_platform_data(void *data)
 	omapfb_config.ctrl_platform_data = data;
 }
 
-static inline int omap_init_fb(void)
+static int __init omap_init_fb(void)
 {
 	const struct omap_lcd_config *conf;
 
@@ -381,7 +381,7 @@ void omapfb_set_platform_data(struct omapfb_platform_data *data)
 	omapfb_config = *data;
 }
 
-static inline int omap_init_fb(void)
+static int __init omap_init_fb(void)
 {
 	return platform_device_register(&omap_fb_device);
 }
-- 
1.7.1
