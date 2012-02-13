From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 13 Feb 2012 11:58:16 -0700
Subject: [SPI] Fix section mismatch in spi-pl022.c
In-Reply-To: <20120213095228.GC15338@n2100.arm.linux.org.uk>
References: <20120213095228.GC15338@n2100.arm.linux.org.uk>
Message-ID: <20120213185816.GE11077@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2012 at 09:52:29AM +0000, Russell King - ARM Linux wrote:
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> WARNING: drivers/spi/built-in.o(.devinit.text+0xdb8): Section mismatch in reference from the function pl022_probe() to the function .init.text:pl022_dma_probe()
> The function __devinit pl022_probe() references
> a function __init pl022_dma_probe().
> If pl022_dma_probe is only used by pl022_probe then
> annotate pl022_dma_probe with a matching annotation.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Applied, thanks.

g.

> ---
>  drivers/spi/spi-pl022.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index 2f9cb43..f37ad22 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -1083,7 +1083,7 @@ static int configure_dma(struct pl022 *pl022)
>  	return -ENOMEM;
>  }
>  
> -static int __init pl022_dma_probe(struct pl022 *pl022)
> +static int __devinit pl022_dma_probe(struct pl022 *pl022)
>  {
>  	dma_cap_mask_t mask;
>  
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
