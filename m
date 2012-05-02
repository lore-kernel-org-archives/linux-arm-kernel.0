From: guillaume.gardet@free.fr (Guillaume Gardet)
Date: Wed, 02 May 2012 15:13:11 +0200
Subject: [PATCH V2 1/1] Add missing include <plat/cpu.h> in
 drivers/mfd/omap-usb-host.c
Message-ID: <4FA132E7.2000403@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix compilation error for omap boards (beagleboard, etc.) due to missing include <plat/cpu.h> in drivers/mfd/omap-usb-host.c leading to build error:
   CC      drivers/mfd/omap-usb-host.o
drivers/mfd/omap-usb-host.c: In function 'omap_usbhs_init':
drivers/mfd/omap-usb-host.c:524: error: implicit declaration of function 'cpu_is_omap3430'
drivers/mfd/omap-usb-host.c:524: error: implicit declaration of function 'omap_rev'
drivers/mfd/omap-usb-host.c:524: error: 'OMAP3430_REV_ES2_1' undeclared (first use in this function)
drivers/mfd/omap-usb-host.c:524: error: (Each undeclared identifier is reported only once
drivers/mfd/omap-usb-host.c:524: error: for each function it appears in.)


Signed-off-by: Guillaume GARDET<guillaume.gardet@free.fr>

---
KernelVersion: 3.4-rc5

  drivers/mfd/omap-usb-host.c |    1 +
  1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index c8aae66..7e96bb2 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -25,6 +25,7 @@
  #include <linux/clk.h>
  #include <linux/dma-mapping.h>
  #include <linux/spinlock.h>
+#include <plat/cpu.h>
  #include <plat/usb.h>
  #include <linux/pm_runtime.h>

-- 
1.7.7
