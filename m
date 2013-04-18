From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 18 Apr 2013 11:26:59 +0100
Subject: [PATCH 3/9] ARM: ux500: Stop passing Hash DMA channel config
 information though pdata
In-Reply-To: <1366280825-31136-1-git-send-email-lee.jones@linaro.org>
References: <1366280825-31136-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1366280825-31136-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DMA channel configuration information should be setup in the driver.
The Ux500 Hash driver now does this, so there's no need to send it
though here too.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 883dc66..cb7ae23 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -473,11 +473,7 @@ static struct cryp_platform_data u8500_cryp1_platform_data = {
 static struct stedma40_chan_cfg u8500_hash_dma_cfg_tx = {
 		.dir = STEDMA40_MEM_TO_PERIPH,
 		.dev_type = DB8500_DMA_DEV50_HAC1_TX,
-		.src_info.data_width = STEDMA40_WORD_WIDTH,
-		.dst_info.data_width = STEDMA40_WORD_WIDTH,
 		.mode = STEDMA40_MODE_LOGICAL,
-		.src_info.psize = STEDMA40_PSIZE_LOG_16,
-		.dst_info.psize = STEDMA40_PSIZE_LOG_16,
 };
 
 static struct hash_platform_data u8500_hash1_platform_data = {
-- 
1.7.10.4
