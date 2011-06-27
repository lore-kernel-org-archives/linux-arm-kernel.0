From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 27 Jun 2011 18:19:30 +0200
Subject: [PATCH] mach-ux500: fix USB build error
Message-ID: <1309191570-3978-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The mach-ux500/usb.c was referencing DMA macros, but not
including <linux/dma-mapping.h> so it didn't compile. Fixed by
a proper #include.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Mian Yousaf Kaukab <mian.yousaf.kaukab@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Arnd: please merge this atop of the st-ericsson stuff in arm-soc
so that the -next tree compiles when it get pulled in.
---
 arch/arm/mach-ux500/usb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/usb.c b/arch/arm/mach-ux500/usb.c
index 82e5359..0a01cbd 100644
--- a/arch/arm/mach-ux500/usb.c
+++ b/arch/arm/mach-ux500/usb.c
@@ -6,6 +6,7 @@
  */
 #include <linux/platform_device.h>
 #include <linux/usb/musb.h>
+#include <linux/dma-mapping.h>
 #include <plat/ste_dma40.h>
 #include <mach/hardware.h>
 #include <mach/usb.h>
-- 
1.7.3.2
