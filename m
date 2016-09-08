From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Thu,  8 Sep 2016 18:59:22 +0800
Subject: [PATCH] drm/sun4i: add missing header dependencies
Message-ID: <1473332362-25497-1-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We get 5 warnings when building kernel with W=1:
drivers/gpu/drm/sun4i/sun4i_framebuffer.c:33:23: warning: no previous prototype for 'sun4i_framebuffer_init' [-Wmissing-prototypes]
drivers/gpu/drm/sun4i/sun4i_framebuffer.c:47:6: warning: no previous prototype for 'sun4i_framebuffer_free' [-Wmissing-prototypes]
drivers/gpu/drm/sun4i/sun4i_rgb.c:202:5: warning: no previous prototype for 'sun4i_rgb_init' [-Wmissing-prototypes]
drivers/gpu/drm/sun4i/sun4i_dotclock.c:151:5: warning: no previous prototype for 'sun4i_dclk_create' [-Wmissing-prototypes]
drivers/gpu/drm/sun4i/sun4i_dotclock.c:186:5: warning: no previous prototype for 'sun4i_dclk_free' [-Wmissing-prototypes]

In fact, these functions are declared in
drivers/gpu/drm/sun4i/sun4i_framebuffer.h,
drivers/gpu/drm/sun4i/sun4i_rgb.h,
drivers/gpu/drm/sun4i/sun4i_dotclock.h,
so this patch adds missing header dependencies.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 drivers/gpu/drm/sun4i/sun4i_dotclock.c    | 1 +
 drivers/gpu/drm/sun4i/sun4i_framebuffer.c | 1 +
 drivers/gpu/drm/sun4i/sun4i_rgb.c         | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_dotclock.c b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
index 5b34631..4332da4 100644
--- a/drivers/gpu/drm/sun4i/sun4i_dotclock.c
+++ b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
@@ -14,6 +14,7 @@
 #include <linux/regmap.h>
 
 #include "sun4i_tcon.h"
+#include "sun4i_dotclock.h"
 
 struct sun4i_dclk {
 	struct clk_hw	hw;
diff --git a/drivers/gpu/drm/sun4i/sun4i_framebuffer.c b/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
index 70688fe..8b6ce619 100644
--- a/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
@@ -15,6 +15,7 @@
 #include <drm/drmP.h>
 
 #include "sun4i_drv.h"
+#include "sun4i_framebuffer.h"
 
 static void sun4i_de_output_poll_changed(struct drm_device *drm)
 {
diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index f5bbac6..3d11c48 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -19,6 +19,7 @@
 
 #include "sun4i_drv.h"
 #include "sun4i_tcon.h"
+#include "sun4i_rgb.h"
 
 struct sun4i_rgb {
 	struct drm_connector	connector;
-- 
2.7.4
