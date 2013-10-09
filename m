From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 9 Oct 2013 15:05:32 +0200
Subject: [PATCH 2/6] ARM: at91: prepare common clk transition for sama5d3
 SoC
In-Reply-To: <1375953690-11207-1-git-send-email-b.brezillon@overkiz.com>
References: <1375951572-10829-1-git-send-email-b.brezillon@overkiz.com>
 <1375953690-11207-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <5255549C.4050009@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2013 11:21, Boris BREZILLON :
> This patch enclose sama5d3 old clk registration in
> "#if defined(CONFIG_OLD_CLK_AT91) #endif" sections.
>
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

And... do not forget to remove completely the code when transition is 
done (ie: in "[PATCH 6/6] ARM: at91/dt: remove old main clk definition 
from sama5d3xcm.dtsi").


> ---
>   arch/arm/mach-at91/sama5d3.c |    6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-at91/sama5d3.c b/arch/arm/mach-at91/sama5d3.c
> index 0003949..3426098 100644
> --- a/arch/arm/mach-at91/sama5d3.c
> +++ b/arch/arm/mach-at91/sama5d3.c
> @@ -19,9 +19,10 @@
>
>   #include "soc.h"
>   #include "generic.h"
> -#include "clock.h"
>   #include "sam9_smc.h"
>
> +#if defined(CONFIG_OLD_CLK_AT91)
> +#include "clock.h"
>   /* --------------------------------------------------------------------
>    *  Clocks
>    * -------------------------------------------------------------------- */
> @@ -361,6 +362,7 @@ static void __init sama5d3_register_clocks(void)
>   	clk_register(&pck1);
>   	clk_register(&pck2);
>   }
> +#endif
>
>   /* --------------------------------------------------------------------
>    *  AT91SAM9x5 processor initialization
> @@ -373,5 +375,7 @@ static void __init sama5d3_map_io(void)
>
>   AT91_SOC_START(sama5d3)
>   	.map_io = sama5d3_map_io,
> +#if defined(CONFIG_OLD_CLK_AT91)
>   	.register_clocks = sama5d3_register_clocks,
> +#endif
>   AT91_SOC_END
>


-- 
Nicolas Ferre
