From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Thu, 14 Jan 2016 13:16:27 +0100
Subject: [PATCH v4 1/9] ARM: Kconfig: Introduce MACH_STM32F429 flag
In-Reply-To: <1452773795-24216-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1452773795-24216-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1452773795-24216-2-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces the MACH_STM32F429 to make possible to only select
STM32F429 pinctrl driver.

By default, all the MACH_STM32Fxxx flags will be set with STM32 defconfig.

Acked-by: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 arch/arm/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 34e1569..b7aa567 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -969,6 +969,11 @@ config ARCH_STM32
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
