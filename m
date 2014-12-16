From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 16 Dec 2014 16:23:01 +0800
Subject: [PATCH 1/2] arm: imx: remove unnecessary setting for DSM
In-Reply-To: <1418102919-29950-1-git-send-email-b20788@freescale.com>
References: <1418102919-29950-1-git-send-email-b20788@freescale.com>
Message-ID: <20141216082259.GG2411@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 09, 2014 at 01:28:38PM +0800, Anson Huang wrote:
> Now we support DSM in OCRAM for all i.MX6 SoCs,
> the resume entry point is set in asm code of
> suspend-imx6.S, so no need to set the resume
> entry point for SRC in pre-suspend flow.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>

Again, change "arm: " to "ARM: " please, as I want to keep it consistent
for all IMX patches I collect.

Shawn

> ---
>  arch/arm/mach-imx/pm-imx6.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
> index c653dd4..671e2a9 100644
> --- a/arch/arm/mach-imx/pm-imx6.c
> +++ b/arch/arm/mach-imx/pm-imx6.c
> @@ -363,7 +363,6 @@ static int imx6q_pm_enter(suspend_state_t state)
>  			imx6q_enable_rbc(true);
>  		imx_gpc_pre_suspend(true);
>  		imx_anatop_pre_suspend();
> -		imx_set_cpu_jump(0, v7_cpu_resume);
>  		/* Zzz ... */
>  		cpu_suspend(0, imx6q_suspend_finish);
>  		if (cpu_is_imx6q() || cpu_is_imx6dl())
> -- 
> 1.7.9.5
> 
