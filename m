From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Apr 2016 15:13:10 +0200
Subject: [PATCH] ARM: debug: remove extraneous DEBUG_HI3716_UART option
Message-ID: <1461590006-1395429-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DEBUG_HI3716_UART was supposed to be renamed to DEBUG_HIX5HD2_UART, but
accidentally both got left in place, which results in a build error when
CONFIG_DEBUG_UART_PHYS is not set as it should be.

This removes the old symbol.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 12aae3097454 ("ARM: debug: Rename Hi3716 to HIX5HD2")
---
 arch/arm/Kconfig.debug | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 6993978cfd6f..2afd38766707 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -268,14 +268,6 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on HI3620 UART.
 
-	config DEBUG_HI3716_UART
-		bool "Hisilicon Hi3716 Debug UART"
-		depends on ARCH_HI3xxx
-		select DEBUG_UART_PL01X
-		help
-		  Say Y here if you want kernel low-level debugging support
-		  on HI3716 UART.
-
 	config DEBUG_HIGHBANK_UART
 		bool "Kernel low-level debugging messages via Highbank UART"
 		depends on ARCH_HIGHBANK
-- 
2.7.0
