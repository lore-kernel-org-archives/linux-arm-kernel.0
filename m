From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 24 Sep 2017 14:09:19 +0100
Subject: [PATCH] iio: adc: stm32: fix bad error check on max_channels
In-Reply-To: <1505751855-15490-1-git-send-email-fabrice.gasnier@st.com>
References: <1505751855-15490-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20170924140919.669c9cca@archlinux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 Sep 2017 18:24:15 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Fix a bad error check when counting 'st,adc-channels' array elements.
> This is seen when all channels are in use simultaneously.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Applied to fixes-togreg-post-rc1, fixes tag added and marked for
stable.

Jonathan

> ---
>  drivers/iio/adc/stm32-adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index e3c15f8..4df32cf 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -1666,7 +1666,7 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev)
>  
>  	num_channels = of_property_count_u32_elems(node, "st,adc-channels");
>  	if (num_channels < 0 ||
> -	    num_channels >= adc_info->max_channels) {
> +	    num_channels > adc_info->max_channels) {
>  		dev_err(&indio_dev->dev, "Bad st,adc-channels?\n");
>  		return num_channels < 0 ? num_channels : -EINVAL;
>  	}
