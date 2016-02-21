From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 21 Feb 2016 14:07:15 +0100
Subject: [PATCH] mfd: fsl-imx25-tsadc: select IRQ_DOMAIN
In-Reply-To: <1455634467-2013548-1-git-send-email-arnd@arndb.de>
References: <1455634467-2013548-1-git-send-email-arnd@arndb.de>
Message-ID: <1544245.mjq7iKKDQ3@galactica>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 February 2016 15:54:24 Arnd Bergmann wrote:
> The newly added tsadc code use irq domains, but it can be enabled
> when they are disabled in Kconfig:
> 
> drivers/mfd/fsl-imx25-tsadc.c:41:22: error: implicit declaration of function 'irq_find_mapping' [-Werror=implicit-function-declaration]
>    generic_handle_irq(irq_find_mapping(tsadc->domain, 1));
> drivers/mfd/fsl-imx25-tsadc.c: In function 'mx25_tsadc_setup_irq':
> drivers/mfd/fsl-imx25-tsadc.c:80:18: error: implicit declaration of function 'irq_domain_add_simple' [-Werror=implicit-function-declaration]
> 
> This adds a 'select IRQ_DOMAIN' code, like we have it in all other
> drivers with this requirement.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: e2fccf5c1515 ("mfd: fsl-imx25-tsadc: Register touchscreen ADC driver")

Thanks,

Reviewed-by: Markus Pargmann <mpa@pengutronix.de>

Best Regards,

Markus

> ---
>  drivers/mfd/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index aa21dc55eb15..8cab3ecca8fc 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -300,6 +300,7 @@ config MFD_MC13XXX_I2C
>  config MFD_MX25_TSADC
>  	tristate "Freescale i.MX25 integrated Touchscreen and ADC unit"
>  	select REGMAP_MMIO
> +	select IRQ_DOMAIN
>  	depends on (SOC_IMX25 && OF) || COMPILE_TEST
>  	help
>  	  Enable support for the integrated Touchscreen and ADC unit of the
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160221/ef514e0f/attachment-0001.sig>
