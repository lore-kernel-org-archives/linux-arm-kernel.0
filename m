From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 9 Aug 2013 01:44:03 +0400
Subject: [PATCH 2/2] ARM: shmobile: Marzen: enable DMA for SDHI0
In-Reply-To: <201308090140.14515.sergei.shtylyov@cogentembedded.com>
References: <201308090140.14515.sergei.shtylyov@cogentembedded.com>
Message-ID: <201308090144.03912.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Max Filippov <max.filippov@cogentembedded.com>

Pass HPB-DMA slave IDs in the SDHI0 platform data to enable DMA in the SDHI
driver.

Signed-off-by: Max Filippov <max.filippov@cogentembedded.com>
[Sergei: removed #include <mach/dma.h>]
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/mach-shmobile/board-marzen.c |    2 ++
 1 file changed, 2 insertions(+)

Index: renesas/arch/arm/mach-shmobile/board-marzen.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/board-marzen.c
+++ renesas/arch/arm/mach-shmobile/board-marzen.c
@@ -122,6 +122,8 @@ static struct resource sdhi0_resources[]
 };
 
 static struct sh_mobile_sdhi_info sdhi0_platform_data = {
+	.dma_slave_tx = HPBDMA_SLAVE_SDHI0_TX,
+	.dma_slave_rx = HPBDMA_SLAVE_SDHI0_RX,
 	.tmio_flags = TMIO_MMC_WRPROTECT_DISABLE | TMIO_MMC_HAS_IDLE_WAIT,
 	.tmio_caps = MMC_CAP_SD_HIGHSPEED,
 };
