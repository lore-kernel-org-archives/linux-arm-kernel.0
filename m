From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 18 Dec 2012 01:24:28 +0100
Subject: [PATCH 2/3] ARM: Dove: cleanup includes
In-Reply-To: <1355790269-10596-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1355790269-10596-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1355790269-10596-2-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With DT board setup removed from common code, it is a good time
to cleanup unneccessary includes from common dove code.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/mach-dove/common.c |   30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index 7dda832..0e61cc4 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -8,35 +8,23 @@
  * warranty of any kind, whether express or implied.
  */
 
-#include <linux/kernel.h>
-#include <linux/delay.h>
 #include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/pci.h>
 #include <linux/clk-provider.h>
-#include <linux/clk/mvebu.h>
-#include <linux/ata_platform.h>
-#include <linux/gpio.h>
-#include <linux/of.h>
-#include <linux/of_platform.h>
-#include <asm/page.h>
-#include <asm/setup.h>
-#include <asm/timex.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/platform_data/usb-ehci-orion.h>
+#include <linux/platform_data/dma-mv_xor.h>
+#include <linux/platform_device.h>
 #include <asm/hardware/cache-tauros2.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
-#include <asm/mach/pci.h>
+#include <mach/bridge-regs.h>
 #include <mach/dove.h>
 #include <mach/pm.h>
-#include <mach/bridge-regs.h>
-#include <asm/mach/arch.h>
-#include <linux/irq.h>
-#include <plat/time.h>
-#include <linux/platform_data/usb-ehci-orion.h>
-#include <linux/platform_data/dma-mv_xor.h>
-#include <plat/irq.h>
-#include <plat/common.h>
 #include <plat/addr-map.h>
+#include <plat/common.h>
+#include <plat/irq.h>
+#include <plat/time.h>
 #include "common.h"
 
 /*****************************************************************************
-- 
1.7.10.4
