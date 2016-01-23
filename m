From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 23 Jan 2016 16:16:53 +0000
Subject: [PATCH 1/2] iio:adc:at91-sama5d2: fix vref_uv type
In-Reply-To: <1453106516-17935-1-git-send-email-ludovic.desroches@atmel.com>
References: <1453106516-17935-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <56A3A775.3090907@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/01/16 08:41, Ludovic Desroches wrote:
> vref_uv has to be an int.
> 
Applied, with a reported-by tag for Julia added.

Thanks,

Jonathan
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index ecb2d90..f2d8bd5 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -171,7 +171,7 @@ struct at91_adc_state {
>  	struct clk			*per_clk;
>  	struct regulator		*reg;
>  	struct regulator		*vref;
> -	u32				vref_uv;
> +	int				vref_uv;
>  	const struct iio_chan_spec	*chan;
>  	bool				conversion_done;
>  	u32				conversion_value;
> 
