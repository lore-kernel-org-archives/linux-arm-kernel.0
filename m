From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  9 Oct 2013 15:50:50 +0900
Subject: [PATCH 02/14] ARM: shmobile: bockw: enable DMA for SDHI0
In-Reply-To: <cover.1381299817.git.horms+renesas@verge.net.au>
References: <cover.1381299817.git.horms+renesas@verge.net.au>
Message-ID: <5d6aa3435275a5308684f90c17424b055ef7f572.1381299817.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Max Filippov <max.filippov@cogentembedded.com>

Pass HPB-DMA slave IDs in the SDHI0 platform data to enable DMA in the SDHI
driver.

Signed-off-by: Max Filippov <max.filippov@cogentembedded.com>
[Sergei: removed #include <mach/dma.h>]
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bockw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 330e84c..421cf1c 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -196,6 +196,8 @@ static struct rcar_phy_platform_data usb_phy_platform_data __initdata =
 
 /* SDHI */
 static struct sh_mobile_sdhi_info sdhi0_info __initdata = {
+	.dma_slave_tx	= HPBDMA_SLAVE_SDHI0_TX,
+	.dma_slave_rx	= HPBDMA_SLAVE_SDHI0_RX,
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED,
 	.tmio_ocr_mask	= MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
-- 
1.8.4
