From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 17 Jun 2013 18:34:06 +0200
Subject: [PATCH v2 21/38] ARM: EXYNOS: Do not select legacy Kconfig symbols any
 more
In-Reply-To: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
References: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
Message-ID: <1371486863-12398-22-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes selection of several legacy Kconfig symbols from
ARCH_EXYNOS to bypass compilation of code used only for ATAGS based
boot.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b3560c2..61dff79 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -802,15 +802,11 @@ config ARCH_EXYNOS
 	select COMMON_CLK
 	select CPU_V7
 	select GENERIC_CLOCKEVENTS
-	select GPIO_SAMSUNG
 	select HAVE_CLK
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select HAVE_S3C_RTC if RTC_CLASS
-	select NEED_MACH_GPIO_H
 	select NEED_MACH_MEMORY_H
-	select S5P_GPIO_DRVSTR
-	select SAMSUNG_ATAGS
 	select USE_OF
 	help
 	  Support for SAMSUNG's EXYNOS SoCs (EXYNOS4/5)
-- 
1.8.2.1
