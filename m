From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sun, 21 Apr 2013 20:04:33 +0200
Subject: [PATCH 3/3] ARM: S3C24XX: remove obsolete s3c2412 specific dma
 settings
In-Reply-To: <201304212002.31082.heiko@sntech.de>
References: <201304212002.31082.heiko@sntech.de>
Message-ID: <201304212004.33544.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The s3c2412 dma init contained code to handle dma-direction specific
settings. As now all s3c2412-dma-channels are direction-independent this
is not needed anymore.

As the s3c2412 also was the only user of this, it can go away completely.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/dma-s3c2412.c              |   42 ++--------------------
 arch/arm/mach-s3c24xx/dma.c                      |    3 --
 arch/arm/plat-samsung/include/plat/dma-s3c24xx.h |    5 ---
 3 files changed, 3 insertions(+), 47 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/dma-s3c2412.c b/arch/arm/mach-s3c24xx/dma-s3c2412.c
index 8d8a679..9950400 100644
--- a/arch/arm/mach-s3c24xx/dma-s3c2412.c
+++ b/arch/arm/mach-s3c24xx/dma-s3c2412.c
@@ -37,131 +37,95 @@ static struct s3c24xx_dma_map __initdata s3c2412_dma_mappings[] = {
 	[DMACH_XD0] = {
 		.name		= "xdreq0",
 		.channels	= MAP(S3C2412_DMAREQSEL_XDREQ0),
-		.channels_rx	= MAP(S3C2412_DMAREQSEL_XDREQ0),
 	},
 	[DMACH_XD1] = {
 		.name		= "xdreq1",
 		.channels	= MAP(S3C2412_DMAREQSEL_XDREQ1),
-		.channels_rx	= MAP(S3C2412_DMAREQSEL_XDREQ1),
 	},
 	[DMACH_SDI] = {
 		.name		= "sdi",
 		.channels	= MAP(S3C2412_DMAREQSEL_SDI),
-		.channels_rx	= MAP(S3C2412_DMAREQSEL_SDI),
 	},
 	[DMACH_SPI0_RX] = {
 		.name		= "spi0-rx",
 		.channels	= MAP(S3C2412_DMAREQSEL_SPI0RX),
-		.channels_rx	= MAP(S3C2412_DMAREQSEL_SPI0RX),
 	},
 	[DMACH_SPI0_TX] = {
 		.name		= "spi0-tx",
 		.channels	= MAP(S3C2412_DMAREQSEL_SPI0TX),
-		.channels_rx	= MAP(S3C2412_DMAREQSEL_SPI0TX),
 	},
 	[DMACH_SPI1_RX] = {
 		.name		= "spi1-rx",
 		.channels	= MAP(S3C2412_DMAREQSEL_SPI1RX),
-		.channels_rx	= MAP(S3C2412_DMAREQSEL_SPI1RX),
 	},
 	[DMACH_SPI1_TX] = {
 		.name		= "spi1-tx",
 		.channels	= MAP(S3C2412_DMAREQSEL_SPI1TX),
-		.channels_rx	= MAP(S3C2412_DMAREQSEL_SPI1TX),
 	},
 	[DMACH_UART0] = {
 		.name		= "uart0",
 		.channels	= MAP(S3C2412_DMAREQSEL_UART0_0),
-		.channels_rx	= MAP(S3C2412_DMAREQSEL_UART0_0),
 	},
 	[DMACH_UART1] = {
 		.name		= "uart1",
 		.channels	= MAP(S3C2412_DMAREQSEL_UART1_0),
-		.channels_rx	= MAP(S3C2412_DMAREQSEL_UART1_0),
 	},
       	[DMACH_UART2] = {
 		.name		= "uart2",
 		.channels	= MAP(S3C2412_DMAREQSEL_UART2_0),
-		.channels_rx	= MAP(S3C2412_DMAREQSEL_UART2_0),
 	},
 	[DMACH_UART0_SRC2] = {
 		.name		= "uart0",
 		.channels	= MAP(S3C2412_DMAREQSEL_UART0_1),
-		.channels_rx	= MAP(S3C2412_DMAREQSEL_UART0_1),
 	},
 	[DMACH_UART1_SRC2] = {
 		.name		= "uart1",
 		.channels	= MAP(S3C2412_DMAREQSEL_UART1_1),
-		.channels_rx	= MAP(S3C2412_DMAREQSEL_UART1_1),
 	},
       	[DMACH_UART2_SRC2] = {
 		.name		= "uart2",
 		.channels	= MAP(S3C2412_DMAREQSEL_UART2_1),
-		.channels_rx	= MAP(S3C2412_DMAREQSEL_UART2_1),
 	},
 	[DMACH_TIMER] = {
 		.name		= "timer",
 		.channels	= MAP(S3C2412_DMAREQSEL_TIMER),
-		.channels_rx	= MAP(S3C2412_DMAREQSEL_TIMER),
 	},
 	[DMACH_I2S_IN] = {
 		.name		= "i2s-sdi",
 		.channels	= MAP(S3C2412_DMAREQSEL_I2SRX),
-		.channels_rx	= MAP(S3C2412_DMAREQSEL_I2SRX),
 	},
 	[DMACH_I2S_OUT] = {
 		.name		= "i2s-sdo",
 		.channels	= MAP(S3C2412_DMAREQSEL_I2STX),
-		.channels_rx	= MAP(S3C2412_DMAREQSEL_I2STX),
 	},
 	[DMACH_USB_EP1] = {
 		.name		= "usb-ep1",
 		.channels	= MAP(S3C2412_DMAREQSEL_USBEP1),
-		.channels_rx	= MAP(S3C2412_DMAREQSEL_USBEP1),
 	},
 	[DMACH_USB_EP2] = {
 		.name		= "usb-ep2",
 		.channels	= MAP(S3C2412_DMAREQSEL_USBEP2),
-		.channels_rx	= MAP(S3C2412_DMAREQSEL_USBEP2),
 	},
 	[DMACH_USB_EP3] = {
 		.name		= "usb-ep3",
 		.channels	= MAP(S3C2412_DMAREQSEL_USBEP3),
-		.channels_rx	= MAP(S3C2412_DMAREQSEL_USBEP3),
 	},
 	[DMACH_USB_EP4] = {
 		.name		= "usb-ep4",
 		.channels	= MAP(S3C2412_DMAREQSEL_USBEP4),
-		.channels_rx	= MAP(S3C2412_DMAREQSEL_USBEP4),
 	},
 };
 
-static void s3c2412_dma_direction(struct s3c2410_dma_chan *chan,
-				  struct s3c24xx_dma_map *map,
-				  enum dma_data_direction dir)
-{
-	unsigned long chsel;
-
-	if (dir == DMA_FROM_DEVICE)
-		chsel = map->channels_rx[0];
-	else
-		chsel = map->channels[0];
-
-	chsel &= ~DMA_CH_VALID;
-	chsel |= S3C2412_DMAREQSEL_HW;
-
-	writel(chsel, chan->regs + S3C2412_DMA_DMAREQSEL);
-}
-
 static void s3c2412_dma_select(struct s3c2410_dma_chan *chan,
 			       struct s3c24xx_dma_map *map)
 {
-	s3c2412_dma_direction(chan, map, chan->source);
+	unsigned long chsel = map->channels[0] & (~DMA_CH_VALID);
+	writel(chsel | S3C2412_DMAREQSEL_HW,
+	       chan->regs + S3C2412_DMA_DMAREQSEL);
 }
 
 static struct s3c24xx_dma_selection __initdata s3c2412_dma_sel = {
 	.select		= s3c2412_dma_select,
-	.direction	= s3c2412_dma_direction,
 	.dcon_mask	= 0,
 	.map		= s3c2412_dma_mappings,
 	.map_size	= ARRAY_SIZE(s3c2412_dma_mappings),
diff --git a/arch/arm/mach-s3c24xx/dma.c b/arch/arm/mach-s3c24xx/dma.c
index aab6490..4a65cba 100644
--- a/arch/arm/mach-s3c24xx/dma.c
+++ b/arch/arm/mach-s3c24xx/dma.c
@@ -1159,9 +1159,6 @@ int s3c2410_dma_devconfig(enum dma_ch channel,
 		return -EINVAL;
 	}
 
-	if (dma_sel.direction != NULL)
-		(dma_sel.direction)(chan, chan->map, source);
-
 	return 0;
 }
 
diff --git a/arch/arm/plat-samsung/include/plat/dma-s3c24xx.h b/arch/arm/plat-samsung/include/plat/dma-s3c24xx.h
index d015763..bd3a6db 100644
--- a/arch/arm/plat-samsung/include/plat/dma-s3c24xx.h
+++ b/arch/arm/plat-samsung/include/plat/dma-s3c24xx.h
@@ -28,7 +28,6 @@ struct s3c24xx_dma_map {
 	const char		*name;
 
 	unsigned long		 channels[S3C_DMA_CHANNELS];
-	unsigned long		 channels_rx[S3C_DMA_CHANNELS];
 };
 
 struct s3c24xx_dma_selection {
@@ -38,10 +37,6 @@ struct s3c24xx_dma_selection {
 
 	void	(*select)(struct s3c2410_dma_chan *chan,
 			  struct s3c24xx_dma_map *map);
-
-	void	(*direction)(struct s3c2410_dma_chan *chan,
-			     struct s3c24xx_dma_map *map,
-			     enum dma_data_direction dir);
 };
 
 extern int s3c24xx_dma_init_map(struct s3c24xx_dma_selection *sel);
-- 
1.7.2.3
