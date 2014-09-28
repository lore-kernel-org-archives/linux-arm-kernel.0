From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 28 Sep 2014 12:15:15 +0800
Subject: [PATCH v2 6/6] ARM: imx53: add cpufreq support
In-Reply-To: <1411738864-26549-6-git-send-email-l.stach@pengutronix.de>
References: <1411738864-26549-1-git-send-email-l.stach@pengutronix.de>
 <1411738864-26549-6-git-send-email-l.stach@pengutronix.de>
Message-ID: <20140928041513.GI12999@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 26, 2014 at 03:41:04PM +0200, Lucas Stach wrote:
> Instanciate device for the generic cpufreq-dt driver.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

I assume that I should only apply this patch after the cpufreq-dt change
gets merged and shows up on my base.

Shawn

> ---
> v2:
> - new patch, split out from DTS changes and rebased
>   with new name for cpufreq driver
> ---
>  arch/arm/mach-imx/mach-imx53.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
> index 03dd6ea13acc..7587cf0cba3e 100644
> --- a/arch/arm/mach-imx/mach-imx53.c
> +++ b/arch/arm/mach-imx/mach-imx53.c
> @@ -41,6 +41,8 @@ static void __init imx53_dt_init(void)
>  static void __init imx53_init_late(void)
>  {
>  	imx53_pm_init();
> +
> +	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
>  }
>  
>  static const char * const imx53_dt_board_compat[] __initconst = {
> -- 
> 2.1.0
> 
