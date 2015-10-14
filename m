From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Wed, 14 Oct 2015 22:07:21 +0200
Subject: [PATCH 1/7] ARM: Kconfig: Introduce MACH_STM32F429 flag
In-Reply-To: <1444853247-31114-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1444853247-31114-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1444853247-31114-2-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces the MACH_STM32F429 to make possible to only select
STM32F429 pinctrl driver.

By default, all the MACH_STM32Fxxx flags will be set with STM32 defconfig.

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 arch/arm/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 72ad724..bf94e54 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -988,6 +988,11 @@ config ARCH_STM32
 	help
 	  Support for STMicroelectronics STM32 processors.
 
+config MACH_STM32F429
+	bool "STMicrolectronics STM32F429"
+	depends on ARCH_STM32
+	default y
+
 # Definitions to make life easier
 config ARCH_ACORN
 	bool
-- 
1.9.1
