From: jsarha@ti.com (Jyri Sarha)
Date: Wed, 31 Aug 2016 16:14:06 +0300
Subject: [PATCH v3 1/8] drm/tilcdc: Remove
 drm_helper_disable_unused_functions() call
In-Reply-To: <cover.1472634657.git.jsarha@ti.com>
References: <cover.1472634657.git.jsarha@ti.com>
Message-ID: <bcad1c1d6d91630b9e6302a406de2995bbbcc802.1472634657.git.jsarha@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drm_helper_disable_unused_functions() should not be called by atomic
drivers.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 3404d24..e45c268 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -361,8 +361,6 @@ static int tilcdc_load(struct drm_device *dev, unsigned long flags)
 			break;
 	}
 
-	drm_helper_disable_unused_functions(dev);
-
 	drm_mode_config_reset(dev);
 
 	priv->fbdev = drm_fbdev_cma_init(dev, bpp,
-- 
1.9.1
