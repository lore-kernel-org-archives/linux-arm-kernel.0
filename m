From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 18 Feb 2010 08:42:42 +0100
Subject: [PATCH] mx51_babbage: Fix ckih2 parameter in mx51_clocks_init
	function
In-Reply-To: <88241.12409.qm@web51008.mail.re2.yahoo.com>
References: <88241.12409.qm@web51008.mail.re2.yahoo.com>
Message-ID: <20100218074241.GF17643@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Amit,

As you made the initial port to the babbage board and were not on Cc,
can I have an acked-by for this?

Sascha

On Wed, Feb 17, 2010 at 12:02:56PM -0800, Fabio Estevam wrote:
> This patch is to be applied into Sascha's mxc-master branch.
> 
> Fix ckih2 parameter in mx51_clocks_init funtion. CKIH2 pin is left unconnected on Babbage.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-mx5/board-mx51_babbage.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
> index d5ccb5f..ee67a71 100644
> --- a/arch/arm/mach-mx5/board-mx51_babbage.c
> +++ b/arch/arm/mach-mx5/board-mx51_babbage.c
> @@ -79,7 +79,7 @@ static void __init mxc_board_init(void)
>  
>  static void __init mx51_babbage_timer_init(void)
>  {
> -	mx51_clocks_init(32768, 24000000, 22579200, 24576000);
> +	mx51_clocks_init(32768, 24000000, 22579200, 0);
>  }
>  
>  static struct sys_timer mxc_timer = {
> -- 
> 1.6.0.4
> 
> 
>       
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
