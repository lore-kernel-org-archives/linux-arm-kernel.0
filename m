From: thomas.langer@intel.com (Langer, Thomas)
Date: Thu, 4 May 2017 19:07:24 +0000
Subject: [PATCH v3 1/3] iio: adc: meson-saradc: mark all
 meson_sar_adc_data static and const
In-Reply-To: <20170504180136.27025-2-martin.blumenstingl@googlemail.com>
References: <20170504180136.27025-1-martin.blumenstingl@googlemail.com>
 <20170504180136.27025-2-martin.blumenstingl@googlemail.com>
Message-ID: <0DAF21CFE1B20740AE23D6AF6E54843F1E8BCDB2@IRSMSX101.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Martin,

> 
> These are only passed as of_device_id.data and never modified. Thus we
> can mark them as static const, just like the of_device_id instances
> where they are used.

Here you talk about static const, but in the code below the const is missing.

> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/iio/adc/meson_saradc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c
> b/drivers/iio/adc/meson_saradc.c
> index dd4190b50df6..1cb5df306001 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -834,17 +834,17 @@ static const struct iio_info meson_sar_adc_iio_info
> = {
>  	.driver_module = THIS_MODULE,
>  };
> 
> -struct meson_sar_adc_data meson_sar_adc_gxbb_data = {
> +static struct meson_sar_adc_data meson_sar_adc_gxbb_data = {
>  	.resolution = 10,
>  	.name = "meson-gxbb-saradc",
>  };
> 
> -struct meson_sar_adc_data meson_sar_adc_gxl_data = {
> +static struct meson_sar_adc_data meson_sar_adc_gxl_data = {
>  	.resolution = 12,
>  	.name = "meson-gxl-saradc",
>  };
> 
> -struct meson_sar_adc_data meson_sar_adc_gxm_data = {
> +static struct meson_sar_adc_data meson_sar_adc_gxm_data = {
>  	.resolution = 12,
>  	.name = "meson-gxm-saradc",
>  };
> --
> 2.12.2
> 
