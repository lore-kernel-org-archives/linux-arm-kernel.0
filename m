From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 30 Mar 2012 14:11:36 +0800
Subject: [PATCH 03/17] ARM: mark const init data with __initconst instead
 of __initdata
In-Reply-To: <1333055554-31300-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20120329211131.GA31250@pengutronix.de>
 <1333055554-31300-3-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20120330061134.GD3254@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 29, 2012 at 11:12:20PM +0200, Uwe Kleine-K?nig wrote:
...
> diff --git a/arch/arm/mach-imx/imx51-dt.c b/arch/arm/mach-imx/imx51-dt.c
> index 5cca573..7e00748 100644
> --- a/arch/arm/mach-imx/imx51-dt.c
> +++ b/arch/arm/mach-imx/imx51-dt.c
> @@ -102,7 +102,7 @@ static struct sys_timer imx51_timer = {
>  	.init = imx51_timer_init,
>  };
>  
> -static const char *imx51_dt_board_compat[] __initdata = {
> +static const char *imx51_dt_board_compat[] __initconst = {
>  	"fsl,imx51-babbage",
>  	"fsl,imx51",
>  	NULL

  CC      arch/arm/mach-imx/imx51-dt.o
arch/arm/mach-imx/imx51-dt.c:105:20: error: imx51_dt_board_compat causes a section type conflict
make[2]: *** [arch/arm/mach-imx/imx51-dt.o] Error 1

I do not understand why though.

-- 
Regards,
Shawn
