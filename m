From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Sat, 14 Aug 2010 19:31:47 +0200
Subject: [PATCH] ARM: imx: remove #ifdefery for unmerged flexcan driver
In-Reply-To: <1281787242-22530-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1281787242-22530-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <4C66D303.1020502@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig wrote:
> The flexcan driver was merged as e955cead.
> 
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Cheers, Marc
> ---
>  arch/arm/plat-mxc/devices/Makefile              |    5 +----
>  arch/arm/plat-mxc/include/mach/devices-common.h |   12 ------------
>  2 files changed, 1 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
> index 347da51..2062ab4 100644
> --- a/arch/arm/plat-mxc/devices/Makefile
> +++ b/arch/arm/plat-mxc/devices/Makefile
> @@ -1,7 +1,4 @@
> -ifdef CONFIG_CAN_FLEXCAN
> -# the ifdef can be removed once the flexcan driver has been merged
> -obj-$(CONFIG_IMX_HAVE_PLATFORM_FLEXCAN) +=  platform-flexcan.o
> -endif
> +obj-$(CONFIG_IMX_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o
>  obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_I2C) += platform-imx-i2c.o
>  obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_UART) += platform-imx-uart.o
>  obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_NAND) += platform-mxc_nand.o
> diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
> index 1190016..12bdc7d 100644
> --- a/arch/arm/plat-mxc/include/mach/devices-common.h
> +++ b/arch/arm/plat-mxc/include/mach/devices-common.h
> @@ -14,23 +14,11 @@ struct platform_device *imx_add_platform_device(const char *name, int id,
>  		const struct resource *res, unsigned int num_resources,
>  		const void *data, size_t size_data);
>  
> -#if defined (CONFIG_CAN_FLEXCAN) || defined (CONFIG_CAN_FLEXCAN_MODULE)
>  #include <linux/can/platform/flexcan.h>
>  struct platform_device *__init imx_add_flexcan(int id,
>  		resource_size_t iobase, resource_size_t iosize,
>  		resource_size_t irq,
>  		const struct flexcan_platform_data *pdata);
> -#else
> -/* the ifdef can be removed once the flexcan driver has been merged */
> -struct flexcan_platform_data;
> -static inline struct platform_device *__init imx_add_flexcan(int id,
> -		resource_size_t iobase, resource_size_t iosize,
> -		resource_size_t irq,
> -		const struct flexcan_platform_data *pdata)
> -{
> -	return NULL;
> -}
> -#endif
>  
>  #include <mach/i2c.h>
>  struct platform_device *__init imx_add_imx_i2c(int id,


-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 260 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100814/5262b4da/attachment.sig>
