From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Tue,  8 Sep 2015 22:38:05 +0200
Subject: [PATCH v2 2/3] ARM: configs: Set FORCE_MAX_ZONE_ORDER to 9 in
 stm32_defconfig
In-Reply-To: <1441744686-20521-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1441744686-20521-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1441744686-20521-3-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

STM32 boards having small amount of RAM, we can optimize by reducing
max order page blocks size.

Suggested-by: Andreas F?rber <afaerber@suse.de>
Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 arch/arm/configs/stm32_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index 4725fab..9fe3b39 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -25,6 +25,7 @@ CONFIG_DRAM_BASE=0x90000000
 CONFIG_FLASH_MEM_BASE=0x08000000
 CONFIG_FLASH_SIZE=0x00200000
 CONFIG_PREEMPT=y
+CONFIG_FORCE_MAX_ZONEORDER=9
 # CONFIG_ATAGS is not set
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-- 
1.9.1
