From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Apr 2013 02:04:53 +0200
Subject: [PATCH 11/30] [media] exynos: remove unnecessary header inclusions
In-Reply-To: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
Message-ID: <1365638712-1028578-12-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In multiplatform configurations, we cannot include headers
provided by only the exynos platform. Fortunately a number
of drivers that include those headers do not actually need
them, so we can just remove the inclusions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: linux-media at vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
---
 drivers/media/platform/exynos-gsc/gsc-regs.c | 1 -
 drivers/media/platform/s5p-tv/sii9234_drv.c  | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/drivers/media/platform/exynos-gsc/gsc-regs.c b/drivers/media/platform/exynos-gsc/gsc-regs.c
index 6f5b5a4..e22d147 100644
--- a/drivers/media/platform/exynos-gsc/gsc-regs.c
+++ b/drivers/media/platform/exynos-gsc/gsc-regs.c
@@ -12,7 +12,6 @@
 
 #include <linux/io.h>
 #include <linux/delay.h>
-#include <mach/map.h>
 
 #include "gsc-core.h"
 
diff --git a/drivers/media/platform/s5p-tv/sii9234_drv.c b/drivers/media/platform/s5p-tv/sii9234_drv.c
index d90d228..39b77d2 100644
--- a/drivers/media/platform/s5p-tv/sii9234_drv.c
+++ b/drivers/media/platform/s5p-tv/sii9234_drv.c
@@ -23,9 +23,6 @@
 #include <linux/regulator/machine.h>
 #include <linux/slab.h>
 
-#include <mach/gpio.h>
-#include <plat/gpio-cfg.h>
-
 #include <media/sii9234.h>
 #include <media/v4l2-subdev.h>
 
-- 
1.8.1.2
