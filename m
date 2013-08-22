From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 22 Aug 2013 14:03:24 -0700
Subject: [PATCH] dma/Kconfig: TI_EDMA needs to be boolean
Message-ID: <1377205404-16786-1-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix:

arch/arm/common/built-in.o: undefined reference to `edma_filter_fn'

seen with "make ARCH=arm allmodconfig"

Commit 6cba4355 (ARM: edma: Add DT and runtime PM support to the private EDMA
API) adds a dependency on edma_filter_fn() into arch/arm/common/edma.c. Since
this file is always built into the kernel, edma_filter_fn() must be built into
the kernel as well.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/dma/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 6825957..643d7c7 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -194,7 +194,7 @@ config SIRF_DMA
 	  Enable support for the CSR SiRFprimaII DMA engine.
 
 config TI_EDMA
-	tristate "TI EDMA support"
+	bool "TI EDMA support"
 	depends on ARCH_DAVINCI || ARCH_OMAP
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
-- 
1.7.9.7
