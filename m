From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  7 Aug 2014 19:00:44 +0200
Subject: [PATCH] dmaengine: sun6i: depends on RESET_CONTROLLER
Message-ID: <1407430844-30498-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes a compilation error when RESET_CONTROLLER is not enabled in the
configuration.

drivers/dma/sun6i-dma.c: In function 'sun6i_dma_probe':
drivers/dma/sun6i-dma.c:911:2: error: implicit declaration of function 'devm_reset_control_get' [-Werror=implicit-function-declaration]

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
---
 drivers/dma/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 4b439270fb11..a85e54af5eb1 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -378,6 +378,7 @@ config XILINX_VDMA
 config DMA_SUN6I
 	tristate "Allwinner A31 SoCs DMA support"
 	depends on MACH_SUN6I || COMPILE_TEST
+	depends on RESET_CONTROLLER
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
2.0.2
