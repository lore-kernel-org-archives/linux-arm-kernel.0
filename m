From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  5 Jun 2014 11:06:12 +0200
Subject: [PATCH 4/5] ARM: nommu: drop unused Kconfig symbol DRAM_SIZE
In-Reply-To: <1401959173-13117-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1401959173-13117-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1401959173-13117-5-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the previous commit the last user of DRAM_SIZE is gone.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/Kconfig-nommu             | 4 ----
 arch/arm/configs/at91x40_defconfig | 1 -
 arch/arm/configs/efm32_defconfig   | 1 -
 3 files changed, 6 deletions(-)

diff --git a/arch/arm/Kconfig-nommu b/arch/arm/Kconfig-nommu
index aed66d5df7f1..77c749227002 100644
--- a/arch/arm/Kconfig-nommu
+++ b/arch/arm/Kconfig-nommu
@@ -13,10 +13,6 @@ config DRAM_BASE
 	hex '(S)DRAM Base Address' if SET_MEM_PARAM
 	default 0x00800000
 
-config DRAM_SIZE
-	hex '(S)DRAM SIZE' if SET_MEM_PARAM
-	default 0x00800000
-
 config FLASH_MEM_BASE
 	hex 'FLASH Base Address' if SET_MEM_PARAM
 	default 0x00400000
diff --git a/arch/arm/configs/at91x40_defconfig b/arch/arm/configs/at91x40_defconfig
index c55e9212fcbb..31f15a2db3ea 100644
--- a/arch/arm/configs/at91x40_defconfig
+++ b/arch/arm/configs/at91x40_defconfig
@@ -20,7 +20,6 @@ CONFIG_AT91_EARLY_USART0=y
 CONFIG_CPU_ARM7TDMI=y
 CONFIG_SET_MEM_PARAM=y
 CONFIG_DRAM_BASE=0x01000000
-CONFIG_DRAM_SIZE=0x00400000
 CONFIG_FLASH_MEM_BASE=0x01400000
 CONFIG_PROCESSOR_ID=0x14000040
 CONFIG_ZBOOT_ROM_TEXT=0x0
diff --git a/arch/arm/configs/efm32_defconfig b/arch/arm/configs/efm32_defconfig
index f59fffb3d0c6..c5cbe56e7873 100644
--- a/arch/arm/configs/efm32_defconfig
+++ b/arch/arm/configs/efm32_defconfig
@@ -20,7 +20,6 @@ CONFIG_ARCH_EFM32=y
 # CONFIG_KUSER_HELPERS is not set
 CONFIG_SET_MEM_PARAM=y
 CONFIG_DRAM_BASE=0x88000000
-CONFIG_DRAM_SIZE=0x00400000
 CONFIG_FLASH_MEM_BASE=0x8c000000
 CONFIG_FLASH_SIZE=0x01000000
 CONFIG_PREEMPT=y
-- 
2.0.0.rc2
