From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 12 Dec 2017 19:02:25 +0100
Subject: [PATCH 2/3] ARM: configs: stm32: Enable ARM_MPU
In-Reply-To: <1513101746-18030-1-git-send-email-alexandre.torgue@st.com>
References: <1513101746-18030-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1513101746-18030-3-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

STM32 MCUs embed a Memory Protection Unit. Enabling this setting will
allow the Kernel to configure the MPU according to devicetree.

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index bb358ff..e642bdf9 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -24,6 +24,7 @@ CONFIG_SET_MEM_PARAM=y
 CONFIG_DRAM_BASE=0x90000000
 CONFIG_FLASH_MEM_BASE=0x08000000
 CONFIG_FLASH_SIZE=0x00200000
+CONFIG_ARM_MPU=y
 CONFIG_PREEMPT=y
 # CONFIG_ATAGS is not set
 CONFIG_ZBOOT_ROM_TEXT=0x0
-- 
2.7.4
