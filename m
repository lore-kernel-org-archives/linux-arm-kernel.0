From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:34:07 +0000
Subject: [PATCH 12/48] ARM: PL08x: remove unnecessary includes
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZsyd-0001Oe-Gz@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't need to include linux/pci.h as we aren't a PCI driver.  We
aren't doing any processor specific functions, so asm/processor.h is
not required.  asm/cacheflush.h shouldn't be used, we have the DMA API
for this.  DMA interfaces aren't required as we're only implementing
the dmaengine API and not a platform-private DMA API.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index c61774a..d22d628 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -77,21 +77,16 @@
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/pci.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/dmapool.h>
-#include <linux/amba/bus.h>
 #include <linux/dmaengine.h>
+#include <linux/amba/bus.h>
 #include <linux/amba/pl08x.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 
 #include <asm/hardware/pl080.h>
-#include <asm/dma.h>
-#include <asm/mach/dma.h>
-#include <asm/processor.h>
-#include <asm/cacheflush.h>
 
 #define DRIVER_NAME	"pl08xdmac"
 
-- 
1.6.2.5
