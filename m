From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 20 Dec 2013 09:53:21 +0800
Subject: [PATCH v2 2/3] ARM: imx: Add cpu frequency scaling support
In-Reply-To: <1387485338-21225-2-git-send-email-john.tobias.ph@gmail.com>
References: <1387485338-21225-1-git-send-email-john.tobias.ph@gmail.com>
 <1387485338-21225-2-git-send-email-john.tobias.ph@gmail.com>
Message-ID: <20131220015319.GG7172@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 12:35:37PM -0800, John Tobias wrote:
> Re-using iMX6Q driver for cpu frequency scaling.
> 
> Signed-off-by: John Tobias <john.tobias.ph@gmail.com>
> ---
>  arch/arm/mach-imx/mach-imx6sl.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
> index 2f952e3..2ba3a7a 100644
> --- a/arch/arm/mach-imx/mach-imx6sl.c
> +++ b/arch/arm/mach-imx/mach-imx6sl.c
> @@ -34,6 +34,12 @@ static void __init imx6sl_fec_init(void)
>  	}
>  }
>  
> +static void __init imx6sl_init_late(void)
> +{

I added a comment below and changed patch subject prefix to be 'ARM:
imx6sl: ', and then applied the patch.

	/* imx6sl reuses imx6q cpufreq driver */

Shawn

> +	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ))
> +		platform_device_register_simple("imx6q-cpufreq", -1, NULL, 0);
> +}
> +
>  static void __init imx6sl_init_machine(void)
>  {
>  	struct device *parent;
> @@ -70,6 +76,7 @@ DT_MACHINE_START(IMX6SL, "Freescale i.MX6 SoloLite (Device Tree)")
>  	.map_io		= debug_ll_io_init,
>  	.init_irq	= imx6sl_init_irq,
>  	.init_machine	= imx6sl_init_machine,
> +	.init_late      = imx6sl_init_late,
>  	.dt_compat	= imx6sl_dt_compat,
>  	.restart	= mxc_restart,
>  MACHINE_END
> -- 
> 1.8.3.2
> 
