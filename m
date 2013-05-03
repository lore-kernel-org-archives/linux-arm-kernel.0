From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  3 May 2013 15:32:27 +0100
Subject: [PATCH 41/63] ARM: ux500: Stop passing Cryp DMA channel config
 information though pdata
In-Reply-To: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1367591569-32197-42-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DMA channel configuration information should be setup in the driver.
The Ux500 Cryp driver now does this, so there's no need to send it
though here too.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index cb7ae23..7f756cc 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -453,20 +453,12 @@ static struct cryp_platform_data u8500_cryp1_platform_data = {
 		.mem_to_engine = {
 				.dir = STEDMA40_MEM_TO_PERIPH,
 				.dev_type = DB8500_DMA_DEV48_CAC1,
-				.src_info.data_width = STEDMA40_WORD_WIDTH,
-				.dst_info.data_width = STEDMA40_WORD_WIDTH,
 				.mode = STEDMA40_MODE_LOGICAL,
-				.src_info.psize = STEDMA40_PSIZE_LOG_4,
-				.dst_info.psize = STEDMA40_PSIZE_LOG_4,
 		},
 		.engine_to_mem = {
 				.dir = STEDMA40_PERIPH_TO_MEM,
 				.dev_type = DB8500_DMA_DEV48_CAC1,
-				.src_info.data_width = STEDMA40_WORD_WIDTH,
-				.dst_info.data_width = STEDMA40_WORD_WIDTH,
 				.mode = STEDMA40_MODE_LOGICAL,
-				.src_info.psize = STEDMA40_PSIZE_LOG_4,
-				.dst_info.psize = STEDMA40_PSIZE_LOG_4,
 		}
 };
 
-- 
1.7.10.4
