From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 19 Oct 2011 09:08:34 +0200
Subject: [PATCH] ARM: mach-mxs: fix machines' initializers order
In-Reply-To: <1318931549-16862-1-git-send-email-lauri.hintsala@bluegiga.com>
References: <1318931549-16862-1-git-send-email-lauri.hintsala@bluegiga.com>
Message-ID: <20111019070834.GN21504@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

would you consider this patch to be churn or a valid cleanup?

Best regards
Uwe

On Tue, Oct 18, 2011 at 12:52:29PM +0300, Lauri Hintsala wrote:
> Signed-off-by: Lauri Hintsala <lauri.hintsala@bluegiga.com>
> ---
> 
> reference: http://article.gmane.org/gmane.linux.ports.arm.omap/50721
> 
>  arch/arm/mach-mxs/mach-mx23evk.c |    2 +-
>  arch/arm/mach-mxs/mach-mx28evk.c |    2 +-
>  arch/arm/mach-mxs/mach-tx28.c    |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/mach-mx23evk.c b/arch/arm/mach-mxs/mach-mx23evk.c
> index 3c2de33..8fa2290 100644
> --- a/arch/arm/mach-mxs/mach-mx23evk.c
> +++ b/arch/arm/mach-mxs/mach-mx23evk.c
> @@ -182,6 +182,6 @@ MACHINE_START(MX23EVK, "Freescale MX23 EVK")
>  	/* Maintainer: Freescale Semiconductor, Inc. */
>  	.map_io		= mx23_map_io,
>  	.init_irq	= mx23_init_irq,
> -	.init_machine	= mx23evk_init,
>  	.timer		= &mx23evk_timer,
> +	.init_machine	= mx23evk_init,
>  MACHINE_END
> diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
> index eaaf6ff..d0f1ea7 100644
> --- a/arch/arm/mach-mxs/mach-mx28evk.c
> +++ b/arch/arm/mach-mxs/mach-mx28evk.c
> @@ -421,6 +421,6 @@ MACHINE_START(MX28EVK, "Freescale MX28 EVK")
>  	/* Maintainer: Freescale Semiconductor, Inc. */
>  	.map_io		= mx28_map_io,
>  	.init_irq	= mx28_init_irq,
> -	.init_machine	= mx28evk_init,
>  	.timer		= &mx28evk_timer,
> +	.init_machine	= mx28evk_init,
>  MACHINE_END
> diff --git a/arch/arm/mach-mxs/mach-tx28.c b/arch/arm/mach-mxs/mach-tx28.c
> index 515a423..9555938 100644
> --- a/arch/arm/mach-mxs/mach-tx28.c
> +++ b/arch/arm/mach-mxs/mach-tx28.c
> @@ -175,6 +175,6 @@ static struct sys_timer tx28_timer = {
>  MACHINE_START(TX28, "Ka-Ro electronics TX28 module")
>  	.map_io = mx28_map_io,
>  	.init_irq = mx28_init_irq,
> -	.init_machine = tx28_stk5v3_init,
>  	.timer = &tx28_timer,
> +	.init_machine = tx28_stk5v3_init,
>  MACHINE_END
> -- 
> 1.7.4.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
