From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 10 Nov 2016 16:17:52 +0100
Subject: [PATCH 4/8] ARM: s3c64xx: Drop unused DMA fields from struct
 s3c64xx_spi_csinfo
In-Reply-To: <1478791076-19528-1-git-send-email-s.nawrocki@samsung.com>
References: <1478791076-19528-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1478791076-19528-5-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no drivers using those fields so remove them and
the remaining initializations.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Tested-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 arch/arm/plat-samsung/devs.c              | 24 ------------------------
 include/linux/platform_data/spi-s3c64xx.h |  3 ---
 2 files changed, 27 deletions(-)

diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index e93aa67..cf7b95f 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -1124,15 +1124,6 @@ void __init s3c64xx_spi0_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
 	pd.num_cs = num_cs;
 	pd.src_clk_nr = src_clk_nr;
 	pd.cfg_gpio = (cfg_gpio) ? cfg_gpio : s3c64xx_spi0_cfg_gpio;
-	pd.dma_tx = (void *)DMACH_SPI0_TX;
-	pd.dma_rx = (void *)DMACH_SPI0_RX;
-#if defined(CONFIG_PL330_DMA)
-	pd.filter = pl330_filter;
-#elif defined(CONFIG_S3C64XX_PL080)
-	pd.filter = pl08x_filter_id;
-#elif defined(CONFIG_S3C24XX_DMAC)
-	pd.filter = s3c24xx_dma_filter;
-#endif
 
 	s3c_set_platdata(&pd, sizeof(pd), &s3c64xx_device_spi0);
 }
@@ -1169,14 +1160,6 @@ void __init s3c64xx_spi1_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
 	pd.num_cs = num_cs;
 	pd.src_clk_nr = src_clk_nr;
 	pd.cfg_gpio = (cfg_gpio) ? cfg_gpio : s3c64xx_spi1_cfg_gpio;
-	pd.dma_tx = (void *)DMACH_SPI1_TX;
-	pd.dma_rx = (void *)DMACH_SPI1_RX;
-#if defined(CONFIG_PL330_DMA)
-	pd.filter = pl330_filter;
-#elif defined(CONFIG_S3C64XX_PL080)
-	pd.filter = pl08x_filter_id;
-#endif
-
 
 	s3c_set_platdata(&pd, sizeof(pd), &s3c64xx_device_spi1);
 }
@@ -1213,13 +1196,6 @@ void __init s3c64xx_spi2_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
 	pd.num_cs = num_cs;
 	pd.src_clk_nr = src_clk_nr;
 	pd.cfg_gpio = (cfg_gpio) ? cfg_gpio : s3c64xx_spi2_cfg_gpio;
-	pd.dma_tx = (void *)DMACH_SPI2_TX;
-	pd.dma_rx = (void *)DMACH_SPI2_RX;
-#if defined(CONFIG_PL330_DMA)
-	pd.filter = pl330_filter;
-#elif defined(CONFIG_S3C64XX_PL080)
-	pd.filter = pl08x_filter_id;
-#endif
 
 	s3c_set_platdata(&pd, sizeof(pd), &s3c64xx_device_spi2);
 }
diff --git a/include/linux/platform_data/spi-s3c64xx.h b/include/linux/platform_data/spi-s3c64xx.h
index 5c1e21c..da79774 100644
--- a/include/linux/platform_data/spi-s3c64xx.h
+++ b/include/linux/platform_data/spi-s3c64xx.h
@@ -40,9 +40,6 @@ struct s3c64xx_spi_info {
 	int num_cs;
 	bool no_cs;
 	int (*cfg_gpio)(void);
-	dma_filter_fn filter;
-	void *dma_tx;
-	void *dma_rx;
 };
 
 /**
-- 
1.9.1
