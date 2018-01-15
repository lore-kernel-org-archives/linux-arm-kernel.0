From: Jonathan.Cameron@huawei.com (Jonathan Cameron)
Date: Mon, 15 Jan 2018 11:32:55 +0000
Subject: [PATCH] IIO: ADC: stm32-dfsdm: fix static check warning
In-Reply-To: <1516006826-16230-1-git-send-email-arnaud.pouliquen@st.com>
References: <1516006826-16230-1-git-send-email-arnaud.pouliquen@st.com>
Message-ID: <20180115113255.000003ae@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 15 Jan 2018 10:00:26 +0100
Arnaud Pouliquen <arnaud.pouliquen@st.com> wrote:

> iio_priv does not return an error pointer, so check is not valid.
> Patch suppresses it.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

If it doesn't make it into Mark's tree pre merge window I'll pick it
up after rc1.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/stm32-dfsdm-adc.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index f79a90f..5c67236 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -1099,10 +1099,6 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
>  	}
>  
>  	adc = iio_priv(iio);
> -	if (IS_ERR(adc)) {
> -		dev_err(dev, "%s: Failed to allocate ADC\n", __func__);
> -		return PTR_ERR(adc);
> -	}
>  	adc->dfsdm = dev_get_drvdata(dev->parent);
>  
>  	iio->dev.parent = dev;
