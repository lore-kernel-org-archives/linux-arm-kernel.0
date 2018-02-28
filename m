From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Wed, 28 Feb 2018 14:10:57 +0100
Subject: [PATCH v2 3/4] ARM: stm32: Select ARM_MPU for cortex-M7 machines
In-Reply-To: <1519823458-27734-1-git-send-email-alexandre.torgue@st.com>
References: <1519823458-27734-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1519823458-27734-4-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

STM32 MCUs embed a Memory Protection Unit. Enabling ARM_MPU flag will
allow the Kernel to configure the MPU according to the devicetree.

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
index 713c068..c2ad8e9 100644
--- a/arch/arm/mach-stm32/Kconfig
+++ b/arch/arm/mach-stm32/Kconfig
@@ -29,15 +29,18 @@ config MACH_STM32F469
 config MACH_STM32F746
 	bool "STMicroelectronics STM32F746"
 	select ARM_AMBA
+	select ARM_MPU
 	default y
 
 config MACH_STM32F769
 	bool "STMicroelectronics STM32F769"
 	select ARM_AMBA
+	select ARM_MPU
 	default y
 
 config MACH_STM32H743
 	bool "STMicroelectronics STM32H743"
+	select ARM_MPU
 	default y
 
 endif # ARMv7-M
-- 
2.7.4
