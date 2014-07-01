From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 1 Jul 2014 16:07:47 +0800
Subject: [PATCH] ARM: imx53: mark imx53_dt_board_compat as const
In-Reply-To: <1404121068-12275-1-git-send-email-l.stach@pengutronix.de>
References: <1404121068-12275-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <20140701080745.GG14471@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 11:37:48AM +0200, Lucas Stach wrote:
> Otherwise GCC will mark the .init.rodata section
> R/W, which causes a compile error once we add other
> real R/O data, which happens with patch
> "ARM: imx53: globally disable supervisor protect".
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

The same change needs to be applied on some other IMX platforms, so I
just send a new patch based on this.

Shawn

> ---
>  arch/arm/mach-imx/mach-imx53.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
> index d757d8cbebd1..c3a404ce39e6 100644
> --- a/arch/arm/mach-imx/mach-imx53.c
> +++ b/arch/arm/mach-imx/mach-imx53.c
> @@ -45,7 +45,7 @@ static void __init imx53_dt_init(void)
>  	}
>  }
>  
> -static const char *imx53_dt_board_compat[] __initconst = {
> +static const char * const imx53_dt_board_compat[] __initconst = {
>  	"fsl,imx53",
>  	NULL
>  };
> -- 
> 2.0.0
> 
