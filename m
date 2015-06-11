From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Thu, 11 Jun 2015 14:16:08 +0200
Subject: [PATCH 1/1] i2c: at91: fix code checker warnings
In-Reply-To: <7419376c5a4e60f1b23d36e66a102c7c40db1089.1434013494.git.cyrille.pitchen@atmel.com>
References: <cover.1434013494.git.cyrille.pitchen@atmel.com>
 <7419376c5a4e60f1b23d36e66a102c7c40db1089.1434013494.git.cyrille.pitchen@atmel.com>
Message-ID: <20150611121608.GW25800@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 11, 2015 at 11:16:32AM +0200, Cyrille Pitchen wrote:
> buf_len is a size_t, so unsigned but was tested with '<= 0'.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>

Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Thanks

> ---
>  drivers/i2c/busses/i2c-at91.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index 0d2dc7d..967c0cb 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -232,7 +232,7 @@ static void at91_twi_dma_cleanup(struct at91_twi_dev *dev)
>  
>  static void at91_twi_write_next_byte(struct at91_twi_dev *dev)
>  {
> -	if (dev->buf_len <= 0)
> +	if (!dev->buf_len)
>  		return;
>  
>  	/* 8bit write works with and without FIFO */
> @@ -275,7 +275,7 @@ static void at91_twi_write_data_dma(struct at91_twi_dev *dev)
>  	struct dma_chan *chan_tx = dma->chan_tx;
>  	unsigned int sg_len = 1;
>  
> -	if (dev->buf_len <= 0)
> +	if (!dev->buf_len)
>  		return;
>  
>  	dma->direction = DMA_TO_DEVICE;
> @@ -347,7 +347,7 @@ error:
>  
>  static void at91_twi_read_next_byte(struct at91_twi_dev *dev)
>  {
> -	if (dev->buf_len <= 0)
> +	if (!dev->buf_len)
>  		return;
>  
>  	/* 8bit read works with and without FIFO */
> -- 
> 1.8.2.2
> 
