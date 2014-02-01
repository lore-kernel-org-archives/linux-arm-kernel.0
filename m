From: robherring2@gmail.com (Rob Herring)
Date: Sat,  1 Feb 2014 16:35:43 -0600
Subject: [PATCH 2/3] ARM: moxart: move DMA_OF selection to driver
In-Reply-To: <1391294144-27787-1-git-send-email-robherring2@gmail.com>
References: <1391294144-27787-1-git-send-email-robherring2@gmail.com>
Message-ID: <1391294144-27787-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Move the DMA_OF selection to the DMA driver to fix kconfig warning:

warning: (ARCH_MOXART) selects DMA_OF which has unmet direct dependencies (DMADEVICES && OF)

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-moxart/Kconfig | 1 -
 drivers/dma/Kconfig          | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-moxart/Kconfig b/arch/arm/mach-moxart/Kconfig
index ba470d6..3795ae2 100644
--- a/arch/arm/mach-moxart/Kconfig
+++ b/arch/arm/mach-moxart/Kconfig
@@ -2,7 +2,6 @@ config ARCH_MOXART
 	bool "MOXA ART SoC" if ARCH_MULTI_V4T
 	select CPU_FA526
 	select ARM_DMA_MEM_BUFFERABLE
-	select DMA_OF
 	select USE_OF
 	select CLKSRC_OF
 	select CLKSRC_MMIO
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 9bed1a2..605b016 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -346,6 +346,7 @@ config MOXART_DMA
 	tristate "MOXART DMA support"
 	depends on ARCH_MOXART
 	select DMA_ENGINE
+	select DMA_OF
 	select DMA_VIRTUAL_CHANNELS
 	help
 	  Enable support for the MOXA ART SoC DMA controller.
-- 
1.8.3.2
