From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 13 Jan 2015 19:28:05 +0100
Subject: [PATCH] pcmcia: at91_cf: depend on !ARCH_MULTIPLATFORM
Message-ID: <1421173685-21559-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Until the driver is corrected to stop including mach/at91_ramc.h and using
mach/io.h, it won't compile in a ARCH_MULTIPLATFORM configuration.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/pcmcia/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index 910e90bf16c6..45f67c63d385 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -276,6 +276,7 @@ config BFIN_CFPCMCIA
 config AT91_CF
 	tristate "AT91 CompactFlash Controller"
 	depends on PCMCIA && ARCH_AT91
+	depends on !ARCH_MULTIPLATFORM
 	help
 	  Say Y here to support the CompactFlash controller on AT91 chips.
 	  Or choose M to compile the driver as a module named "at91_cf".
-- 
2.1.0
