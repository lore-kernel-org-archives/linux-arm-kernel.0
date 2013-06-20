From: joelagnel@ti.com (Joel A Fernandes)
Date: Thu, 20 Jun 2013 16:06:41 -0500
Subject: [PATCH v12 05/11] edma: config: Enable config options for EDMA
In-Reply-To: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
References: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
Message-ID: <1371762407-24544-6-git-send-email-joelagnel@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joel A Fernandes <agnel.joel@gmail.com>

Build TI_EDMA by default for ARCH_DAVINCI and ARCH_OMAP2PLUS

Signed-off-by: Joel A Fernandes <joelagnel@ti.com>
---
 arch/arm/Kconfig            |    1 +
 arch/arm/mach-omap2/Kconfig |    1 +
 drivers/dma/Kconfig         |    2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b1c66a4..7d58cd9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -841,6 +841,7 @@ config ARCH_DAVINCI
 	select HAVE_IDE
 	select NEED_MACH_GPIO_H
 	select TI_PRIV_EDMA
+	select DMADEVICES
 	select USE_OF
 	select ZONE_DMA
 	help
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index f91b07f..c02f083 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -17,6 +17,7 @@ config ARCH_OMAP2PLUS
 	select PROC_DEVICETREE if PROC_FS
 	select SOC_BUS
 	select SPARSE_IRQ
+	select DMADEVICES
 	select TI_PRIV_EDMA
 	select USE_OF
 	help
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 3215a3c..b2d6f15 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -216,7 +216,7 @@ config TI_EDMA
 	depends on ARCH_DAVINCI || ARCH_OMAP
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
-	default n
+	default y
 	help
 	  Enable support for the TI EDMA controller. This DMA
 	  engine is found on TI DaVinci and AM33xx parts.
-- 
1.7.9.5
