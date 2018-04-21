From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 21 Apr 2018 15:58:03 +0100
Subject: [PATCH] iio: adc: select buffer for at91-sama5d2_adc
In-Reply-To: <1523861643-3419-1-git-send-email-eugen.hristev@microchip.com>
References: <1523861643-3419-1-git-send-email-eugen.hristev@microchip.com>
Message-ID: <20180421155803.3df3f615@archlinux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 Apr 2018 09:54:03 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> We need to select the buffer code, otherwise we get build errors
> with undefined functions on the trigger and buffer,
> if we select just IIO and then AT91_SAMA5D2_ADC from menuconfig
> 
> This adds a Kconfig 'select' statement like other ADC
> drivers have it already.
> 
> Fixes: 5e1a1da0f8c9 ("iio: adc: at91-sama5d2_adc: add hw trigger and buffer support")
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
> Hello Jonathan,
> 
> While you are at it, I also found this small kconfig issue during my tests.
> Would be good to have as a fix as well.
> 
> Thanks,
> Eugen
> 
>  drivers/iio/adc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 15606f2..9da7907 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -158,6 +158,7 @@ config AT91_SAMA5D2_ADC
>  	depends on ARCH_AT91 || COMPILE_TEST
>  	depends on HAS_IOMEM
>  	depends on HAS_DMA
> +	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to build support for Atmel SAMA5D2 ADC which is
