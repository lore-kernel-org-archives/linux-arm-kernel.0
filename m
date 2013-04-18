From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 18 Apr 2013 11:11:53 +0100
Subject: [PATCH 11/32] ARM: ux500: Remove unused 'data_width' attributes from
 UART DMA configs
In-Reply-To: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1366279934-30761-12-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DMA configuration data is now allocated in the UART driver, so these
are just ignored.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |   12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 35fd82f..883dc66 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -530,48 +530,36 @@ static struct stedma40_chan_cfg uart0_dma_cfg_rx = {
 	.mode = STEDMA40_MODE_LOGICAL,
 	.dir = STEDMA40_PERIPH_TO_MEM,
 	.dev_type = DB8500_DMA_DEV13_UART0,
-	.src_info.data_width = STEDMA40_BYTE_WIDTH,
-	.dst_info.data_width = STEDMA40_BYTE_WIDTH,
 };
 
 static struct stedma40_chan_cfg uart0_dma_cfg_tx = {
 	.mode = STEDMA40_MODE_LOGICAL,
 	.dir = STEDMA40_MEM_TO_PERIPH,
 	.dev_type = DB8500_DMA_DEV13_UART0,
-	.src_info.data_width = STEDMA40_BYTE_WIDTH,
-	.dst_info.data_width = STEDMA40_BYTE_WIDTH,
 };
 
 static struct stedma40_chan_cfg uart1_dma_cfg_rx = {
 	.mode = STEDMA40_MODE_LOGICAL,
 	.dir = STEDMA40_PERIPH_TO_MEM,
 	.dev_type = DB8500_DMA_DEV12_UART1,
-	.src_info.data_width = STEDMA40_BYTE_WIDTH,
-	.dst_info.data_width = STEDMA40_BYTE_WIDTH,
 };
 
 static struct stedma40_chan_cfg uart1_dma_cfg_tx = {
 	.mode = STEDMA40_MODE_LOGICAL,
 	.dir = STEDMA40_MEM_TO_PERIPH,
 	.dev_type = DB8500_DMA_DEV12_UART1,
-	.src_info.data_width = STEDMA40_BYTE_WIDTH,
-	.dst_info.data_width = STEDMA40_BYTE_WIDTH,
 };
 
 static struct stedma40_chan_cfg uart2_dma_cfg_rx = {
 	.mode = STEDMA40_MODE_LOGICAL,
 	.dir = STEDMA40_PERIPH_TO_MEM,
 	.dev_type = DB8500_DMA_DEV11_UART2,
-	.src_info.data_width = STEDMA40_BYTE_WIDTH,
-	.dst_info.data_width = STEDMA40_BYTE_WIDTH,
 };
 
 static struct stedma40_chan_cfg uart2_dma_cfg_tx = {
 	.mode = STEDMA40_MODE_LOGICAL,
 	.dir = STEDMA40_MEM_TO_PERIPH,
 	.dev_type = DB8500_DMA_DEV11_UART2,
-	.src_info.data_width = STEDMA40_BYTE_WIDTH,
-	.dst_info.data_width = STEDMA40_BYTE_WIDTH,
 };
 #endif
 
-- 
1.7.10.4
