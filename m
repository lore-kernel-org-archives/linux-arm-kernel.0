From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  3 May 2013 15:31:59 +0100
Subject: [PATCH 13/63] ARM: ux500: Remove unused 'data_width' attributes from
 SDI DMA configs
In-Reply-To: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1367591569-32197-14-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DMA configuration data is now allocated in the MMCI driver, so these
are just ignored.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-sdi.c |   16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-sdi.c b/arch/arm/mach-ux500/board-mop500-sdi.c
index 5c28216..553ace6 100644
--- a/arch/arm/mach-ux500/board-mop500-sdi.c
+++ b/arch/arm/mach-ux500/board-mop500-sdi.c
@@ -65,16 +65,12 @@ struct stedma40_chan_cfg mop500_sdi0_dma_cfg_rx = {
 	.mode = STEDMA40_MODE_LOGICAL,
 	.dir = STEDMA40_PERIPH_TO_MEM,
 	.dev_type = DB8500_DMA_DEV29_SD_MM0,
-	.src_info.data_width = STEDMA40_WORD_WIDTH,
-	.dst_info.data_width = STEDMA40_WORD_WIDTH,
 };
 
 static struct stedma40_chan_cfg mop500_sdi0_dma_cfg_tx = {
 	.mode = STEDMA40_MODE_LOGICAL,
 	.dir = STEDMA40_MEM_TO_PERIPH,
 	.dev_type = DB8500_DMA_DEV29_SD_MM0,
-	.src_info.data_width = STEDMA40_WORD_WIDTH,
-	.dst_info.data_width = STEDMA40_WORD_WIDTH,
 };
 #endif
 
@@ -134,16 +130,12 @@ static struct stedma40_chan_cfg sdi1_dma_cfg_rx = {
 	.mode = STEDMA40_MODE_LOGICAL,
 	.dir = STEDMA40_PERIPH_TO_MEM,
 	.dev_type = DB8500_DMA_DEV32_SD_MM1,
-	.src_info.data_width = STEDMA40_WORD_WIDTH,
-	.dst_info.data_width = STEDMA40_WORD_WIDTH,
 };
 
 static struct stedma40_chan_cfg sdi1_dma_cfg_tx = {
 	.mode = STEDMA40_MODE_LOGICAL,
 	.dir = STEDMA40_MEM_TO_PERIPH,
 	.dev_type = DB8500_DMA_DEV32_SD_MM1,
-	.src_info.data_width = STEDMA40_WORD_WIDTH,
-	.dst_info.data_width = STEDMA40_WORD_WIDTH,
 };
 #endif
 
@@ -169,16 +161,12 @@ struct stedma40_chan_cfg mop500_sdi2_dma_cfg_rx = {
 	.mode = STEDMA40_MODE_LOGICAL,
 	.dir = STEDMA40_PERIPH_TO_MEM,
 	.dev_type =  DB8500_DMA_DEV28_SD_MM2,
-	.src_info.data_width = STEDMA40_WORD_WIDTH,
-	.dst_info.data_width = STEDMA40_WORD_WIDTH,
 };
 
 static struct stedma40_chan_cfg mop500_sdi2_dma_cfg_tx = {
 	.mode = STEDMA40_MODE_LOGICAL,
 	.dir = STEDMA40_MEM_TO_PERIPH,
 	.dev_type = DB8500_DMA_DEV28_SD_MM2,
-	.src_info.data_width = STEDMA40_WORD_WIDTH,
-	.dst_info.data_width = STEDMA40_WORD_WIDTH,
 };
 #endif
 
@@ -205,16 +193,12 @@ struct stedma40_chan_cfg mop500_sdi4_dma_cfg_rx = {
 	.mode = STEDMA40_MODE_LOGICAL,
 	.dir = STEDMA40_PERIPH_TO_MEM,
 	.dev_type =  DB8500_DMA_DEV42_SD_MM4,
-	.src_info.data_width = STEDMA40_WORD_WIDTH,
-	.dst_info.data_width = STEDMA40_WORD_WIDTH,
 };
 
 static struct stedma40_chan_cfg mop500_sdi4_dma_cfg_tx = {
 	.mode = STEDMA40_MODE_LOGICAL,
 	.dir = STEDMA40_MEM_TO_PERIPH,
 	.dev_type = DB8500_DMA_DEV42_SD_MM4,
-	.src_info.data_width = STEDMA40_WORD_WIDTH,
-	.dst_info.data_width = STEDMA40_WORD_WIDTH,
 };
 #endif
 
-- 
1.7.10.4
