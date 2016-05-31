From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 30 May 2016 20:20:22 -0400
Subject: [PATCH] drm/exynos: fimd: don't set .has_hw_trigger in s3c6400 driver
 data
Message-ID: <1464654022-344-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The field value is only checked in fimd_setup_trigger() if .trg_type is
I80_HW_TRG so there's no point in setting this field for the s3c6400 if
is never going to be used since .trg_type is not set.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index 3efe1aa89416..1c23a8ff5e83 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -120,7 +120,6 @@ static struct fimd_driver_data s3c64xx_fimd_driver_data = {
 	.timing_base = 0x0,
 	.has_clksel = 1,
 	.has_limited_fmt = 1,
-	.has_hw_trigger = 1,
 };
 
 static struct fimd_driver_data exynos3_fimd_driver_data = {
-- 
2.5.5
