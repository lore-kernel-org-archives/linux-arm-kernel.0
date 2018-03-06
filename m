From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue,  6 Mar 2018 20:15:56 +0900
Subject: [PATCH] pinctrl: stm32: add 'depends on HAS_IOMEM' to fix unmet
 dependency
Message-ID: <1520334956-9900-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These configs select MFD_SYSCON, but do not depend on HAS_IOMEM.

Compile testing on architecture without HAS_IOMEM causes "unmet
direct dependencies" in Kconfig phase.

Detected by "make ARCH=score allyesconfig".

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Arnd Bergmann and I discussed how to fix unmet dependency of MFD_SYSCON.
https://lkml.org/lkml/2018/2/27/284

We agreed to add 'depends on HAS_IOMEM' to drivers causing
unmet dependency.


 drivers/pinctrl/stm32/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/stm32/Kconfig b/drivers/pinctrl/stm32/Kconfig
index 1c4e00b2..cd3936e 100644
--- a/drivers/pinctrl/stm32/Kconfig
+++ b/drivers/pinctrl/stm32/Kconfig
@@ -11,37 +11,37 @@ config PINCTRL_STM32
 
 config PINCTRL_STM32F429
 	bool "STMicroelectronics STM32F429 pin control" if COMPILE_TEST && !MACH_STM32F429
-	depends on OF
+	depends on OF && HAS_IOMEM
 	default MACH_STM32F429
 	select PINCTRL_STM32
 
 config PINCTRL_STM32F469
 	bool "STMicroelectronics STM32F469 pin control" if COMPILE_TEST && !MACH_STM32F469
-	depends on OF
+	depends on OF && HAS_IOMEM
 	default MACH_STM32F469
 	select PINCTRL_STM32
 
 config PINCTRL_STM32F746
 	bool "STMicroelectronics STM32F746 pin control" if COMPILE_TEST && !MACH_STM32F746
-	depends on OF
+	depends on OF && HAS_IOMEM
 	default MACH_STM32F746
 	select PINCTRL_STM32
 
 config PINCTRL_STM32F769
 	bool "STMicroelectronics STM32F769 pin control" if COMPILE_TEST && !MACH_STM32F769
-	depends on OF
+	depends on OF && HAS_IOMEM
 	default MACH_STM32F769
 	select PINCTRL_STM32
 
 config PINCTRL_STM32H743
 	bool "STMicroelectronics STM32H743 pin control" if COMPILE_TEST && !MACH_STM32H743
-	depends on OF
+	depends on OF && HAS_IOMEM
 	default MACH_STM32H743
 	select PINCTRL_STM32
 
 config PINCTRL_STM32MP157
 	bool "STMicroelectronics STM32MP157 pin control" if COMPILE_TEST && !MACH_STM32MP157
-	depends on OF
+	depends on OF && HAS_IOMEM
 	default MACH_STM32MP157
 	select PINCTRL_STM32
 endif
-- 
2.7.4
