From: thomas.ab@samsung.com (Thomas Abraham)
Date: Tue, 27 Mar 2012 15:46:44 +0530
Subject: [PATCH] ARM: Samsung: Make PM_GENERIC_DOMAINS config depend on
 CONFIG_PM
In-Reply-To: <1332843404-25476-1-git-send-email-thomas.ab@samsung.com>
References: <1332843404-25476-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <1332843404-25476-2-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For s3c64xx and exynos platforms, make the selection of PM_GENERIC_DOMAINS
depend on the CONFIG_PM.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/mach-exynos/Kconfig  |    2 +-
 arch/arm/mach-s3c64xx/Kconfig |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 0491cee..6c8f17b 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -35,7 +35,7 @@ config CPU_EXYNOS4210
 	select ARM_CPU_SUSPEND if PM
 	select S5P_PM if PM
 	select S5P_SLEEP if PM
-	select PM_GENERIC_DOMAINS
+	select PM_GENERIC_DOMAINS if PM
 	help
 	  Enable EXYNOS4210 CPU support
 
diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 82c0915..2609349 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -8,7 +8,7 @@ config PLAT_S3C64XX
 	bool
 	depends on ARCH_S3C64XX
 	select SAMSUNG_WAKEMASK
-	select PM_GENERIC_DOMAINS
+	select PM_GENERIC_DOMAINS if PM
 	default y
 	help
 	  Base platform code for any Samsung S3C64XX device
-- 
1.6.6.rc2
