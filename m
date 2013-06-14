From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 14 Jun 2013 21:32:38 +0200
Subject: [PATCH 02/28] ARM: EXYNOS: Make ARCH_EXYNOS select USE_OF
In-Reply-To: <1371238384-1504-1-git-send-email-t.figa@samsung.com>
References: <1371238384-1504-1-git-send-email-t.figa@samsung.com>
Message-ID: <1371238384-1504-3-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since EXYNOS is now DT-only, it always requires USE_OF option to be
selected. This patch moves USE_OF selection from entries of DT board
files to ARCH_EXYNOS.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/Kconfig             | 1 +
 arch/arm/mach-exynos/Kconfig | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0574901..a29fc7e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -796,6 +796,7 @@ config ARCH_EXYNOS
 	select HAVE_S3C_RTC if RTC_CLASS
 	select NEED_MACH_GPIO_H
 	select NEED_MACH_MEMORY_H
+	select USE_OF
 	help
 	  Support for SAMSUNG's EXYNOS SoCs (EXYNOS4/5)
 
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index e101b14..0d93ebe 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -101,7 +101,6 @@ config MACH_EXYNOS4_DT
 	select CPU_EXYNOS4210
 	select KEYBOARD_SAMSUNG if INPUT_KEYBOARD
 	select S5P_DEV_MFC
-	select USE_OF
 	help
 	  Machine support for Samsung Exynos4 machine with device tree enabled.
 	  Select this if a fdt blob is available for the Exynos4 SoC based board.
@@ -115,7 +114,6 @@ config MACH_EXYNOS5_DT
 	select ARM_AMBA
 	select CLKSRC_OF
 	select USB_ARCH_HAS_XHCI
-	select USE_OF
 	help
 	  Machine support for Samsung EXYNOS5 machine with device tree enabled.
 	  Select this if a fdt blob is available for the EXYNOS5 SoC based board.
-- 
1.8.2.1
