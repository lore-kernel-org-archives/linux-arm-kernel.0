From: padma.v@samsung.com (Padmavathi Venna)
Date: Thu, 27 Sep 2012 15:59:17 +0530
Subject: [PATCH V2] ARM: SAMSUNG: Delete the unnecessary variable
Message-ID: <1348741757-29539-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the RCLK src clks are registered with clkdev using generic
connection id , these clk names need not to be passed through
platform data. So it is deleted.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/plat-samsung/include/plat/audio.h |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/audio.h b/arch/arm/plat-samsung/include/plat/audio.h
index aa9875f..8827259 100644
--- a/arch/arm/plat-samsung/include/plat/audio.h
+++ b/arch/arm/plat-samsung/include/plat/audio.h
@@ -38,12 +38,6 @@ struct samsung_i2s {
 #define QUIRK_NEED_RSTCLR	(1 << 3)
 	/* Quirks of the I2S controller */
 	u32 quirks;
-
-	/*
-	 * Array of clock names that can be used to generate I2S signals.
-	 * Also corresponds to clocks of I2SMOD[10]
-	 */
-	const char **src_clk;
 	dma_addr_t idma_addr;
 };
 
-- 
1.7.4.4
