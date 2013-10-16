From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 16 Oct 2013 21:10:55 +0200
Subject: [PATCH v2 4/8] clk: samsung: s3c64xx: Add aliases for DMA clocks
In-Reply-To: <1381950659-12703-1-git-send-email-tomasz.figa@gmail.com>
References: <1381950659-12703-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1381950659-12703-5-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds clkdev aliases for clocks used by PL08x DMA driver.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/clk/samsung/clk-s3c64xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/samsung/clk-s3c64xx.c b/drivers/clk/samsung/clk-s3c64xx.c
index 7d2c842..06cf105 100644
--- a/drivers/clk/samsung/clk-s3c64xx.c
+++ b/drivers/clk/samsung/clk-s3c64xx.c
@@ -332,7 +332,9 @@ static struct samsung_clock_alias s3c64xx_clock_aliases[] = {
 	ALIAS(HCLK_HSMMC0, "s3c-sdhci.0", "hsmmc"),
 	ALIAS(HCLK_HSMMC0, "s3c-sdhci.0", "mmc_busclk.0"),
 	ALIAS(HCLK_DMA1, NULL, "dma1"),
+	ALIAS(HCLK_DMA1, "dma-pl080s.1", "apb_pclk"),
 	ALIAS(HCLK_DMA0, NULL, "dma0"),
+	ALIAS(HCLK_DMA0, "dma-pl080s.0", "apb_pclk"),
 	ALIAS(HCLK_CAMIF, "s3c-camif", "camif"),
 	ALIAS(HCLK_LCD, "s3c-fb", "lcd"),
 	ALIAS(PCLK_SPI1, "s3c6410-spi.1", "spi"),
-- 
1.8.3.2
