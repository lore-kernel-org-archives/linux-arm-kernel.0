From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:12 +0100
Subject: [PATCH 15/62] ARM: ixp4xx/omixp: always include linux/leds.h
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-16-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The omixp board code unconditionally defines a gpio-led
device, but for some reason includes the header file
for this only if CONFIG_LEDS_CLASS is enabled, causing
a build error otherwise.

Removing the #ifdef fixes the build error with no downsides
whatsoever.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>
---
 arch/arm/mach-ixp4xx/omixp-setup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/omixp-setup.c b/arch/arm/mach-ixp4xx/omixp-setup.c
index 75ef03d..2d494b4 100644
--- a/arch/arm/mach-ixp4xx/omixp-setup.c
+++ b/arch/arm/mach-ixp4xx/omixp-setup.c
@@ -17,9 +17,7 @@
 #include <linux/serial_8250.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
-#ifdef CONFIG_LEDS_CLASS
 #include <linux/leds.h>
-#endif
 
 #include <asm/setup.h>
 #include <asm/memory.h>
-- 
1.8.3.2
