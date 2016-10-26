From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Wed, 26 Oct 2016 17:11:20 +0200
Subject: [PATCH 2/5] ARM: Kconfig: Introduce MACH_STM32F746 flag
In-Reply-To: <1477494683-29890-1-git-send-email-alexandre.torgue@st.com>
References: <1477494683-29890-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1477494683-29890-3-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces the MACH_STM32F746 to make possible to only select
STM32F746 pinctrl driver

By default, all the MACH_STM32Fxxx flags will be set with STM32 defconfig.

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b5d529f..4353765 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -887,6 +887,11 @@ config MACH_STM32F429
 	depends on ARCH_STM32
 	default y
 
+config MACH_STM32F746
+	bool "STMicrolectronics STM32F746"
+	depends on ARCH_STM32
+	default y
+
 config ARCH_MPS2
 	bool "ARM MPS2 platform"
 	depends on ARM_SINGLE_ARMV7M
-- 
1.9.1
