From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:26 +0100
Subject: [PATCH 29/62] ARM: pxa: don't "select" SMC91X on MACH_XCEP
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-30-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We normally don't hard-enable Kconfig options just because
a board contains a specific piece of hardware. In this case,
selecting SMC91X causes a build error, if we don't also enable
basic network device driver support.

Since the platform has no direct dependency on this driver
at link time, we can just remove the 'select' statement.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Daniel Mack <zonque@gmail.com>
---
 arch/arm/mach-pxa/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 562b17f..2c7498a 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -164,7 +164,6 @@ config MACH_XCEP
 	select MTD_CFI_INTELEXT
 	select MTD_PHYSMAP
 	select PXA25x
-	select SMC91X
 	help
 	  PXA255 based Single Board Computer with SMC 91C111 ethernet chip and 64 MB of flash.
 	  Tuned for usage in Libera instruments for particle accelerators.
-- 
1.8.3.2
