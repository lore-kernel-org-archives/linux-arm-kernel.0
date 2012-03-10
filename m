From: alan@signal11.us (Alan Ott)
Date: Sat, 10 Mar 2012 13:44:35 -0500
Subject: [PATCH 1/2] ARM: at91: only RM9200 has ISA-style PIO
In-Reply-To: <1331405049-3186-1-git-send-email-alan@signal11.us>
References: <1331405049-3186-1-git-send-email-alan@signal11.us>
Message-ID: <1331405075-3231-1-git-send-email-alan@signal11.us>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

Most at91 systems have no support for PCMCIA or other
PC-style buses, so we can select NO_IOPORT in order to
disable compilationf or all drivers that need these.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Alan Ott <alan@signal11.us>
---
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index dfb0312..1306f0d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -322,6 +322,7 @@ config ARCH_AT91
 	select ARCH_REQUIRE_GPIOLIB
 	select HAVE_CLK
 	select CLKDEV_LOOKUP
+	select NO_IOPORT if !ARCH_AT91RM9200
 	help
 	  This enables support for systems based on the Atmel AT91RM9200,
 	  AT91SAM9 and AT91CAP9 processors.
-- 
1.7.0.4
