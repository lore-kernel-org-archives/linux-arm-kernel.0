From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 15 Feb 2011 15:09:32 -0700
Subject: [PATCH 3/4] spi/pl022: remove dangling status check
In-Reply-To: <1297166621-5169-1-git-send-email-linus.walleij@stericsson.com>
References: <1297166621-5169-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110215220932.GH28005@angua.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 08, 2011 at 01:03:41PM +0100, Linus Walleij wrote:
> From: Virupax Sadashivpetimath <virupax.sadashivpetimath@stericsson.com>
> 
> Signed-off-by: Virupax Sadashivpetimath <virupax.sadashivpetimath@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied, thanks.

g.

> ---
>  drivers/spi/amba-pl022.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
> index 8fdf530..2b591f0 100644
> --- a/drivers/spi/amba-pl022.c
> +++ b/drivers/spi/amba-pl022.c
> @@ -1906,8 +1906,6 @@ static int pl022_setup(struct spi_device *spi)
>  	    && ((pl022->master_info)->enable_dma)) {
>  		chip->enable_dma = true;
>  		dev_dbg(&spi->dev, "DMA mode set in controller state\n");
> -		if (status < 0)
> -			goto err_config_params;
>  		SSP_WRITE_BITS(chip->dmacr, SSP_DMA_ENABLED,
>  			       SSP_DMACR_MASK_RXDMAE, 0);
>  		SSP_WRITE_BITS(chip->dmacr, SSP_DMA_ENABLED,
> -- 
> 1.7.3.2
> 
