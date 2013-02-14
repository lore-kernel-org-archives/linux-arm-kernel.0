From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Feb 2013 23:26:50 +0100
Subject: [PATCH 1/9] ARM: sa1100/assabet: include platform_device.h directly
In-Reply-To: <1360880818-4071454-1-git-send-email-arnd@arndb.de>
References: <1360880818-4071454-1-git-send-email-arnd@arndb.de>
Message-ID: <1360880818-4071454-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch "16559ae kgdb: remove #include <linux/serial_8250.h> from kgdb.h
caused assabet_defconfig to fail, since assabet.c did not
itself include linux/platform_device.h, although it needs it:

In file included from include/linux/mfd/ucb1x00.h:13:0,
                 from arch/arm/mach-sa1100/assabet.c:19:
include/linux/mfd/mcp.h:22:16: error: field 'attached_device' has incomplete type
include/linux/mfd/mcp.h:48:23: error: field 'drv' has incomplete type
In file included from arch/arm/mach-sa1100/assabet.c:19:0:
include/linux/mfd/ucb1x00.h:137:16: error: field 'dev' has incomplete type
arch/arm/mach-sa1100/assabet.c: In function 'assabet_init':
arch/arm/mach-sa1100/assabet.c:343:3: error: implicit declaration of function 'platform_device_register_simple' [-Wimplicit-function-declaration]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-sa1100/assabet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index b38d252..e838ba2 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -16,6 +16,7 @@
 #include <linux/ioport.h>
 #include <linux/platform_data/sa11x0-serial.h>
 #include <linux/serial_core.h>
+#include <linux/platform_device.h>
 #include <linux/mfd/ucb1x00.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
-- 
1.8.1.2
