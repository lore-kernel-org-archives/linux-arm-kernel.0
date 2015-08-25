From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Tue, 25 Aug 2015 22:07:17 +0200
Subject: [PATCH] ARM: stm32: Reduce FORCE_MAX_ZONEORDER to 9
Message-ID: <1440533237-5831-1-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

STM32 boards having small amount of RAM, we can optimize by reducing max order
page blocks size.

Suggested-by: Andreas F?rber <afaerber@suse.de>
Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a750c14..57d53af 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1734,7 +1734,7 @@ config FORCE_MAX_ZONEORDER
 	int "Maximum zone order" if ARCH_SHMOBILE_LEGACY
 	range 11 64 if ARCH_SHMOBILE_LEGACY
 	default "12" if SOC_AM33XX
-	default "9" if SA1111 || ARCH_EFM32
+	default "9" if SA1111 || ARCH_EFM32 || ARCH_STM32
 	default "11"
 	help
 	  The kernel memory allocator divides physically contiguous memory
-- 
1.9.1
