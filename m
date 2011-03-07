From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 7 Mar 2011 08:54:45 +0100
Subject: [PATCH 2/4] ARM: mxs/mx28evk: add framebuffer deviceg
In-Reply-To: <1299343222-30670-3-git-send-email-shawn.guo@freescale.com>
References: <1299343222-30670-1-git-send-email-shawn.guo@freescale.com>
	<1299343222-30670-3-git-send-email-shawn.guo@freescale.com>
Message-ID: <20110307075445.GI29521@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 06, 2011 at 12:40:20AM +0800, Shawn Guo wrote:
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  arch/arm/mach-mxs/Kconfig        |    1 +
>  arch/arm/mach-mxs/clock-mx28.c   |    2 +
>  arch/arm/mach-mxs/mach-mx28evk.c |   78 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 81 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
> index 4f0b673..cffd860 100644
> --- a/arch/arm/mach-mxs/Kconfig
> +++ b/arch/arm/mach-mxs/Kconfig
> @@ -33,6 +33,7 @@ config MACH_MX28EVK
>  	select MXS_HAVE_AMBA_DUART
>  	select MXS_HAVE_PLATFORM_AUART
>  	select MXS_HAVE_PLATFORM_FEC
> +	select MXS_HAVE_PLATFORM_MXSFB
>  	select MXS_OCOTP
>  	default y
>  	help
> diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
> index 8277056..56bd164 100644
> --- a/arch/arm/mach-mxs/clock-mx28.c
> +++ b/arch/arm/mach-mxs/clock-mx28.c
> @@ -750,6 +750,8 @@ int __init mx28_clocks_init(void)
>  	clk_enable(&emi_clk);
>  	clk_enable(&uart_clk);
>  
> +	clk_set_parent(&lcdif_clk, &ref_pix_clk);

While probably being the right thing to do this should not be in this
patch.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
