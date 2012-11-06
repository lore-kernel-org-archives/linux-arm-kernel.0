From: padma.v@samsung.com (Padmavathi Venna)
Date: Tue, 06 Nov 2012 10:23:38 +0530
Subject: [PATCH V3] ARM: SAMSUNG: Delete the unnecessary variable
Message-ID: <1352177618-16460-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the RCLK src clks are registered with clkdev using generic
connection id , these clk names need not to be passed through
platform data. So it is deleted.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---

Changes since V2:
	- Rebased on 3.7-rc3
	
 include/linux/platform_data/asoc-s3c.h |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/include/linux/platform_data/asoc-s3c.h b/include/linux/platform_data/asoc-s3c.h
index aa9875f..8827259 100644
--- a/include/linux/platform_data/asoc-s3c.h
+++ b/include/linux/platform_data/asoc-s3c.h
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
