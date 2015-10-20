From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 20 Oct 2015 12:22:25 +0200
Subject: [PATCH] spi: atmel: Fix DMA-setup for transfers with more than 8
 bits per word.
In-Reply-To: <1445288084-31805-1-git-send-email-davidm@egauge.net>
References: <1445288084-31805-1-git-send-email-davidm@egauge.net>
Message-ID: <562615E1.4030407@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 19/10/2015 22:54, David Mosberger-Tang a ?crit :
> The DMA-slave configuration depends on the whether <= 8 or > 8 bits
> are transferred per word, so we need to call
> atmel_spi_dma_slave_config() with the correct value.
> 
> Signed-off-by: David Mosberger <davidm@egauge.net>

Thanks for having rewritten this patch! It's much more simple like this ;-)

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

For Mark, here is the patchwork entry which can be handy:
https://patchwork.kernel.org/patch/7439931/

Best regards,

> ---
>  drivers/spi/spi-atmel.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 04e48e5..855cc56 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -758,7 +758,8 @@ static int atmel_spi_next_xfer_dma_submit(struct spi_master *master,
>  
>  	*plen = len;
>  
> -	if (atmel_spi_dma_slave_config(as, &slave_config, 8))
> +	if (atmel_spi_dma_slave_config(as, &slave_config,
> +				       xfer->bits_per_word))
>  		goto err_exit;
>  
>  	/* Send both scatterlists */
> 


-- 
Nicolas Ferre
