From: mad_soft@inbox.lv (Dmitry Artamonow)
Date: Thu,  7 Nov 2013 18:36:53 +0400
Subject: [PATCH] ARM: pxa/colibri: fix build with CONFIG_USB_OHCI_HCD=y
Message-ID: <1383835013-22215-1-git-send-email-mad_soft@inbox.lv>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix following build failure observed when support for
OHCI host controller is enabled.

  CC      arch/arm/mach-pxa/colibri-evalboard.o
arch/arm/mach-pxa/colibri-evalboard.c: In function 'colibri_ohci_init':
arch/arm/mach-pxa/colibri-evalboard.c:68: error: implicit declaration of function 'IOMEM'
make[1]: *** [arch/arm/mach-pxa/colibri-evalboard.o] Error 1
make: *** [arch/arm/mach-pxa] Error 2

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.lv>
---
 arch/arm/mach-pxa/colibri-evalboard.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-pxa/colibri-evalboard.c b/arch/arm/mach-pxa/colibri-evalboard.c
index 8404b24..57f661d 100644
--- a/arch/arm/mach-pxa/colibri-evalboard.c
+++ b/arch/arm/mach-pxa/colibri-evalboard.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/gpio.h>
+#include <linux/io.h>
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
 #include <asm/mach/arch.h>
-- 
1.8.1.2
