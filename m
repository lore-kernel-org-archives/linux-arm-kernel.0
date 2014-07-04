From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 4 Jul 2014 21:07:42 +0800
Subject: [PATCH] ARM: pxa: fix typo 'CONFIG_SPI_PXA2XX_MASTER'
In-Reply-To: <1400236840.20342.30.camel@x220>
References: <1400236840.20342.30.camel@x220>
Message-ID: <CAN1soZwfVHvwtn80=J4S2FsiypHGadrGbznTH_5ju5pTR3tv4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 6:40 PM, Paul Bolle <pebolle@tiscali.nl> wrote:
> CONFIG_SPI_PXA2XX_MASTER was used were it was surely meant to use
> CONFIG_SPI_PXA2XX_MODULE. Use the IS_ENABLED() macro here, as it guards
> against typos like this one.
>
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Untested, and (hardware) testing for the modular case might be needed.
> This typo was introduced in v2.6.28.
>
>  arch/arm/mach-pxa/corgi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
> index 57d60542f982..ccff8d82cc27 100644
> --- a/arch/arm/mach-pxa/corgi.c
> +++ b/arch/arm/mach-pxa/corgi.c
> @@ -513,7 +513,7 @@ static struct pxa2xx_udc_mach_info udc_info __initdata = {
>         .gpio_pullup            = CORGI_GPIO_USB_PULLUP,
>  };
>
> -#if defined(CONFIG_SPI_PXA2XX) || defined(CONFIG_SPI_PXA2XX_MASTER)
> +#if IS_ENABLED(CONFIG_SPI_PXA2XX)
>  static struct pxa2xx_spi_master corgi_spi_info = {
>         .num_chipselect = 3,
>  };
> --
> 1.9.0
>

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
