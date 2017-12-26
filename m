From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 26 Dec 2017 14:07:18 +0100
Subject: [RESEND PATCH v2 1/2] drm/exynos/decon: Move headers from global to
 local place
Message-ID: <1514293639-18785-1-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DECON headers contain only defines for registers.  There are no
other drivers using them so this should be put locally to the Exynos DRM
driver.  Keeping headers local helps managing the code.

Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Resend after half a year...

Changes since v1:
1. Just re-order patches in patchset.
---
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c                          | 3 +--
 drivers/gpu/drm/exynos/exynos7_drm_decon.c                             | 2 +-
 .../exynos5433_decon.h => drivers/gpu/drm/exynos/regs-decon5433.h      | 0
 include/video/exynos7_decon.h => drivers/gpu/drm/exynos/regs-decon7.h  | 3 +--
 4 files changed, 3 insertions(+), 5 deletions(-)
 rename include/video/exynos5433_decon.h => drivers/gpu/drm/exynos/regs-decon5433.h (100%)
 rename include/video/exynos7_decon.h => drivers/gpu/drm/exynos/regs-decon7.h (99%)

diff --git a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
index 6be5b53c3b27..1427c385bddc 100644
--- a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
@@ -21,13 +21,12 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
-#include <video/exynos5433_decon.h>
-
 #include "exynos_drm_drv.h"
 #include "exynos_drm_crtc.h"
 #include "exynos_drm_fb.h"
 #include "exynos_drm_plane.h"
 #include "exynos_drm_iommu.h"
+#include "regs-decon5433.h"
 
 #define DSD_CFG_MUX 0x1004
 #define DSD_CFG_MUX_TE_UNMASK_GLOBAL BIT(13)
diff --git a/drivers/gpu/drm/exynos/exynos7_drm_decon.c b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
index 615efcf7782a..3931d5e33fe0 100644
--- a/drivers/gpu/drm/exynos/exynos7_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
@@ -25,13 +25,13 @@
 
 #include <video/of_display_timing.h>
 #include <video/of_videomode.h>
-#include <video/exynos7_decon.h>
 
 #include "exynos_drm_crtc.h"
 #include "exynos_drm_plane.h"
 #include "exynos_drm_drv.h"
 #include "exynos_drm_fb.h"
 #include "exynos_drm_iommu.h"
+#include "regs-decon7.h"
 
 /*
  * DECON stands for Display and Enhancement controller.
diff --git a/include/video/exynos5433_decon.h b/drivers/gpu/drm/exynos/regs-decon5433.h
similarity index 100%
rename from include/video/exynos5433_decon.h
rename to drivers/gpu/drm/exynos/regs-decon5433.h
diff --git a/include/video/exynos7_decon.h b/drivers/gpu/drm/exynos/regs-decon7.h
similarity index 99%
rename from include/video/exynos7_decon.h
rename to drivers/gpu/drm/exynos/regs-decon7.h
index a62b11b613f6..339ea1007ff5 100644
--- a/include/video/exynos7_decon.h
+++ b/drivers/gpu/drm/exynos/regs-decon7.h
@@ -1,5 +1,4 @@
-/* include/video/exynos7_decon.h
- *
+/*
  * Copyright (c) 2014 Samsung Electronics Co., Ltd.
  * Author: Ajay Kumar <ajaykumar.rs@samsung.com>
  *
-- 
2.7.4
