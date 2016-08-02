From: baolex.ni@intel.com (Baole Ni)
Date: Tue,  2 Aug 2016 18:48:31 +0800
Subject: [PATCH 0194/1285] Replace numeric parameter like 0444 with macro
Message-ID: <20160802104831.26685-1-baolex.ni@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index 608b0af..8f1bd21 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -269,7 +269,7 @@ static ssize_t vidi_store_connection(struct device *dev,
 	return len;
 }
 
-static DEVICE_ATTR(connection, 0644, vidi_show_connection,
+static DEVICE_ATTR(connection, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, vidi_show_connection,
 			vidi_store_connection);
 
 int vidi_connection_ioctl(struct drm_device *drm_dev, void *data,
-- 
2.9.2
