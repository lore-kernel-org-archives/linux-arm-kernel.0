From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Sat, 30 May 2015 08:54:05 +0100
Subject: [PATCH v2 1/4] ARM: stm32: Enable clock source
In-Reply-To: <1432972448-10332-1-git-send-email-daniel.thompson@linaro.org>
References: <1432327273-6810-1-git-send-email-daniel.thompson@linaro.org>
 <1432972448-10332-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1432972448-10332-2-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently STM32F4 systems do not complete the boot process. This is
trivially fixed by enabling a suitable clock source when ARCH_STM32 is
set.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e717642..462c1ee 100644
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
2.1.0
