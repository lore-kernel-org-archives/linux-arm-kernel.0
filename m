From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Thu, 26 Jan 2017 23:48:57 +0800
Subject: [PATCH v2 7/9] dmaengine: sun6i: allow build on ARM64 platforms
 (sun50i)
In-Reply-To: <20170126154859.55855-1-icenowy@aosc.xyz>
References: <20170126154859.55855-1-icenowy@aosc.xyz>
Message-ID: <20170126154859.55855-8-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As 64-bot Allwinner H5 SoC has the same DMA engine with H3, the DMA
driver should be allowed to be built for ARM64, in order to make it work on H5.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
New patch in v2, as H3 codec support is added between v1 and v2.

 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 0d6a96ee9fc7..d01d59812cf3 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -157,7 +157,7 @@ config DMA_SUN4I
 
 config DMA_SUN6I
 	tristate "Allwinner A31 SoCs DMA support"
-	depends on MACH_SUN6I || MACH_SUN8I || COMPILE_TEST
+	depends on MACH_SUN6I || MACH_SUN8I || (ARM64 && ARCH_SUNXI) || COMPILE_TEST
 	depends on RESET_CONTROLLER
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
-- 
2.11.0
