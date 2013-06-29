From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 30 Jun 2013 02:50:01 +0400
Subject: [PATCH 3/3] ARM: shmobile: BOCK-W: enable DMA for SDHI0
In-Reply-To: <201306300243.57180.sergei.shtylyov@cogentembedded.com>
References: <201306300243.57180.sergei.shtylyov@cogentembedded.com>
Message-ID: <201306300250.02281.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Max Filippov <max.filippov@cogentembedded.com>

Pass HPB-DMA slave IDs in the SDHI0 platform data to enable DMA in the SDHI
driver.

Signed-off-by: Max Filippov <max.filippov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/mach-shmobile/board-bockw.c |    3 +++
 1 file changed, 3 insertions(+)

Index: renesas/arch/arm/mach-shmobile/board-bockw.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/board-bockw.c
+++ renesas/arch/arm/mach-shmobile/board-bockw.c
@@ -29,6 +29,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
 #include <mach/common.h>
+#include <mach/dma.h>
 #include <mach/irqs.h>
 #include <mach/r8a7778.h>
 #include <asm/mach/arch.h>
@@ -78,6 +79,8 @@ static struct resource smsc911x_resource
 
 /* SDHI */
 static struct sh_mobile_sdhi_info sdhi0_info = {
+	.dma_slave_tx	= HPBDMA_SLAVE_SDHI0_TX,
+	.dma_slave_rx	= HPBDMA_SLAVE_SDHI0_RX,
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED,
 	.tmio_ocr_mask	= MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
