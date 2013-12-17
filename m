From: kgene@kernel.org (kgene at kernel.org)
Date: Tue, 17 Dec 2013 20:53:13 +0900
Subject: [PATCH 11/11] PM / devfreq: use inclusion <mach/map.h> instead of
 <plat/map-s5p.h>
Message-ID: <116901cefb1e$90f4b530$b2de1f90$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kukjin Kim <kgene.kim@samsung.com>

This fixes follwoing warning:
In file included from drivers/devfreq/exynos/exynos4_bus.h:15:0,
                 from drivers/devfreq/exynos/exynos4_bus.c:35:
arch/arm/mach-exynos/include/mach/map.h:22:0: warning: "S3C_UART_OFFSET"
redefined [enabled by default]
In file included from drivers/devfreq/exynos/exynos4_bus.c:33:0:
arch/arm/plat-samsung/include/plat/map-s5p.h:57:0: note: this is the
location of the previous definition

Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/devfreq/exynos/exynos4_bus.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/exynos/exynos4_bus.c
b/drivers/devfreq/exynos/exynos4_bus.c
index 16eb406..1ab8cdd 100644
--- a/drivers/devfreq/exynos/exynos4_bus.c
+++ b/drivers/devfreq/exynos/exynos4_bus.c
@@ -30,7 +30,7 @@
 extern unsigned int exynos_result_of_asv;
 #endif
 
-#include <plat/map-s5p.h>
+#include <mach/map.h>
 
 #include "exynos4_bus.h"
 
-- 
1.7.10.4
