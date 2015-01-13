From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 13 Jan 2015 19:25:17 +0100
Subject: [PATCH] ata: pata_at91: depend on !ARCH_MULTIPLATFORM
Message-ID: <1421173517-21246-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Until the driver is corrected to stop using mach/at91isam9_smc.h, it won't
compile in a ARCH_MULTIPLATFORM configuration.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/ata/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index a3a13605a9c4..5f601553b9b0 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -835,6 +835,7 @@ config PATA_AT32
 config PATA_AT91
 	tristate "PATA support for AT91SAM9260"
 	depends on ARM && SOC_AT91SAM9
+	depends on !ARCH_MULTIPLATFORM
 	help
 	  This option enables support for IDE devices on the Atmel AT91SAM9260 SoC.
 
-- 
2.1.0
