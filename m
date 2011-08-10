From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Wed, 10 Aug 2011 12:28:56 +0200
Subject: [PATCH 1/2] Remove hw_addr from s3c24XX dma channel declarations
In-Reply-To: <201108101227.32780.heiko@sntech.de>
References: <201108101227.32780.heiko@sntech.de>
Message-ID: <201108101228.56729.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to commit c4806174c516d26bf4a72db1789cfc96e4950d07
(ARM: S3C2412: DMA: Remove I2S FIFO address) the S3C DMA API does not
make use of hw_addr.to/from declared for some of the channels in
mach-s3c24XX/dma.c

Grepping through the kernel also did non reveal any new users of
these properties since the mentioned commit.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c2410/dma.c |   14 --------------
 arch/arm/mach-s3c2412/dma.c |   18 ------------------
 arch/arm/mach-s3c2440/dma.c |   17 -----------------
 arch/arm/mach-s3c2443/dma.c |   27 ---------------------------
 4 files changed, 0 insertions(+), 76 deletions(-)

diff --git a/arch/arm/mach-s3c2410/dma.c b/arch/arm/mach-s3c2410/dma.c
index 0d8e043..dbe43df 100644
--- a/arch/arm/mach-s3c2410/dma.c
+++ b/arch/arm/mach-s3c2410/dma.c
@@ -47,38 +47,26 @@ static struct s3c24xx_dma_map __initdata s3c2410_dma_mappings[] = {
 		.channels[0]	= S3C2410_DCON_CH0_SDI | DMA_CH_VALID,
 		.channels[2]	= S3C2410_DCON_CH2_SDI | DMA_CH_VALID,
 		.channels[3]	= S3C2410_DCON_CH3_SDI | DMA_CH_VALID,
-		.hw_addr.to	= S3C2410_PA_IIS + S3C2410_IISFIFO,
-		.hw_addr.from	= S3C2410_PA_IIS + S3C2410_IISFIFO,
 	},
 	[DMACH_SPI0] = {
 		.name		= "spi0",
 		.channels[1]	= S3C2410_DCON_CH1_SPI | DMA_CH_VALID,
-		.hw_addr.to	= S3C2410_PA_SPI + S3C2410_SPTDAT,
-		.hw_addr.from	= S3C2410_PA_SPI + S3C2410_SPRDAT,
 	},
 	[DMACH_SPI1] = {
 		.name		= "spi1",
 		.channels[3]	= S3C2410_DCON_CH3_SPI | DMA_CH_VALID,
-		.hw_addr.to	= S3C2410_PA_SPI + 0x20 + S3C2410_SPTDAT,
-		.hw_addr.from	= S3C2410_PA_SPI + 0x20 + S3C2410_SPRDAT,
 	},
 	[DMACH_UART0] = {
 		.name		= "uart0",
 		.channels[0]	= S3C2410_DCON_CH0_UART0 | DMA_CH_VALID,
-		.hw_addr.to	= S3C2410_PA_UART0 + S3C2410_UTXH,
-		.hw_addr.from	= S3C2410_PA_UART0 + S3C2410_URXH,
 	},
 	[DMACH_UART1] = {
 		.name		= "uart1",
 		.channels[1]	= S3C2410_DCON_CH1_UART1 | DMA_CH_VALID,
-		.hw_addr.to	= S3C2410_PA_UART1 + S3C2410_UTXH,
-		.hw_addr.from	= S3C2410_PA_UART1 + S3C2410_URXH,
 	},
       	[DMACH_UART2] = {
 		.name		= "uart2",
 		.channels[3]	= S3C2410_DCON_CH3_UART2 | DMA_CH_VALID,
-		.hw_addr.to	= S3C2410_PA_UART2 + S3C2410_UTXH,
-		.hw_addr.from	= S3C2410_PA_UART2 + S3C2410_URXH,
 	},
 	[DMACH_TIMER] = {
 		.name		= "timer",
@@ -90,12 +78,10 @@ static struct s3c24xx_dma_map __initdata s3c2410_dma_mappings[] = {
 		.name		= "i2s-sdi",
 		.channels[1]	= S3C2410_DCON_CH1_I2SSDI | DMA_CH_VALID,
 		.channels[2]	= S3C2410_DCON_CH2_I2SSDI | DMA_CH_VALID,
-		.hw_addr.from	= S3C2410_PA_IIS + S3C2410_IISFIFO,
 	},
 	[DMACH_I2S_OUT] = {
 		.name		= "i2s-sdo",
 		.channels[2]	= S3C2410_DCON_CH2_I2SSDO | DMA_CH_VALID,
-		.hw_addr.to	= S3C2410_PA_IIS + S3C2410_IISFIFO,
 	},
 	[DMACH_USB_EP1] = {
 		.name		= "usb-ep1",
diff --git a/arch/arm/mach-s3c2412/dma.c b/arch/arm/mach-s3c2412/dma.c
index 7abecfc..c61e326 100644
--- a/arch/arm/mach-s3c2412/dma.c
+++ b/arch/arm/mach-s3c2412/dma.c
@@ -50,64 +50,46 @@ static struct s3c24xx_dma_map __initdata s3c2412_dma_mappings[] = {
 		.name		= "sdi",
 		.channels	= MAP(S3C2412_DMAREQSEL_SDI),
 		.channels_rx	= MAP(S3C2412_DMAREQSEL_SDI),
-		.hw_addr.to	= S3C2410_PA_SDI + S3C2410_SDIDATA,
-		.hw_addr.from	= S3C2410_PA_SDI + S3C2410_SDIDATA,
 	},
 	[DMACH_SPI0] = {
 		.name		= "spi0",
 		.channels	= MAP(S3C2412_DMAREQSEL_SPI0TX),
 		.channels_rx	= MAP(S3C2412_DMAREQSEL_SPI0RX),
-		.hw_addr.to	= S3C2410_PA_SPI + S3C2410_SPTDAT,
-		.hw_addr.from	= S3C2410_PA_SPI + S3C2410_SPRDAT,
 	},
 	[DMACH_SPI1] = {
 		.name		= "spi1",
 		.channels	= MAP(S3C2412_DMAREQSEL_SPI1TX),
 		.channels_rx	= MAP(S3C2412_DMAREQSEL_SPI1RX),
-		.hw_addr.to	= S3C2410_PA_SPI + S3C2412_SPI1 + S3C2410_SPTDAT,
-		.hw_addr.from	= S3C2410_PA_SPI + S3C2412_SPI1  + S3C2410_SPRDAT,
 	},
 	[DMACH_UART0] = {
 		.name		= "uart0",
 		.channels	= MAP(S3C2412_DMAREQSEL_UART0_0),
 		.channels_rx	= MAP(S3C2412_DMAREQSEL_UART0_0),
-		.hw_addr.to	= S3C2410_PA_UART0 + S3C2410_UTXH,
-		.hw_addr.from	= S3C2410_PA_UART0 + S3C2410_URXH,
 	},
 	[DMACH_UART1] = {
 		.name		= "uart1",
 		.channels	= MAP(S3C2412_DMAREQSEL_UART1_0),
 		.channels_rx	= MAP(S3C2412_DMAREQSEL_UART1_0),
-		.hw_addr.to	= S3C2410_PA_UART1 + S3C2410_UTXH,
-		.hw_addr.from	= S3C2410_PA_UART1 + S3C2410_URXH,
 	},
       	[DMACH_UART2] = {
 		.name		= "uart2",
 		.channels	= MAP(S3C2412_DMAREQSEL_UART2_0),
 		.channels_rx	= MAP(S3C2412_DMAREQSEL_UART2_0),
-		.hw_addr.to	= S3C2410_PA_UART2 + S3C2410_UTXH,
-		.hw_addr.from	= S3C2410_PA_UART2 + S3C2410_URXH,
 	},
 	[DMACH_UART0_SRC2] = {
 		.name		= "uart0",
 		.channels	= MAP(S3C2412_DMAREQSEL_UART0_1),
 		.channels_rx	= MAP(S3C2412_DMAREQSEL_UART0_1),
-		.hw_addr.to	= S3C2410_PA_UART0 + S3C2410_UTXH,
-		.hw_addr.from	= S3C2410_PA_UART0 + S3C2410_URXH,
 	},
 	[DMACH_UART1_SRC2] = {
 		.name		= "uart1",
 		.channels	= MAP(S3C2412_DMAREQSEL_UART1_1),
 		.channels_rx	= MAP(S3C2412_DMAREQSEL_UART1_1),
-		.hw_addr.to	= S3C2410_PA_UART1 + S3C2410_UTXH,
-		.hw_addr.from	= S3C2410_PA_UART1 + S3C2410_URXH,
 	},
       	[DMACH_UART2_SRC2] = {
 		.name		= "uart2",
 		.channels	= MAP(S3C2412_DMAREQSEL_UART2_1),
 		.channels_rx	= MAP(S3C2412_DMAREQSEL_UART2_1),
-		.hw_addr.to	= S3C2410_PA_UART2 + S3C2410_UTXH,
-		.hw_addr.from	= S3C2410_PA_UART2 + S3C2410_URXH,
 	},
 	[DMACH_TIMER] = {
 		.name		= "timer",
diff --git a/arch/arm/mach-s3c2440/dma.c b/arch/arm/mach-s3c2440/dma.c
index 3b0529f..0e73f8f 100644
--- a/arch/arm/mach-s3c2440/dma.c
+++ b/arch/arm/mach-s3c2440/dma.c
@@ -48,38 +48,26 @@ static struct s3c24xx_dma_map __initdata s3c2440_dma_mappings[] = {
 		.channels[1]	= S3C2440_DCON_CH1_SDI | DMA_CH_VALID,
 		.channels[2]	= S3C2410_DCON_CH2_SDI | DMA_CH_VALID,
 		.channels[3]	= S3C2410_DCON_CH3_SDI | DMA_CH_VALID,
-		.hw_addr.to	= S3C2410_PA_IIS + S3C2410_IISFIFO,
-		.hw_addr.from	= S3C2410_PA_IIS + S3C2410_IISFIFO,
 	},
 	[DMACH_SPI0] = {
 		.name		= "spi0",
 		.channels[1]	= S3C2410_DCON_CH1_SPI | DMA_CH_VALID,
-		.hw_addr.to	= S3C2410_PA_SPI + S3C2410_SPTDAT,
-		.hw_addr.from	= S3C2410_PA_SPI + S3C2410_SPRDAT,
 	},
 	[DMACH_SPI1] = {
 		.name		= "spi1",
 		.channels[3]	= S3C2410_DCON_CH3_SPI | DMA_CH_VALID,
-		.hw_addr.to	= S3C2410_PA_SPI + 0x20 + S3C2410_SPTDAT,
-		.hw_addr.from	= S3C2410_PA_SPI + 0x20 + S3C2410_SPRDAT,
 	},
 	[DMACH_UART0] = {
 		.name		= "uart0",
 		.channels[0]	= S3C2410_DCON_CH0_UART0 | DMA_CH_VALID,
-		.hw_addr.to	= S3C2410_PA_UART0 + S3C2410_UTXH,
-		.hw_addr.from	= S3C2410_PA_UART0 + S3C2410_URXH,
 	},
 	[DMACH_UART1] = {
 		.name		= "uart1",
 		.channels[1]	= S3C2410_DCON_CH1_UART1 | DMA_CH_VALID,
-		.hw_addr.to	= S3C2410_PA_UART1 + S3C2410_UTXH,
-		.hw_addr.from	= S3C2410_PA_UART1 + S3C2410_URXH,
 	},
       	[DMACH_UART2] = {
 		.name		= "uart2",
 		.channels[3]	= S3C2410_DCON_CH3_UART2 | DMA_CH_VALID,
-		.hw_addr.to	= S3C2410_PA_UART2 + S3C2410_UTXH,
-		.hw_addr.from	= S3C2410_PA_UART2 + S3C2410_URXH,
 	},
 	[DMACH_TIMER] = {
 		.name		= "timer",
@@ -91,31 +79,26 @@ static struct s3c24xx_dma_map __initdata s3c2440_dma_mappings[] = {
 		.name		= "i2s-sdi",
 		.channels[1]	= S3C2410_DCON_CH1_I2SSDI | DMA_CH_VALID,
 		.channels[2]	= S3C2410_DCON_CH2_I2SSDI | DMA_CH_VALID,
-		.hw_addr.from	= S3C2410_PA_IIS + S3C2410_IISFIFO,
 	},
 	[DMACH_I2S_OUT] = {
 		.name		= "i2s-sdo",
 		.channels[0]	= S3C2440_DCON_CH0_I2SSDO | DMA_CH_VALID,
 		.channels[2]	= S3C2410_DCON_CH2_I2SSDO | DMA_CH_VALID,
-		.hw_addr.to	= S3C2410_PA_IIS + S3C2410_IISFIFO,
 	},
 	[DMACH_PCM_IN] = {
 		.name		= "pcm-in",
 		.channels[0]	= S3C2440_DCON_CH0_PCMIN | DMA_CH_VALID,
 		.channels[2]	= S3C2440_DCON_CH2_PCMIN | DMA_CH_VALID,
-		.hw_addr.from	= S3C2440_PA_AC97 + S3C_AC97_PCM_DATA,
 	},
 	[DMACH_PCM_OUT] = {
 		.name		= "pcm-out",
 		.channels[1]	= S3C2440_DCON_CH1_PCMOUT | DMA_CH_VALID,
 		.channels[3]	= S3C2440_DCON_CH3_PCMOUT | DMA_CH_VALID,
-		.hw_addr.to	= S3C2440_PA_AC97 + S3C_AC97_PCM_DATA,
 	},
 	[DMACH_MIC_IN] = {
 		.name		= "mic-in",
 		.channels[2]	= S3C2440_DCON_CH2_MICIN | DMA_CH_VALID,
 		.channels[3]	= S3C2440_DCON_CH3_MICIN | DMA_CH_VALID,
-		.hw_addr.from	= S3C2440_PA_AC97 + S3C_AC97_MIC_DATA,
 	},
 	[DMACH_USB_EP1] = {
 		.name		= "usb-ep1",
diff --git a/arch/arm/mach-s3c2443/dma.c b/arch/arm/mach-s3c2443/dma.c
index 3f65868..fe52151 100644
--- a/arch/arm/mach-s3c2443/dma.c
+++ b/arch/arm/mach-s3c2443/dma.c
@@ -54,68 +54,46 @@ static struct s3c24xx_dma_map __initdata s3c2443_dma_mappings[] = {
 	[DMACH_SDI] = {
 		.name		= "sdi",
 		.channels	= MAP(S3C2443_DMAREQSEL_SDI),
-		.hw_addr.to	= S3C2410_PA_IIS + S3C2410_IISFIFO,
-		.hw_addr.from	= S3C2410_PA_IIS + S3C2410_IISFIFO,
 	},
 	[DMACH_SPI0] = {
 		.name		= "spi0",
 		.channels	= MAP(S3C2443_DMAREQSEL_SPI0TX),
-		.hw_addr.to	= S3C2410_PA_SPI + S3C2410_SPTDAT,
-		.hw_addr.from	= S3C2410_PA_SPI + S3C2410_SPRDAT,
 	},
 	[DMACH_SPI1] = {
 		.name		= "spi1",
 		.channels	= MAP(S3C2443_DMAREQSEL_SPI1TX),
-		.hw_addr.to	= S3C2410_PA_SPI + 0x20 + S3C2410_SPTDAT,
-		.hw_addr.from	= S3C2410_PA_SPI + 0x20 + S3C2410_SPRDAT,
 	},
 	[DMACH_UART0] = {
 		.name		= "uart0",
 		.channels	= MAP(S3C2443_DMAREQSEL_UART0_0),
-		.hw_addr.to	= S3C2410_PA_UART0 + S3C2410_UTXH,
-		.hw_addr.from	= S3C2410_PA_UART0 + S3C2410_URXH,
 	},
 	[DMACH_UART1] = {
 		.name		= "uart1",
 		.channels	= MAP(S3C2443_DMAREQSEL_UART1_0),
-		.hw_addr.to	= S3C2410_PA_UART1 + S3C2410_UTXH,
-		.hw_addr.from	= S3C2410_PA_UART1 + S3C2410_URXH,
 	},
       	[DMACH_UART2] = {
 		.name		= "uart2",
 		.channels	= MAP(S3C2443_DMAREQSEL_UART2_0),
-		.hw_addr.to	= S3C2410_PA_UART2 + S3C2410_UTXH,
-		.hw_addr.from	= S3C2410_PA_UART2 + S3C2410_URXH,
 	},
       	[DMACH_UART3] = {
 		.name		= "uart3",
 		.channels	= MAP(S3C2443_DMAREQSEL_UART3_0),
-		.hw_addr.to	= S3C2443_PA_UART3 + S3C2410_UTXH,
-		.hw_addr.from	= S3C2443_PA_UART3 + S3C2410_URXH,
 	},
 	[DMACH_UART0_SRC2] = {
 		.name		= "uart0",
 		.channels	= MAP(S3C2443_DMAREQSEL_UART0_1),
-		.hw_addr.to	= S3C2410_PA_UART0 + S3C2410_UTXH,
-		.hw_addr.from	= S3C2410_PA_UART0 + S3C2410_URXH,
 	},
 	[DMACH_UART1_SRC2] = {
 		.name		= "uart1",
 		.channels	= MAP(S3C2443_DMAREQSEL_UART1_1),
-		.hw_addr.to	= S3C2410_PA_UART1 + S3C2410_UTXH,
-		.hw_addr.from	= S3C2410_PA_UART1 + S3C2410_URXH,
 	},
       	[DMACH_UART2_SRC2] = {
 		.name		= "uart2",
 		.channels	= MAP(S3C2443_DMAREQSEL_UART2_1),
-		.hw_addr.to	= S3C2410_PA_UART2 + S3C2410_UTXH,
-		.hw_addr.from	= S3C2410_PA_UART2 + S3C2410_URXH,
 	},
       	[DMACH_UART3_SRC2] = {
 		.name		= "uart3",
 		.channels	= MAP(S3C2443_DMAREQSEL_UART3_1),
-		.hw_addr.to	= S3C2443_PA_UART3 + S3C2410_UTXH,
-		.hw_addr.from	= S3C2443_PA_UART3 + S3C2410_URXH,
 	},
 	[DMACH_TIMER] = {
 		.name		= "timer",
@@ -124,27 +102,22 @@ static struct s3c24xx_dma_map __initdata s3c2443_dma_mappings[] = {
 	[DMACH_I2S_IN] = {
 		.name		= "i2s-sdi",
 		.channels	= MAP(S3C2443_DMAREQSEL_I2SRX),
-		.hw_addr.from	= S3C2410_PA_IIS + S3C2410_IISFIFO,
 	},
 	[DMACH_I2S_OUT] = {
 		.name		= "i2s-sdo",
 		.channels	= MAP(S3C2443_DMAREQSEL_I2STX),
-		.hw_addr.to	= S3C2410_PA_IIS + S3C2410_IISFIFO,
 	},
 	[DMACH_PCM_IN] = {
 		.name		= "pcm-in",
 		.channels	= MAP(S3C2443_DMAREQSEL_PCMIN),
-		.hw_addr.from	= S3C2440_PA_AC97 + S3C_AC97_PCM_DATA,
 	},
 	[DMACH_PCM_OUT] = {
 		.name		= "pcm-out",
 		.channels	= MAP(S3C2443_DMAREQSEL_PCMOUT),
-		.hw_addr.to	= S3C2440_PA_AC97 + S3C_AC97_PCM_DATA,
 	},
 	[DMACH_MIC_IN] = {
 		.name		= "mic-in",
 		.channels	= MAP(S3C2443_DMAREQSEL_MICIN),
-		.hw_addr.from	= S3C2440_PA_AC97 + S3C_AC97_MIC_DATA,
 	},
 };
 
-- 
1.7.5.4
