From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon,  1 Mar 2010 18:51:42 +0000
Subject: [PATCH 2.6.34] USB: Fix s3c-hsotg build following Samsung platform
	header moves
Message-ID: <1267469502-19560-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix a reference to regs-sys.h got missed in the reorganisation of
the Samsung platform headers targetted for 2.6.34.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

This should probably go via the Samsung/ARM tree along with the reorgs that
introduce the change.

 drivers/usb/gadget/s3c-hsotg.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
index 7e5bf59..f742c8e 100644
--- a/drivers/usb/gadget/s3c-hsotg.c
+++ b/drivers/usb/gadget/s3c-hsotg.c
@@ -30,7 +30,7 @@
 
 #include <plat/regs-usb-hsotg-phy.h>
 #include <plat/regs-usb-hsotg.h>
-#include <plat/regs-sys.h>
+#include <mach/regs-sys.h>
 #include <plat/udc-hs.h>
 
 #define DMA_ADDR_INVALID (~((dma_addr_t)0))
-- 
1.7.0
