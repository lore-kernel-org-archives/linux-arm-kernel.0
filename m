From: greenfoo@gluegarage.com (Fernando Ramos)
Date: Thu, 15 Nov 2018 23:16:24 +0100
Subject: [PATCH 4/9] drm: remove deprecated "drm_dev_unref" function
In-Reply-To: <20181115221634.22715-1-greenfoo@gluegarage.com>
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
Message-ID: <20181115221634.22715-5-greenfoo@gluegarage.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are no more places where this (deprecated) function is being used
from, thus it can now be removed.

Signed-off-by: Fernando Ramos <greenfoo@gluegarage.com>
---
 drivers/gpu/drm/drm_drv.c | 13 -------------
 include/drm/drm_drv.h     |  1 -
 2 files changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 36e8e9cbec52..22c8f8252207 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -706,19 +706,6 @@ void drm_dev_put(struct drm_device *dev)
 }
 EXPORT_SYMBOL(drm_dev_put);
 
-/**
- * drm_dev_unref - Drop reference of a DRM device
- * @dev: device to drop reference of or NULL
- *
- * This is a compatibility alias for drm_dev_put() and should not be used by new
- * code.
- */
-void drm_dev_unref(struct drm_device *dev)
-{
-	drm_dev_put(dev);
-}
-EXPORT_SYMBOL(drm_dev_unref);
-
 static int create_compat_control_link(struct drm_device *dev)
 {
 	struct drm_minor *minor;
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 3199ef70c007..abac47c10f1d 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -621,7 +621,6 @@ void drm_dev_unregister(struct drm_device *dev);
 
 void drm_dev_get(struct drm_device *dev);
 void drm_dev_put(struct drm_device *dev);
-void drm_dev_unref(struct drm_device *dev);
 void drm_put_dev(struct drm_device *dev);
 bool drm_dev_enter(struct drm_device *dev, int *idx);
 void drm_dev_exit(int idx);
-- 
2.19.1
