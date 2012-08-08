From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  8 Aug 2012 14:54:50 +0200
Subject: [PATCH 3/6] ARM: sa1100: include asm/io.h in hackkit leds code
In-Reply-To: <1344430493-5304-1-git-send-email-arnd@arndb.de>
References: <1344430493-5304-1-git-send-email-arnd@arndb.de>
Message-ID: <1344430493-5304-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sa1100 definition of the io_p2v macro has changed in v3.6, and this one
file stopped working because of that.

Without this patch, building hackkit_defconfig results in:

arch/arm/mach-sa1100/leds-hackkit.c: In function 'hackkit_leds_event':
arch/arm/mach-sa1100/leds-hackkit.c:39:4: error: implicit declaration of function 'IOMEM' [-Werror=implicit-function-declaration]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/leds-hackkit.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-sa1100/leds-hackkit.c b/arch/arm/mach-sa1100/leds-hackkit.c
index 6a23524..9c79674 100644
--- a/arch/arm/mach-sa1100/leds-hackkit.c
+++ b/arch/arm/mach-sa1100/leds-hackkit.c
@@ -13,6 +13,7 @@
 
 #include <mach/hardware.h>
 #include <asm/leds.h>
+#include <asm/io.h>
 
 #include "leds.h"
 
-- 
1.7.10
