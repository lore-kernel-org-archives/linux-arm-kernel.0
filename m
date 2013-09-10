From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 10 Sep 2013 18:53:35 +0530
Subject: [PATCH] ARM: davinci: fix build breakage with DEBUG_LL
Message-ID: <1378819415-28666-1-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit fcf7157 ("ARM: davinci: serial: get rid of davinci_uart_config")
introduced build breakage because of a misplaced
header file include which cause a bunch of errors when
the file is included in assembly code (like debug-macro.S)

Fix the build breakage.

Reported-by: Alexander Holler <holler@ahsoftware.de>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
Applies to latest linus/master

 arch/arm/mach-davinci/include/mach/serial.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/serial.h b/arch/arm/mach-davinci/include/mach/serial.h
index 52b8571..ce402cd 100644
--- a/arch/arm/mach-davinci/include/mach/serial.h
+++ b/arch/arm/mach-davinci/include/mach/serial.h
@@ -15,8 +15,6 @@
 
 #include <mach/hardware.h>
 
-#include <linux/platform_device.h>
-
 #define DAVINCI_UART0_BASE	(IO_PHYS + 0x20000)
 #define DAVINCI_UART1_BASE	(IO_PHYS + 0x20400)
 #define DAVINCI_UART2_BASE	(IO_PHYS + 0x20800)
@@ -39,6 +37,8 @@
 #define UART_DM646X_SCR_TX_WATERMARK	0x08
 
 #ifndef __ASSEMBLY__
+#include <linux/platform_device.h>
+
 extern int davinci_serial_init(struct platform_device *);
 #endif
 
-- 
1.7.10.1
