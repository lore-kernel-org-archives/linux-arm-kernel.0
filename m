From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 06 Aug 2011 09:40:43 +0100
Subject: [PATCH] dmaengine: PL08x: Fix trivial build error
Message-ID: <E1QpcR1-00013t-Sj@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Something changed during the 3.1 merge window in the include files
which now causes the pl08x DMA engine driver to fail to build.  Fix
this by adding the now necessary dma-mapping.h include:

drivers/dma/amba-pl08x.c: In function ?pl08x_unmap_buffers?:
drivers/dma/amba-pl08x.c:1524: error: implicit declaration of function ?dma_unmap_single?
drivers/dma/amba-pl08x.c:1527: error: implicit declaration of function ?dma_unmap_page?

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
If you can provide an ack, and I'll push this through my pending
'fixes' merge.

 drivers/dma/amba-pl08x.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 196a737..be21e3f 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -80,6 +80,7 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
 #include <linux/dmapool.h>
 #include <linux/dmaengine.h>
 #include <linux/amba/bus.h>
-- 
1.7.4.4
