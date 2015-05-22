From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Fri, 22 May 2015 23:50:52 +0200
Subject: [PATCH] ARM: Kconfig: Select clocksource in STM32 entry
Message-ID: <1432331452-2350-1-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

STM32 clocksource driver needs to be selected if ARCH_STM32.

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
Hi Arnd,

  This patch applies on top of arm-soc's next/soc branch, so that you don't 
get conflicts with Stefan's ARM_SINGLE_ARMV7M patch.

Regards,
Maxime
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b7a7d15..1cb59af 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -978,6 +978,7 @@ config ARCH_STM32
 	depends on ARM_SINGLE_ARMV7M
 	select ARCH_HAS_RESET_CONTROLLER
 	select ARMV7M_SYSTICK
+	select CLKSRC_STM32
 	select RESET_CONTROLLER
 	help
 	  Support for STMicroelectronics STM32 processors.
-- 
1.9.1
