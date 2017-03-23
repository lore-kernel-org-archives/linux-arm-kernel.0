From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Thu, 23 Mar 2017 11:09:06 +0100
Subject: [PATCH] ARM: configs: stm32: Set CPU_V7M_NUM_IRQ to max value
Message-ID: <1490263746-10512-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

stm32_defconfig is used for several STM32 MCU: STM32F429, STM32F469,
STM32F746 and now STM32H743. Each of MCU listed have different interrupts
number mapped on NVIC. STM32F429: 81, STM32F469: 92, STM32F746: 97 and
STM32H743: 149. I could set CPU_V7M_NUM_IRQ to 149 but in order to avoid
forgetting to update this value for next STM32 MCU I prefer to set it to
max value: 240.

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index a9d8e3c..7c9c157 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -20,6 +20,7 @@ CONFIG_EMBEDDED=y
 # CONFIG_MMU is not set
 CONFIG_ARM_SINGLE_ARMV7M=y
 CONFIG_ARCH_STM32=y
+CONFIG_CPU_V7M_NUM_IRQ=240
 CONFIG_SET_MEM_PARAM=y
 CONFIG_DRAM_BASE=0x90000000
 CONFIG_FLASH_MEM_BASE=0x08000000
-- 
1.9.1
