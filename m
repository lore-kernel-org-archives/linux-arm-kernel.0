From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 24 Nov 2016 01:17:12 +0000
Subject: [RFC PATCH 2/5] dmaengine: allow sun6i-dma for more SoCs
In-Reply-To: <1479950235-26821-1-git-send-email-andre.przywara@arm.com>
References: <1479950235-26821-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1479950235-26821-3-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sun6i DMA driver is used in the Allwinner A64 and H5 SoC, which
have arm64 capable cores. Add the generic sunxi config symbol to allow
the driver to be selected by arm64 Kconfigs, which don't feature
SoC specific MACH_xxxx configs.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index af63a6b..003c284 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -157,7 +157,7 @@ config DMA_SUN4I
 
 config DMA_SUN6I
 	tristate "Allwinner A31 SoCs DMA support"
-	depends on MACH_SUN6I || MACH_SUN8I || COMPILE_TEST
+	depends on MACH_SUN6I || MACH_SUN8I || COMPILE_TEST || ARCH_SUNXI
 	depends on RESET_CONTROLLER
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
-- 
2.8.2
