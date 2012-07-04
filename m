From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 4 Jul 2012 08:55:01 +0200
Subject: [PATCH] ARM: imx: enable support for mx35 rtc
In-Reply-To: <1161104963.340229.1340983241008.JavaMail.root@advansee.com>
References: <1061486785.340218.1340983236720.JavaMail.root@advansee.com>
 <1161104963.340229.1340983241008.JavaMail.root@advansee.com>
Message-ID: <20120704065501.GF2698@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Beno?t,

On Fri, Jun 29, 2012 at 05:20:41PM +0200, Beno?t Th?baudeau wrote:
> The i.MX35 has an RTC compatible with the i.MX31's, so enable its support even
> if it's not very useful because it's not battery backed.

Given that you do not add board for this rtc and we all want to convert
to devicetree I would rather drop this patch.

Sascha

> 
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Signed-off-by: Beno?t Th?baudeau <benoit.thebaudeau@advansee.com>
> ---
>  .../arch/arm/mach-imx/devices-imx35.h              |    4 ++++
>  .../arch/arm/plat-mxc/devices/platform-mxc_rtc.c   |    5 +++++
>  2 files changed, 9 insertions(+)
> 
> diff --git linux-next-HEAD-d1d2d3a.orig/arch/arm/mach-imx/devices-imx35.h linux-next-HEAD-d1d2d3a/arch/arm/mach-imx/devices-imx35.h
> index 7b99ef0..82d6ea0 100644
> --- linux-next-HEAD-d1d2d3a.orig/arch/arm/mach-imx/devices-imx35.h
> +++ linux-next-HEAD-d1d2d3a/arch/arm/mach-imx/devices-imx35.h
> @@ -68,6 +68,10 @@ extern const struct imx_mxc_nand_data imx35_mxc_nand_data;
>  #define imx35_add_mxc_nand(pdata)	\
>  	imx_add_mxc_nand(&imx35_mxc_nand_data, pdata)
>  
> +extern const struct imx_mxc_rtc_data imx35_mxc_rtc_data;
> +#define imx35_add_mxc_rtc(pdata)	\
> +	imx_add_mxc_rtc(&imx35_mxc_rtc_data)
> +
>  extern const struct imx_mxc_w1_data imx35_mxc_w1_data;
>  #define imx35_add_mxc_w1(pdata)	\
>  	imx_add_mxc_w1(&imx35_mxc_w1_data)
> diff --git linux-next-HEAD-d1d2d3a.orig/arch/arm/plat-mxc/devices/platform-mxc_rtc.c linux-next-HEAD-d1d2d3a/arch/arm/plat-mxc/devices/platform-mxc_rtc.c
> index 16d0ec4..a5c9ad5 100644
> --- linux-next-HEAD-d1d2d3a.orig/arch/arm/plat-mxc/devices/platform-mxc_rtc.c
> +++ linux-next-HEAD-d1d2d3a/arch/arm/plat-mxc/devices/platform-mxc_rtc.c
> @@ -20,6 +20,11 @@ const struct imx_mxc_rtc_data imx31_mxc_rtc_data __initconst =
>  	imx_mxc_rtc_data_entry_single(MX31);
>  #endif /* ifdef CONFIG_SOC_IMX31 */
>  
> +#ifdef CONFIG_SOC_IMX35
> +const struct imx_mxc_rtc_data imx35_mxc_rtc_data __initconst =
> +	imx_mxc_rtc_data_entry_single(MX35);
> +#endif /* ifdef CONFIG_SOC_IMX35 */
> +
>  struct platform_device *__init imx_add_mxc_rtc(
>  		const struct imx_mxc_rtc_data *data)
>  {
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
