From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 7 May 2017 12:35:07 +0100
Subject: [PATCH v4 1/3] iio: adc: meson-saradc: mark all
 meson_sar_adc_data static and const
In-Reply-To: <20170506134929.31190-2-martin.blumenstingl@googlemail.com>
References: <20170506134929.31190-1-martin.blumenstingl@googlemail.com>
 <20170506134929.31190-2-martin.blumenstingl@googlemail.com>
Message-ID: <a1cd9503-9231-40e1-2189-a7692531f604@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/17 14:49, Martin Blumenstingl wrote:
> These are only passed as of_device_id.data and never modified. Thus we
> can mark them as static const, just like the of_device_id instances
> where they are used.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Good catch indeed on those consts!

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/meson_saradc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index dd4190b50df6..2f6fec995264 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -834,17 +834,17 @@ static const struct iio_info meson_sar_adc_iio_info = {
>  	.driver_module = THIS_MODULE,
>  };
>  
> -struct meson_sar_adc_data meson_sar_adc_gxbb_data = {
> +static const struct meson_sar_adc_data meson_sar_adc_gxbb_data = {
>  	.resolution = 10,
>  	.name = "meson-gxbb-saradc",
>  };
>  
> -struct meson_sar_adc_data meson_sar_adc_gxl_data = {
> +static const struct meson_sar_adc_data meson_sar_adc_gxl_data = {
>  	.resolution = 12,
>  	.name = "meson-gxl-saradc",
>  };
>  
> -struct meson_sar_adc_data meson_sar_adc_gxm_data = {
> +static const struct meson_sar_adc_data meson_sar_adc_gxm_data = {
>  	.resolution = 12,
>  	.name = "meson-gxm-saradc",
>  };
> 
