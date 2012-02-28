From: zhaoy@marvell.com (zhaoy)
Date: Tue, 28 Feb 2012 15:27:34 +0800
Subject: [PATCH 02/13] dmaengine:open dmac and tdma support
In-Reply-To: <Y>
References: <Y>
Message-ID: <1330414065-2949-3-git-send-email-zhaoy@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	1.open dmaengine for tdma and dmac support

Change-Id: I3251daa57cf15fc96e90fbe8be3a1ee303629bcc
Signed-off-by: zhaoy <zhaoy@marvell.com>
---
 drivers/dma/Kconfig  |   19 +++++++++++++++++++
 drivers/dma/Makefile |    2 ++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 25cf327..483b782 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -237,6 +237,25 @@ config MXS_DMA
 	  Support the MXS DMA engine. This engine including APBH-DMA
 	  and APBX-DMA is integrated into Freescale i.MX23/28 chips.
 
+config PXA_DMAC
+	bool "PXA DMAC support"
+	depends on ARCH_PXA || ARCH_MMP
+	select DMA_ENGINE
+	help
+	  Support the PXA DMAC engine. This engine mainly used for PXA DMAC,
+	  also is integrated into Marvell MMP chips for peripheral DMA engine.
+
+config MMP_TDMA
+	bool "MMP Two-Channel DMA support"
+	depends on ARCH_MMP
+	select DMA_ENGINE
+	help
+	  Support the MMP Two-Channel DMA engine. This engine mainly used for
+	  Audio DMA and Memory DMA, now is integrated into Marvell MMP chips.
+
+	  Say Y here if you want to use tdma to manage the adma and mdma,
+	  otherwise say N.
+
 config DMA_ENGINE
 	bool
 
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 836095a..ba8e79c 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -25,3 +25,5 @@ obj-$(CONFIG_STE_DMA40) += ste_dma40.o ste_dma40_ll.o
 obj-$(CONFIG_PL330_DMA) += pl330.o
 obj-$(CONFIG_PCH_DMA) += pch_dma.o
 obj-$(CONFIG_AMBA_PL08X) += amba-pl08x.o
+obj-$(CONFIG_PXA_DMAC) += pxa_dmac.o
+obj-$(CONFIG_MMP_TDMA) += mmp_tdma.o
-- 
1.7.0.4
