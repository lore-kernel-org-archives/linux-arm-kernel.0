From: sjhuang@iluvatar.ai (Huang Shijie)
Date: Mon,  6 Aug 2018 16:52:31 +0800
Subject: [PATCH v2 9/9] dmaengine: add COMPILE_TEST for the drivers
In-Reply-To: <20180806085231.4597-1-sjhuang@iluvatar.ai>
References: <20180806085231.4597-1-sjhuang@iluvatar.ai>
Message-ID: <20180806085231.4597-10-sjhuang@iluvatar.ai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can do the compiling test with COMPILE_TEST.
This patch adds the COMPILE_TEST for the drivers.

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 drivers/dma/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index d4a4230a7942..1f0dceb055d8 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -439,7 +439,7 @@ config PL330_DMA
 
 config PXA_DMA
 	bool "PXA DMA support"
-	depends on (ARCH_MMP || ARCH_PXA)
+	depends on (ARCH_MMP || ARCH_PXA || COMPILE_TEST)
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
@@ -457,7 +457,7 @@ config SIRF_DMA
 
 config STE_DMA40
 	bool "ST-Ericsson DMA40 support"
-	depends on ARCH_U8500
+	depends on ARCH_U8500 || COMPILE_TEST
 	select DMA_ENGINE
 	help
 	  Support for ST-Ericsson DMA40 controller
-- 
2.17.1
