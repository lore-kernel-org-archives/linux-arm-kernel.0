From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 14 Apr 2014 10:57:13 +0200
Subject: [PATCH 1/4] ARM: at91: prepare common clk transition for sam9n12
 SoC
In-Reply-To: <1397463399-11771-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1397463399-11771-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397463399-11771-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140414085713.GL2967@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/04/2014 at 10:16:36 +0200, Boris Brezillon wrote :
> This patch encloses sam9n12 old clk registration in
> "#if defined(CONFIG_OLD_CLK_AT91) #endif" sections.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/arm/mach-at91/at91sam9n12.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-at91/at91sam9n12.c b/arch/arm/mach-at91/at91sam9n12.c
> index f2ea7b0..c8988fe 100644
> --- a/arch/arm/mach-at91/at91sam9n12.c
> +++ b/arch/arm/mach-at91/at91sam9n12.c
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
> @@ -215,6 +216,9 @@ static void __init at91sam9n12_register_clocks(void)
>  			 ARRAY_SIZE(periph_clocks_lookups));
>  
>  }
> +#else
> +#define at91sam9n12_register_clocks NULL
> +#endif
>  
>  /* --------------------------------------------------------------------
>   *  AT91SAM9N12 processor initialization
> -- 
> 1.8.3.2
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
