From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:35 +0100
Subject: [PATCH 38/62] ARM: footbridge: don't build floppy code for addin mode
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-39-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARCH_EBSA285_ADDIN platform does not provide the
ISA_DMA API, which is required by the floppy driver.

Let's ensure that the floppy code can only be built
when ISA_DMA is also enabled, by moving the select
statement into ARCH_EBSA285_HOST.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mach-footbridge/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-footbridge/Kconfig b/arch/arm/mach-footbridge/Kconfig
index fba55fb..07152d0 100644
--- a/arch/arm/mach-footbridge/Kconfig
+++ b/arch/arm/mach-footbridge/Kconfig
@@ -52,6 +52,7 @@ config ARCH_EBSA285_HOST
 	select FOOTBRIDGE_HOST
 	select ISA
 	select ISA_DMA
+	select ARCH_MAY_HAVE_PC_FDC
 	select PCI
 	help
 	  Say Y here if you intend to run this kernel on the EBSA285 card
@@ -94,6 +95,5 @@ config FOOTBRIDGE_ADDIN
 # EBSA285 board in either host or addin mode
 config ARCH_EBSA285
 	bool
-	select ARCH_MAY_HAVE_PC_FDC
 
 endif
-- 
1.8.3.2
