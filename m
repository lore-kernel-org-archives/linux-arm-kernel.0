From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Mar 2017 21:52:56 +0100
Subject: [PATCH] ARM: gemini: don't select SERIAL_OF_PLATFORM
Message-ID: <20170321205310.188381-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We cannot select the option when SERIAL_8250 is not also set:

warning: (ARCH_GEMINI) selects SERIAL_OF_PLATFORM which has unmet direct dependencies (TTY && HAS_IOMEM && SERIAL_8250 && OF)

This removes the 'select' statement, requiring that users enable the
option manually. Alternatively, we could make it a conditional
'select SERIAL_OF_PLATFORM if SERIAL_8250' or also select a handful
of other symbols that it depends on.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-gemini/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-gemini/Kconfig b/arch/arm/mach-gemini/Kconfig
index a5ee5fbab796..4162396af6de 100644
--- a/arch/arm/mach-gemini/Kconfig
+++ b/arch/arm/mach-gemini/Kconfig
@@ -8,6 +8,5 @@ menuconfig ARCH_GEMINI
 	select GPIOLIB
 	select POWER_RESET
 	select POWER_RESET_SYSCON
-	select SERIAL_OF_PLATFORM
 	help
 	  Support for the Cortina Systems Gemini family SoCs
-- 
2.9.0
