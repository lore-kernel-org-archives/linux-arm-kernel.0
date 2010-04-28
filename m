From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 28 Apr 2010 01:06:52 +0100
Subject: [PATCH 01/01] ARM: S3C2412: DMA: Remove I2S FIFO address
In-Reply-To: <1272351118-29175-1-git-send-email-jassi.brar@samsung.com>
References: <1272351118-29175-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <20100428000652.GC24020@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 27, 2010 at 03:51:58PM +0900, JassiBrar wrote:
> From: Jassi Brar <jassi.brar@samsung.com>
> 
> The S3C DMA API doesn't make use of hw_addr.to/from and also
> the FIFO addresses are provided from the I2S drivers. So these
> fields are redundant.
> This patch removes the hw_addr.to/from fields for I2S and the
> inclusion of header, paving way for the header to be moved closer
> to the I2S controller drivers.

Ok, if this works for -rc series then it may be something that could
be merged before we get to the next merge window.
 
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
> ---
>  arch/arm/mach-s3c2412/dma.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c2412/dma.c b/arch/arm/mach-s3c2412/dma.c
> index e880524..7abecfc 100644
> --- a/arch/arm/mach-s3c2412/dma.c
> +++ b/arch/arm/mach-s3c2412/dma.c
> @@ -30,7 +30,6 @@
>  #include <mach/regs-mem.h>
>  #include <mach/regs-lcd.h>
>  #include <mach/regs-sdi.h>
> -#include <plat/regs-s3c2412-iis.h>
>  #include <plat/regs-iis.h>
>  #include <plat/regs-spi.h>
>  
> @@ -119,13 +118,11 @@ static struct s3c24xx_dma_map __initdata s3c2412_dma_mappings[] = {
>  		.name		= "i2s-sdi",
>  		.channels	= MAP(S3C2412_DMAREQSEL_I2SRX),
>  		.channels_rx	= MAP(S3C2412_DMAREQSEL_I2SRX),
> -		.hw_addr.from	= S3C2410_PA_IIS + S3C2412_IISRXD,
>  	},
>  	[DMACH_I2S_OUT] = {
>  		.name		= "i2s-sdo",
>  		.channels	= MAP(S3C2412_DMAREQSEL_I2STX),
>  		.channels_rx	= MAP(S3C2412_DMAREQSEL_I2STX),
> -		.hw_addr.to	= S3C2410_PA_IIS + S3C2412_IISTXD,
>  	},
>  	[DMACH_USB_EP1] = {
>  		.name		= "usb-ep1",
> -- 
> 1.6.2.5
> 

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
