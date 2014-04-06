From: pebolle@tiscali.nl (Paul Bolle)
Date: Sun, 06 Apr 2014 12:12:42 +0200
Subject: [PATCH] ARM: SAMSUNG: remove two unused S3C boot options
Message-ID: <1396779162.30640.14.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 19a964644f1e ("ARM: SAMSUNG: remove all custom uncompress.h")
removed the only users of S3C_BOOT_ERROR_RESET and
S3C_BOOT_UART_FORCE_FIFO. Remove their Kconfig entries too.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested.

 arch/arm/plat-samsung/Kconfig | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index b57e922f1614..f615c0e7b226 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -40,20 +40,6 @@ if PLAT_SAMSUNG
 
 comment "Boot options"
 
-config S3C_BOOT_ERROR_RESET
-	bool "S3C Reboot on decompression error"
-	help
-	  Say y here to use the watchdog to reset the system if the
-	  kernel decompressor detects an error during decompression.
-
-config S3C_BOOT_UART_FORCE_FIFO
-       bool "Force UART FIFO on during boot process"
-       default y
-       help
-         Say Y here to force the UART FIFOs on during the kernel
-	 uncompressor
-
-
 config S3C_LOWLEVEL_UART_PORT
 	int "S3C UART to use for low-level messages"
 	default 0
-- 
1.9.0
