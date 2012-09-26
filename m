From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 26 Sep 2012 10:32:06 +0200
Subject: [PATCH 3/6] ARM: at91: add clocks for spi DT entries
In-Reply-To: <1348642261-27554-4-git-send-email-wenyou.yang@atmel.com>
References: <1348642261-27554-1-git-send-email-wenyou.yang@atmel.com>
 <1348642261-27554-4-git-send-email-wenyou.yang@atmel.com>
Message-ID: <5062BD86.3070401@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/2012 08:50 AM, Wenyou Yang :
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
>  arch/arm/mach-at91/at91sam9260.c |    2 ++
>  arch/arm/mach-at91/at91sam9g45.c |    2 ++
>  arch/arm/mach-at91/at91sam9n12.c |    2 ++
>  arch/arm/mach-at91/at91sam9x5.c  |    3 +++
>  4 files changed, 9 insertions(+)
> 
> diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
> index 30c7f26..90d38a8 100644
> --- a/arch/arm/mach-at91/at91sam9260.c
> +++ b/arch/arm/mach-at91/at91sam9260.c
> @@ -227,6 +227,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
>  	CLKDEV_CON_DEV_ID("t1_clk", "fffdc000.timer", &tc4_clk),
>  	CLKDEV_CON_DEV_ID("t2_clk", "fffdc000.timer", &tc5_clk),
>  	CLKDEV_CON_DEV_ID("hclk", "500000.ohci", &ohci_clk),
> +	CLKDEV_CON_DEV_ID("spi_clk", "fffa8000.spi", &spi0_clk),
> +	CLKDEV_CON_DEV_ID("spi_clk", "fffac000.spi", &spi1_clk),
>  	/* fake hclk clock */
>  	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &ohci_clk),
>  	CLKDEV_CON_ID("pioA", &pioA_clk),
> diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
> index ef6cedd..9d0ec1c 100644
> --- a/arch/arm/mach-at91/at91sam9g45.c
> +++ b/arch/arm/mach-at91/at91sam9g45.c
> @@ -254,6 +254,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
>  	CLKDEV_CON_DEV_ID("t0_clk", "fffd4000.timer", &tcb0_clk),
>  	CLKDEV_CON_DEV_ID("hclk", "700000.ohci", &uhphs_clk),
>  	CLKDEV_CON_DEV_ID("ehci_clk", "800000.ehci", &uhphs_clk),
> +	CLKDEV_CON_DEV_ID("spi_clk", "fffa4000.spi", &spi0_clk),
> +	CLKDEV_CON_DEV_ID("spi_clk", "fffa8000.spi", &spi1_clk),
>  	/* fake hclk clock */
>  	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &uhphs_clk),
>  	CLKDEV_CON_ID("pioA", &pioA_clk),
> diff --git a/arch/arm/mach-at91/at91sam9n12.c b/arch/arm/mach-at91/at91sam9n12.c
> index 0849466..21b264b 100644
> --- a/arch/arm/mach-at91/at91sam9n12.c
> +++ b/arch/arm/mach-at91/at91sam9n12.c
> @@ -169,6 +169,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
>  	CLKDEV_CON_DEV_ID("t0_clk", "f8008000.timer", &tcb_clk),
>  	CLKDEV_CON_DEV_ID("t0_clk", "f800c000.timer", &tcb_clk),
>  	CLKDEV_CON_DEV_ID("dma_clk", "ffffec00.dma-controller", &dma_clk),
> +	CLKDEV_CON_DEV_ID("spi_clk", "f0000000.spi", &spi0_clk),
> +	CLKDEV_CON_DEV_ID("spi_clk", "f0004000.spi", &spi1_clk),
>  	CLKDEV_CON_ID("pioA", &pioAB_clk),
>  	CLKDEV_CON_ID("pioB", &pioAB_clk),
>  	CLKDEV_CON_ID("pioC", &pioCD_clk),
> diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-at91/at91sam9x5.c
> index 477cf9d..b6f3a92 100644
> --- a/arch/arm/mach-at91/at91sam9x5.c
> +++ b/arch/arm/mach-at91/at91sam9x5.c
> @@ -16,6 +16,7 @@
>  #include <mach/at91_pmc.h>
>  #include <mach/cpu.h>
>  #include <mach/board.h>
> +#include <mach/gpio.h>

What is the purpose of this line in this patch?

>  
>  #include "soc.h"
>  #include "generic.h"
> @@ -231,6 +232,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
>  	CLKDEV_CON_DEV_ID("t0_clk", "f800c000.timer", &tcb0_clk),
>  	CLKDEV_CON_DEV_ID("dma_clk", "ffffec00.dma-controller", &dma0_clk),
>  	CLKDEV_CON_DEV_ID("dma_clk", "ffffee00.dma-controller", &dma1_clk),
> +	CLKDEV_CON_DEV_ID("spi_clk", "f0000000.spi", &spi0_clk),
> +	CLKDEV_CON_DEV_ID("spi_clk", "f0004000.spi", &spi1_clk),
>  	CLKDEV_CON_ID("pioA", &pioAB_clk),
>  	CLKDEV_CON_ID("pioB", &pioAB_clk),
>  	CLKDEV_CON_ID("pioC", &pioCD_clk),
> 


-- 
Nicolas Ferre
