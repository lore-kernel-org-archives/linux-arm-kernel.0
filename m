From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 4 May 2018 15:01:47 +0200
Subject: [PATCH] ARM: stm32: Select DMA, DMAMUX and MDMA support on STM32MP157C
Message-ID: <1525438907-17190-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

This patch select DMA, DMAMUX and MDMA support for STM32MP157C machine.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

---

Hi Arnd, Kevin and Olof,

I merged several patchs in one so I just have this patch for STM32 SoC update,
so please consider it as my STM32 SOC pull request for v4.18.

Thanks

Alex


diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
index 713c068..82a93b8 100644
--- a/arch/arm/mach-stm32/Kconfig
+++ b/arch/arm/mach-stm32/Kconfig
@@ -46,6 +46,9 @@ if ARCH_MULTI_V7
 
 config MACH_STM32MP157
 	bool "STMicroelectronics STM32MP157"
+	select STM32_DMA
+	select STM32_DMAMUX
+	select STM32_MDMA
 	default y
 
 endif # ARMv7-A
-- 
2.7.4
