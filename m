From: mporter@ti.com (Matt Porter)
Date: Thu, 20 Sep 2012 10:43:37 -0400
Subject: [RFC PATCH 04/13] dmaengine: edma: enable build for AM335x
In-Reply-To: <1348152226-13588-1-git-send-email-mporter@ti.com>
References: <1348152226-13588-1-git-send-email-mporter@ti.com>
Message-ID: <1348152226-13588-5-git-send-email-mporter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable config option on OMAP and adjust the
private EDMA API header to match the move
of the private EDMA API out of mach-davinci/

Signed-off-by: Matt Porter <mporter@ti.com>
---
 drivers/dma/Kconfig |    2 +-
 drivers/dma/edma.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 0351719..24cd403 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -210,7 +210,7 @@ config SIRF_DMA
 
 config TI_EDMA
 	tristate "TI EDMA support"
-	depends on ARCH_DAVINCI
+	depends on ARCH_DAVINCI || ARCH_OMAP
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	default n
diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index fdcf079..9f8f2fa 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -24,7 +24,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
-#include <mach/edma.h>
+#include <asm/mach/edma.h>
 
 #include "dmaengine.h"
 #include "virt-dma.h"
-- 
1.7.9.5
