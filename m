From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  5 Mar 2013 18:42:21 +0100
Subject: [PATCH 11/23] video/exynos: remove unnecessary header inclusions
In-Reply-To: <1362505353-8873-1-git-send-email-arnd@arndb.de>
References: <1362505353-8873-1-git-send-email-arnd@arndb.de>
Message-ID: <1362505353-8873-12-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In multiplatform configurations, we cannot include headers
provided by only the exynos platform. Fortunately a number
of drivers that include those headers do not actually need
them, so we can just remove the inclusions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/exynos/exynos_mipi_dsi.c          | 2 --
 drivers/video/exynos/exynos_mipi_dsi_common.c   | 2 --
 drivers/video/exynos/exynos_mipi_dsi_lowlevel.c | 2 --
 3 files changed, 6 deletions(-)

diff --git a/drivers/video/exynos/exynos_mipi_dsi.c b/drivers/video/exynos/exynos_mipi_dsi.c
index fac7df6..3dd43ca 100644
--- a/drivers/video/exynos/exynos_mipi_dsi.c
+++ b/drivers/video/exynos/exynos_mipi_dsi.c
@@ -35,8 +35,6 @@
 
 #include <video/exynos_mipi_dsim.h>
 
-#include <plat/fb.h>
-
 #include "exynos_mipi_dsi_common.h"
 #include "exynos_mipi_dsi_lowlevel.h"
 
diff --git a/drivers/video/exynos/exynos_mipi_dsi_common.c b/drivers/video/exynos/exynos_mipi_dsi_common.c
index c70cb89..520fc9b 100644
--- a/drivers/video/exynos/exynos_mipi_dsi_common.c
+++ b/drivers/video/exynos/exynos_mipi_dsi_common.c
@@ -31,8 +31,6 @@
 #include <video/mipi_display.h>
 #include <video/exynos_mipi_dsim.h>
 
-#include <mach/map.h>
-
 #include "exynos_mipi_dsi_regs.h"
 #include "exynos_mipi_dsi_lowlevel.h"
 #include "exynos_mipi_dsi_common.h"
diff --git a/drivers/video/exynos/exynos_mipi_dsi_lowlevel.c b/drivers/video/exynos/exynos_mipi_dsi_lowlevel.c
index 95cb99a..15c5abd 100644
--- a/drivers/video/exynos/exynos_mipi_dsi_lowlevel.c
+++ b/drivers/video/exynos/exynos_mipi_dsi_lowlevel.c
@@ -26,8 +26,6 @@
 
 #include <video/exynos_mipi_dsim.h>
 
-#include <mach/map.h>
-
 #include "exynos_mipi_dsi_regs.h"
 
 void exynos_mipi_dsi_func_reset(struct mipi_dsim_device *dsim)
-- 
1.8.1.2
