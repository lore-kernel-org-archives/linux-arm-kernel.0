From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 14 Apr 2014 10:59:35 +0200
Subject: [PATCH 1/4] ARM: at91: prepare common clk transition for sam9x5
 SoCs
In-Reply-To: <1397464994-27267-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1397464994-27267-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397464994-27267-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140414085935.GO2967@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/04/2014 at 10:43:11 +0200, Boris Brezillon wrote :
> This patch encloses sam9x5 old clk registration in
> "#if defined(CONFIG_OLD_CLK_AT91) #endif" sections.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/arm/mach-at91/at91sam9x5.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-at91/at91sam9x5.c
> index 9ad781d..e994edd 100644
> --- a/arch/arm/mach-at91/at91sam9x5.c
> +++ b/arch/arm/mach-at91/at91sam9x5.c
> @@ -19,9 +19,10 @@
>  #include "board.h"
>  #include "soc.h"
>  #include "generic.h"
> -#include "clock.h"
>  #include "sam9_smc.h"
>  
> +#if defined(CONFIG_OLD_CLK_AT91)
> +#include "clock.h"
>  /* --------------------------------------------------------------------
>   *  Clocks
>   * -------------------------------------------------------------------- */
> @@ -313,6 +314,7 @@ static void __init at91sam9x5_register_clocks(void)
>  	clk_register(&pck0);
>  	clk_register(&pck1);
>  }
> +#endif
>  
>  /* --------------------------------------------------------------------
>   *  AT91SAM9x5 processor initialization
> @@ -334,6 +336,8 @@ static void __init at91sam9x5_initialize(void)
>  
>  AT91_SOC_START(at91sam9x5)
>  	.map_io = at91sam9x5_map_io,
> +#if defined(CONFIG_OLD_CLK_AT91)
>  	.register_clocks = at91sam9x5_register_clocks,
> +#endif
>  	.init = at91sam9x5_initialize,
>  AT91_SOC_END
> -- 
> 1.8.3.2
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
