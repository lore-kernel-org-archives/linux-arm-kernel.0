From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:49 +0100
Subject: [PATCH 52/62] ARM: samsung: disable decompressor watchdog on exynos
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-53-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The S3C_BOOT_ERROR_RESET option only works when using the
samsung specific mach/uncompress.h implementation. The
Exynos platform has now moved on to using the generic
implementation instead, which does not support this.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-samsung/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 58645a5..04974db 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -42,6 +42,7 @@ comment "Boot options"
 
 config S3C_BOOT_ERROR_RESET
 	bool "S3C Reboot on decompression error"
+	depends on PLAT_S5P || PLAT_S3C24XX || ARCH_S3C64XX
 	help
 	  Say y here to use the watchdog to reset the system if the
 	  kernel decompressor detects an error during decompression.
-- 
1.8.3.2
