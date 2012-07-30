From: l.krishna@samsung.com (Leela Krishna Amudala)
Date: Mon, 30 Jul 2012 14:15:05 +0530
Subject: [PATCH 3/3] driver: Include the modified FIMD header file
In-Reply-To: <1343637905-17764-1-git-send-email-l.krishna@samsung.com>
References: <1343637905-17764-1-git-send-email-l.krishna@samsung.com>
Message-ID: <1343637905-17764-4-git-send-email-l.krishna@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The fimd register headers have been moved to include/video/
hence, modifying the driver files accordingly.

Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_fimd.c |    2 +-
 drivers/video/s3c-fb.c                   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index 29fdbfe..8da90f9 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -20,7 +20,7 @@
 #include <linux/pm_runtime.h>
 
 #include <drm/exynos_drm.h>
-#include <plat/regs-fb-v4.h>
+#include <video/samsung_fimd.h>
 
 #include "exynos_drm_drv.h"
 #include "exynos_drm_fbdev.h"
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 69bf9d0..1226fdd 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -26,7 +26,7 @@
 #include <linux/pm_runtime.h>
 
 #include <mach/map.h>
-#include <plat/regs-fb-v4.h>
+#include <video/samsung_fimd.h>
 #include <plat/fb.h>
 
 /* This driver will export a number of framebuffer interfaces depending
-- 
1.7.0.4
