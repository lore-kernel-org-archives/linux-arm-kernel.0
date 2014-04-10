From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Thu, 10 Apr 2014 14:25:47 +0200
Subject: [PATCH v2 5/5] ARM: sunxi: update the default ARCH_NR_GPIO for sunxi
 arch
In-Reply-To: <1397132747-13917-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1397132747-13917-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1397132747-13917-6-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 SoC has PL and PM banks, we thus need to increase the default
ARCH_NR_GPIO when building for the sunxi architecture.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 503da0a..fe915ea 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1628,9 +1628,9 @@ config ARCH_NR_GPIO
 	int
 	default 1024 if ARCH_SHMOBILE || ARCH_TEGRA
 	default 512 if ARCH_EXYNOS || ARCH_KEYSTONE || SOC_OMAP5 || SOC_DRA7XX || ARCH_S3C24XX || ARCH_S3C64XX
+	default 416 if ARCH_SUNXI
 	default 392 if ARCH_U8500
 	default 352 if ARCH_VT8500
-	default 288 if ARCH_SUNXI
 	default 264 if MACH_H4700
 	default 0
 	help
-- 
1.8.3.2
