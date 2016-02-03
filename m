From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Wed,  3 Feb 2016 12:04:37 +0100
Subject: [PATCH v5 1/9] ARM: Kconfig: Introduce MACH_STM32F429 flag
In-Reply-To: <1454497485-464-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1454497485-464-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1454497485-464-2-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces the MACH_STM32F429 to make possible to only select
STM32F429 pinctrl driver.

By default, all the MACH_STM32Fxxx flags will be set with STM32 defconfig.

Acked-by: Patrice Chotard <patrice.chotard@st.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 arch/arm/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4f799e5..ca16120 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -883,6 +883,11 @@ config ARCH_STM32
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
