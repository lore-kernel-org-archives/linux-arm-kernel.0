From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Fri, 12 Jan 2018 13:16:04 +0100
Subject: [PATCH 10/14] ARM: stm32: Add AMBA support for STM32F4 and STM32F7
 SoCs
In-Reply-To: <1515759368-16946-1-git-send-email-patrice.chotard@st.com>
References: <1515759368-16946-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1515759368-16946-11-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

As both STM32F4 and STM32F7 SoCs embeds an AMBA PL180 mmci IP,
we need to enable AMBA support in mach-stm32.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/mach-stm32/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
index 0d1889b..f53a8db 100644
--- a/arch/arm/mach-stm32/Kconfig
+++ b/arch/arm/mach-stm32/Kconfig
@@ -13,16 +13,19 @@ config ARCH_STM32
 config MACH_STM32F429
 	bool "STMicrolectronics STM32F429"
 	depends on ARCH_STM32
+	select ARM_AMBA
 	default y
 
 config MACH_STM32F469
 	bool "STMicrolectronics STM32F469"
 	depends on ARCH_STM32
+	select ARM_AMBA
 	default y
 
 config MACH_STM32F746
 	bool "STMicrolectronics STM32F746"
 	depends on ARCH_STM32
+	select ARM_AMBA
 	default y
 
 config MACH_STM32H743
-- 
1.9.1
