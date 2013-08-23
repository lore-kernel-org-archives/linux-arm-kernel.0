From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 24 Aug 2013 02:48:54 +0400
Subject: [PATCH v3 2/2] ARM: shmobile: BOCK-W: enable DMA for SDHI0
In-Reply-To: <201308240244.38963.sergei.shtylyov@cogentembedded.com>
References: <201308240244.38963.sergei.shtylyov@cogentembedded.com>
Message-ID: <201308240248.54866.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Max Filippov <max.filippov@cogentembedded.com>

Pass HPB-DMA slave IDs in the SDHI0 platform data to enable DMA in the SDHI
driver.

Signed-off-by: Max Filippov <max.filippov@cogentembedded.com>
[Sergei: removed #include <mach/dma.h>]
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 3:
- resolved reject.

Changes in version 2:
- removed #include <mach/dma.h>;
- refreshed the patch.

 arch/arm/mach-shmobile/board-bockw.c |    2 ++
 1 file changed, 2 insertions(+)

Index: renesas/arch/arm/mach-shmobile/board-bockw.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/board-bockw.c
+++ renesas/arch/arm/mach-shmobile/board-bockw.c
@@ -89,6 +89,8 @@ static struct rcar_phy_platform_data usb
 
 /* SDHI */
 static struct sh_mobile_sdhi_info sdhi0_info __initdata = {
+	.dma_slave_tx	= HPBDMA_SLAVE_SDHI0_TX,
+	.dma_slave_rx	= HPBDMA_SLAVE_SDHI0_RX,
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED,
 	.tmio_ocr_mask	= MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
