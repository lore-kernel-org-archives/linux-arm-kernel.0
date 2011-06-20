From: tushar.behera@linaro.org (Tushar Behera)
Date: Mon, 20 Jun 2011 16:16:01 +0530
Subject: [PATCH 2/2] video: omap2: Compile omap2 support only when needed
In-Reply-To: <1308566761-2850-1-git-send-email-tushar.behera@linaro.org>
References: <1308566761-2850-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1308566761-2850-3-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently display support for omap2 is selected by default and
it gets built for all the configurations.

Instead of it being a built-in feature, it's compilation should
depend on the config option CONFIG_FB_OMAP2.

Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 drivers/video/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 8b83129..a19e44e 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -133,7 +133,7 @@ obj-$(CONFIG_FB_SH_MOBILE_HDMI)	  += sh_mobile_hdmi.o
 obj-$(CONFIG_FB_SH_MOBILE_MERAM)  += sh_mobile_meram.o
 obj-$(CONFIG_FB_SH_MOBILE_LCDC)	  += sh_mobile_lcdcfb.o
 obj-$(CONFIG_FB_OMAP)             += omap/
-obj-y                             += omap2/
+obj-$(CONFIG_FB_OMAP2)            += omap2/
 obj-$(CONFIG_XEN_FBDEV_FRONTEND)  += xen-fbfront.o
 obj-$(CONFIG_FB_CARMINE)          += carminefb.o
 obj-$(CONFIG_FB_MB862XX)	  += mb862xx/
-- 
1.7.4.1
