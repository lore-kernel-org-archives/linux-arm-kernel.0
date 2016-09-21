From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 21 Sep 2016 15:41:34 +0300
Subject: [PATCH v3 8/9] dmaengine: omap-dma: enable COMPILE_TEST
In-Reply-To: <20160921124135.11849-1-peter.ujfalusi@ti.com>
References: <20160921124135.11849-1-peter.ujfalusi@ti.com>
Message-ID: <20160921124135.11849-9-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To get more coverage, enable COMPILE_TEST for this driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 4348249b943a..84647d6cb2f4 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -130,7 +130,7 @@ config DMA_JZ4780
 
 config DMA_OMAP
 	tristate "OMAP DMA support"
-	depends on ARCH_OMAP
+	depends on ARCH_OMAP || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	select TI_DMA_CROSSBAR if SOC_DRA7XX
-- 
2.10.0
