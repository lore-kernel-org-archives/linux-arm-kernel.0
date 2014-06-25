From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 25 Jun 2014 13:43:54 +0200
Subject: [PATCH v2 4/6] ARM: SAMSUNG: Restore Samsung PM Debug functionality
In-Reply-To: <1403618235-19353-5-git-send-email-t.figa@samsung.com>
References: <1403618235-19353-5-git-send-email-t.figa@samsung.com>
Message-ID: <1403696634-12779-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to recently merged patches and previous merge conflicts, the Samsung
PM Debug functionality no longer can be enabled. This patch fixes
incorrect dependency of SAMSUNG_PM_DEBUG on an integer symbol and adds
missing header inclusion.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/plat-samsung/Kconfig    | 5 +++--
 arch/arm/plat-samsung/pm-debug.c | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 301b892..ad9515f 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -413,8 +413,9 @@ config S5P_DEV_MFC
 comment "Power management"
 
 config SAMSUNG_PM_DEBUG
-	bool "S3C2410 PM Suspend debug"
-	depends on PM && DEBUG_KERNEL && DEBUG_S3C_UART
+	bool "Samsung PM Suspend debug"
+	depends on PM && DEBUG_KERNEL
+	depends on DEBUG_EXYNOS_UART || DEBUG_S3C24XX_UART || DEBUG_S3C2410_UART
 	help
 	  Say Y here if you want verbose debugging from the PM Suspend and
 	  Resume code. See <file:Documentation/arm/Samsung-S3C24XX/Suspend.txt>
diff --git a/arch/arm/plat-samsung/pm-debug.c b/arch/arm/plat-samsung/pm-debug.c
index 8f19f66..3960960 100644
--- a/arch/arm/plat-samsung/pm-debug.c
+++ b/arch/arm/plat-samsung/pm-debug.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/serial_core.h>
+#include <linux/serial_s3c.h>
 #include <linux/io.h>
 
 #include <asm/mach/map.h>
-- 
1.9.3
