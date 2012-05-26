From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sat, 26 May 2012 13:28:24 +0200
Subject: [PATCH 01/15] ARM: mx5: Use
 clk_prepare_enable/clk_disable_unprepare
In-Reply-To: <1337987696-31728-1-git-send-email-festevam@gmail.com>
References: <1337987696-31728-1-git-send-email-festevam@gmail.com>
Message-ID: <20120526112824.GV30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2012 at 08:14:42PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Prepare the clock before enabling it.
> 
> Cc: <linux-arm-kernel@lists.infradead.org>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-imx/mm-imx5.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mm-imx5.c b/arch/arm/mach-imx/mm-imx5.c
> index feeee17..fcad95c 100644
> --- a/arch/arm/mach-imx/mm-imx5.c
> +++ b/arch/arm/mach-imx/mm-imx5.c
> @@ -35,11 +35,11 @@ static void imx5_idle(void)
>  			return;
>  		clk_prepare(gpc_dvfs_clk);
>  	}
> -	clk_enable(gpc_dvfs_clk);
> +	clk_prepare_enable(gpc_dvfs_clk);
>  	mx5_cpu_lp_set(WAIT_UNCLOCKED_POWER_OFF);
>  	if (!tzic_enable_wake())
>  		cpu_do_idle();
> -	clk_disable(gpc_dvfs_clk);
> +	clk_disable_unprepare(gpc_dvfs_clk);
>  }

No, the clock already is prepared.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
