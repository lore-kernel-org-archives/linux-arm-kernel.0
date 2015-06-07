From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Sun,  7 Jun 2015 11:08:33 +0200
Subject: [PATCH RESEND] ARM: Kconfig: Select clocksource in STM32 entry
Message-ID: <1433668113-10389-1-git-send-email-mcoquelin.stm32@gmail.com>
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
