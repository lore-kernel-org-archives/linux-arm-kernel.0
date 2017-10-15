From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 15 Oct 2017 11:28:47 +0100
Subject: [PATCH v2 5/5] iio: adc: at91-sama5d2_adc: use max sample rate
In-Reply-To: <1507703732-29175-6-git-send-email-eugen.hristev@microchip.com>
References: <1507703732-29175-1-git-send-email-eugen.hristev@microchip.com>
 <1507703732-29175-6-git-send-email-eugen.hristev@microchip.com>
Message-ID: <20171015112847.5c035e7a@archlinux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Oct 2017 09:35:32 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> Change driver settings to use maximum sample rate clock.
> This is useful to achieve best possible sampling rate
> if we use DMA.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

I would normally expect this to have some bearing on the 
noise levels on the measured signals.  All I can find
is a reference to the track time being 15*a single
clock cycle.  We could change this so that it is appropriate
for the currently samping frequency rather than leaving it
as a fixed value.

Jonathan

> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 7e51ecb..b76f88f 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -934,7 +934,7 @@ static void at91_adc_hw_init(struct at91_adc_state *st)
>  	at91_adc_writel(st, AT91_SAMA5D2_MR,
>  			AT91_SAMA5D2_MR_TRANSFER(2) | AT91_SAMA5D2_MR_ANACH);
>  
> -	at91_adc_setup_samp_freq(st, st->soc_info.min_sample_rate);
> +	at91_adc_setup_samp_freq(st, st->soc_info.max_sample_rate);
>  }
>  
>  static ssize_t at91_adc_get_fifo_state(struct device *dev,
