From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  5 Mar 2013 18:42:22 +0100
Subject: [PATCH 12/23] thermal/exynos: remove unnecessary header inclusions
In-Reply-To: <1362505353-8873-1-git-send-email-arnd@arndb.de>
References: <1362505353-8873-1-git-send-email-arnd@arndb.de>
Message-ID: <1362505353-8873-13-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In multiplatform configurations, we cannot include headers
provided by only the exynos platform. Fortunately a number
of drivers that include those headers do not actually need
them, so we can just remove the inclusions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/thermal/exynos_thermal.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/exynos_thermal.c b/drivers/thermal/exynos_thermal.c
index e04ebd8..8dd7984 100644
--- a/drivers/thermal/exynos_thermal.c
+++ b/drivers/thermal/exynos_thermal.c
@@ -39,8 +39,6 @@
 #include <linux/cpu_cooling.h>
 #include <linux/of.h>
 
-#include <plat/cpu.h>
-
 /* Exynos generic registers */
 #define EXYNOS_TMU_REG_TRIMINFO		0x0
 #define EXYNOS_TMU_REG_CONTROL		0x20
-- 
1.8.1.2
