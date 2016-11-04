From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 04 Nov 2016 17:14:53 +0100
Subject: [PATCH RFC 6/7] ARM: S3C64XX: Drop unused DMA fields from struct
 s3c64xx_spi_csinfo
In-Reply-To: <1478276094-19135-1-git-send-email-s.nawrocki@samsung.com>
References: <1478276094-19135-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1478276094-19135-8-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no drivers using those fields so remove them and
remaining initializations.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/plat-samsung/devs.c              | 9 ---------
 include/linux/platform_data/spi-s3c64xx.h | 3 ---
 2 files changed, 12 deletions(-)

diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index e93aa67..4e14bf6 100644
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
