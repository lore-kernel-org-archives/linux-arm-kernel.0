From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 18 Apr 2013 11:11:52 +0100
Subject: [PATCH 10/32] ARM: ux500: Remove unused 'data_width' attributes from
 SSP DMA configs
In-Reply-To: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1366279934-30761-11-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DMA configuration data is now allocated in the SSP driver, so these
are just ignored.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index a8b3ad9..35fd82f 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -495,16 +495,12 @@ static struct stedma40_chan_cfg ssp0_dma_cfg_rx = {
 	.mode = STEDMA40_MODE_LOGICAL,
 	.dir = STEDMA40_PERIPH_TO_MEM,
 	.dev_type = DB8500_DMA_DEV8_SSP0,
-	.src_info.data_width = STEDMA40_BYTE_WIDTH,
-	.dst_info.data_width = STEDMA40_BYTE_WIDTH,
 };
 
 static struct stedma40_chan_cfg ssp0_dma_cfg_tx = {
 	.mode = STEDMA40_MODE_LOGICAL,
 	.dir = STEDMA40_MEM_TO_PERIPH,
 	.dev_type = DB8500_DMA_DEV8_SSP0,
-	.src_info.data_width = STEDMA40_BYTE_WIDTH,
-	.dst_info.data_width = STEDMA40_BYTE_WIDTH,
 };
 #endif
 
-- 
1.7.10.4
