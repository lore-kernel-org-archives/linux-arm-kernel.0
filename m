From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:06 +0100
Subject: [PATCH 09/62] ARM: efm32: allow uncompress debug output
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-10-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

efm32 has no mach/uncompress.h, but we can trivially use
the fallback to the ll_debug code by just allowing this
option in Kconfig.

Found during randconfig testing.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Uwe Kleine-K?nig <kernel@pengutronix.de>
---
 arch/arm/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index dbb6f15..8983919 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1158,7 +1158,7 @@ config DEBUG_UNCOMPRESS
 config UNCOMPRESS_INCLUDE
 	string
 	default "debug/uncompress.h" if ARCH_MULTIPLATFORM || ARCH_MSM || \
-					ARCH_EXYNOS
+					ARCH_EXYNOS || ARCH_EFM32
 	default "mach/uncompress.h"
 
 config EARLY_PRINTK
-- 
1.8.3.2
