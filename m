From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 15 Dec 2016 22:03:35 +0800
Subject: [PATCH 1/3] dma: zx: rename zx296702_dma.c to zx_dma.c
Message-ID: <1481810617-7650-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

ZTE ZX dma driver is not ZX296702 specific.  It works for not only
ZX296702 but also other ZTE ZX family platforms like ZX296718.  Let's
rename the file to reflect that.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/dma/Kconfig                      | 4 ++--
 drivers/dma/Makefile                     | 2 +-
 drivers/dma/{zx296702_dma.c => zx_dma.c} | 0
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename drivers/dma/{zx296702_dma.c => zx_dma.c} (100%)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 263495d0adbd..eab7e12ee4a6 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -571,12 +571,12 @@ config XILINX_ZYNQMP_DMA
 	  Enable support for Xilinx ZynqMP DMA controller.
 
 config ZX_DMA
-	tristate "ZTE ZX296702 DMA support"
+	tristate "ZTE ZX DMA support"
 	depends on ARCH_ZX || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-	  Support the DMA engine for ZTE ZX296702 platform devices.
+	  Support the DMA engine for ZTE ZX family platform devices.
 
 
 # driver files
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index a4fa3360e609..0b723e94d9e6 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -66,7 +66,7 @@ obj-$(CONFIG_TI_CPPI41) += cppi41.o
 obj-$(CONFIG_TI_DMA_CROSSBAR) += ti-dma-crossbar.o
 obj-$(CONFIG_TI_EDMA) += edma.o
 obj-$(CONFIG_XGENE_DMA) += xgene-dma.o
-obj-$(CONFIG_ZX_DMA) += zx296702_dma.o
+obj-$(CONFIG_ZX_DMA) += zx_dma.o
 obj-$(CONFIG_ST_FDMA) += st_fdma.o
 
 obj-y += qcom/
diff --git a/drivers/dma/zx296702_dma.c b/drivers/dma/zx_dma.c
similarity index 100%
rename from drivers/dma/zx296702_dma.c
rename to drivers/dma/zx_dma.c
-- 
1.9.1
