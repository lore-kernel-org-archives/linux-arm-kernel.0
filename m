From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Feb 2015 16:06:09 +0100
Subject: [PATCH] serial: pl010 is no longer broken
Message-ID: <3118156.gAoOHDhYSV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As more ARM platforms are moving into ARCH_MULTIPLATFORM, we can now
have integrator and versatile in the same kernel, and first one selects
this driver, causing a Kconfig warning:

warning: (ARCH_INTEGRATOR_AP) selects SERIAL_AMBA_PL010 which has unmet direct dependencies (TTY && HAS_IOMEM && ARM_AMBA && (BROKEN || !ARCH_VERSATILE))

It turns out that it has not been broken on versatile for a long time,
so we can remove the statement here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index d2501f01cd03..bbb12794cc8c 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -20,7 +20,7 @@ comment "Non-8250 serial port support"
 
 config SERIAL_AMBA_PL010
 	tristate "ARM AMBA PL010 serial port support"
-	depends on ARM_AMBA && (BROKEN || !ARCH_VERSATILE)
+	depends on ARM_AMBA
 	select SERIAL_CORE
 	help
 	  This selects the ARM(R) AMBA(R) PrimeCell PL010 UART.  If you have
