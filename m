From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Tue, 31 Jan 2017 14:14:21 +0100
Subject: [PATCH 4/8] ARM: stm32: create dedicated kconfig for STM32 machine
In-Reply-To: <1485868465-30446-1-git-send-email-alexandre.torgue@st.com>
References: <1485868465-30446-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1485868465-30446-5-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create a dedicated Kconfig file in mach-stm32/ and move existing stm32
configs inside.

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5fab553..e84936c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -813,6 +813,8 @@ source "arch/arm/mach-spear/Kconfig"
 
 source "arch/arm/mach-sti/Kconfig"
 
+source "arch/arm/mach-stm32/Kconfig"
+
 source "arch/arm/mach-s3c24xx/Kconfig"
 
 source "arch/arm/mach-s3c64xx/Kconfig"
@@ -871,28 +873,6 @@ config ARCH_LPC18XX
 	  Support for NXP's LPC18xx Cortex-M3 and LPC43xx Cortex-M4
 	  high performance microcontrollers.
 
-config ARCH_STM32
-	bool "STMicrolectronics STM32"
-	depends on ARM_SINGLE_ARMV7M
-	select ARCH_HAS_RESET_CONTROLLER
-	select ARMV7M_SYSTICK
-	select CLKSRC_STM32
-	select PINCTRL
-	select RESET_CONTROLLER
-	select STM32_EXTI
-	help
-	  Support for STMicroelectronics STM32 processors.
-
-config MACH_STM32F429
-	bool "STMicrolectronics STM32F429"
-	depends on ARCH_STM32
-	default y
-
-config MACH_STM32F746
-	bool "STMicrolectronics STM32F746"
-	depends on ARCH_STM32
-	default y
-
 config ARCH_MPS2
 	bool "ARM MPS2 platform"
 	depends on ARM_SINGLE_ARMV7M
diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
new file mode 100644
index 0000000..40115fa
--- /dev/null
+++ b/arch/arm/mach-stm32/Kconfig
@@ -0,0 +1,21 @@
+config ARCH_STM32
+	bool "STMicrolectronics STM32"
+	depends on ARM_SINGLE_ARMV7M
+	select ARCH_HAS_RESET_CONTROLLER
+	select ARMV7M_SYSTICK
+	select CLKSRC_STM32
+	select PINCTRL
+	select RESET_CONTROLLER
+	select STM32_EXTI
+	help
+	  Support for STMicroelectronics STM32 processors.
+
+config MACH_STM32F429
+	bool "STMicrolectronics STM32F429"
+	depends on ARCH_STM32
+	default y
+
+config MACH_STM32F746
+	bool "STMicrolectronics STM32F746"
+	depends on ARCH_STM32
+	default y
-- 
1.9.1
