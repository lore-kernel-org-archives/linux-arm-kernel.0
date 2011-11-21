From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Nov 2011 09:46:35 +0000
Subject: [PATCH] ARM: mxs: fix machines' initializers order
In-Reply-To: <1321865755-7423-1-git-send-email-lauri.hintsala@bluegiga.com>
References: <1321865755-7423-1-git-send-email-lauri.hintsala@bluegiga.com>
Message-ID: <20111121094635.GN9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2011 at 10:55:55AM +0200, Lauri Hintsala wrote:
> Initializers of m28evk and stmp378x_devb fixed to be in order
> they are called.
> 
> ---
> reference: http://article.gmane.org/gmane.linux.ports.arm.omap/50721
> 
> cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Lauri Hintsala <lauri.hintsala@bluegiga.com>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

> ---
>  arch/arm/mach-mxs/mach-m28evk.c        |    2 +-
>  arch/arm/mach-mxs/mach-stmp378x_devb.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/mach-m28evk.c b/arch/arm/mach-mxs/mach-m28evk.c
> index 3b1681e..6b00577 100644
> --- a/arch/arm/mach-mxs/mach-m28evk.c
> +++ b/arch/arm/mach-mxs/mach-m28evk.c
> @@ -361,6 +361,6 @@ static struct sys_timer m28evk_timer = {
>  MACHINE_START(M28EVK, "DENX M28 EVK")
>  	.map_io		= mx28_map_io,
>  	.init_irq	= mx28_init_irq,
> -	.init_machine	= m28evk_init,
>  	.timer		= &m28evk_timer,
> +	.init_machine	= m28evk_init,
>  MACHINE_END
> diff --git a/arch/arm/mach-mxs/mach-stmp378x_devb.c b/arch/arm/mach-mxs/mach-stmp378x_devb.c
> index 177e531..6834dea 100644
> --- a/arch/arm/mach-mxs/mach-stmp378x_devb.c
> +++ b/arch/arm/mach-mxs/mach-stmp378x_devb.c
> @@ -115,6 +115,6 @@ static struct sys_timer stmp378x_dvb_timer = {
>  MACHINE_START(STMP378X, "STMP378X")
>  	.map_io		= mx23_map_io,
>  	.init_irq	= mx23_init_irq,
> -	.init_machine	= stmp378x_dvb_init,
>  	.timer		= &stmp378x_dvb_timer,
> +	.init_machine	= stmp378x_dvb_init,
>  MACHINE_END
> -- 
> 1.7.4.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
