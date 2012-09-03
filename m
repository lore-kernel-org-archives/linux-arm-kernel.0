From: N.Voss@weinmann.de (Voss, Nikolaus)
Date: Mon, 3 Sep 2012 07:58:24 +0200
Subject: [PATCH 6/8] ARM: at91: add clocks for I2C DT entries
In-Reply-To: <1346405058-18580-1-git-send-email-ludovic.desroches@atmel.com>
References: <1346404884-18451-1-git-send-email-ludovic.desroches@atmel.com>
 <1346405058-18580-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D090EC8F377@wm021.weinmann.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ludovic.desroches at atmel.com wrote on Friday, August 31, 2012 11:24 AM
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Acked-by: Nikolaus Voss <n.voss@weinmann.de>


> ---
>  arch/arm/mach-at91/at91sam9260.c | 1 +
>  arch/arm/mach-at91/at91sam9263.c | 1 +
>  arch/arm/mach-at91/at91sam9g45.c | 2 ++
>  arch/arm/mach-at91/at91sam9n12.c | 2 ++
>  arch/arm/mach-at91/at91sam9x5.c  | 6 +++---
>  5 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-
> at91/at91sam9260.c
> index 5f86e71..43f529a 100644
> --- a/arch/arm/mach-at91/at91sam9260.c
> +++ b/arch/arm/mach-at91/at91sam9260.c
> @@ -221,6 +221,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
>  	CLKDEV_CON_DEV_ID("usart", "fffd0000.serial", &usart3_clk),
>  	CLKDEV_CON_DEV_ID("usart", "fffd4000.serial", &usart4_clk),
>  	CLKDEV_CON_DEV_ID("usart", "fffd8000.serial", &usart5_clk),
> +	CLKDEV_CON_DEV_ID(NULL, "fffac000.i2c", &twi_clk),
>  	/* more tc lookup table for DT entries */
>  	CLKDEV_CON_DEV_ID("t0_clk", "fffa0000.timer", &tc0_clk),
>  	CLKDEV_CON_DEV_ID("t1_clk", "fffa0000.timer", &tc1_clk),
> diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-
> at91/at91sam9263.c
> index a4d760c..514757e 100644
> --- a/arch/arm/mach-at91/at91sam9263.c
> +++ b/arch/arm/mach-at91/at91sam9263.c
> @@ -211,6 +211,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
>  	CLKDEV_CON_DEV_ID("hclk", "a00000.ohci", &ohci_clk),
>  	CLKDEV_CON_DEV_ID("spi_clk", "fffa4000.spi", &spi0_clk),
>  	CLKDEV_CON_DEV_ID("spi_clk", "fffa8000.spi", &spi1_clk),
> +	CLKDEV_CON_DEV_ID(NULL, "fff88000.i2c", &twi_clk),
>  };
> 
>  static struct clk_lookup usart_clocks_lookups[] = {
> diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-
> at91/at91sam9g45.c
> index 15e62b9..9f3beba 100644
> --- a/arch/arm/mach-at91/at91sam9g45.c
> +++ b/arch/arm/mach-at91/at91sam9g45.c
> @@ -256,6 +256,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
>  	CLKDEV_CON_DEV_ID("t0_clk", "fffd4000.timer", &tcb0_clk),
>  	CLKDEV_CON_DEV_ID("hclk", "700000.ohci", &uhphs_clk),
>  	CLKDEV_CON_DEV_ID("ehci_clk", "800000.ehci", &uhphs_clk),
> +	CLKDEV_CON_DEV_ID(NULL, "fff84000.i2c", &twi0_clk),
> +	CLKDEV_CON_DEV_ID(NULL, "fff88000.i2c", &twi1_clk),
>  	/* fake hclk clock */
>  	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &uhphs_clk),
>  	CLKDEV_CON_ID("pioA", &pioA_clk),
> diff --git a/arch/arm/mach-at91/at91sam9n12.c b/arch/arm/mach-
> at91/at91sam9n12.c
> index 0849466..732d3d3 100644
> --- a/arch/arm/mach-at91/at91sam9n12.c
> +++ b/arch/arm/mach-at91/at91sam9n12.c
> @@ -169,6 +169,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
>  	CLKDEV_CON_DEV_ID("t0_clk", "f8008000.timer", &tcb_clk),
>  	CLKDEV_CON_DEV_ID("t0_clk", "f800c000.timer", &tcb_clk),
>  	CLKDEV_CON_DEV_ID("dma_clk", "ffffec00.dma-controller",
> &dma_clk),
> +	CLKDEV_CON_DEV_ID(NULL, "f8010000.i2c", &twi0_clk),
> +	CLKDEV_CON_DEV_ID(NULL, "f8014000.i2c", &twi1_clk),
>  	CLKDEV_CON_ID("pioA", &pioAB_clk),
>  	CLKDEV_CON_ID("pioB", &pioAB_clk),
>  	CLKDEV_CON_ID("pioC", &pioCD_clk),
> diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-
> at91/at91sam9x5.c
> index 4bad4a2..e503538 100644
> --- a/arch/arm/mach-at91/at91sam9x5.c
> +++ b/arch/arm/mach-at91/at91sam9x5.c
> @@ -231,9 +231,9 @@ static struct clk_lookup periph_clocks_lookups[] = {
>  	CLKDEV_CON_DEV_ID("t0_clk", "f800c000.timer", &tcb0_clk),
>  	CLKDEV_CON_DEV_ID("dma_clk", "ffffec00.dma-controller",
> &dma0_clk),
>  	CLKDEV_CON_DEV_ID("dma_clk", "ffffee00.dma-controller",
> &dma1_clk),
> -	CLKDEV_CON_DEV_ID(NULL, "at91_i2c.0", &twi0_clk),
> -	CLKDEV_CON_DEV_ID(NULL, "at91_i2c.1", &twi1_clk),
> -	CLKDEV_CON_DEV_ID(NULL, "at91_i2c.2", &twi2_clk),
> +	CLKDEV_CON_DEV_ID(NULL, "f8010000.i2c", &twi0_clk),
> +	CLKDEV_CON_DEV_ID(NULL, "f8014000.i2c", &twi1_clk),
> +	CLKDEV_CON_DEV_ID(NULL, "f8018000.i2c", &twi2_clk),
>  	CLKDEV_CON_ID("pioA", &pioAB_clk),
>  	CLKDEV_CON_ID("pioB", &pioAB_clk),
>  	CLKDEV_CON_ID("pioC", &pioCD_clk),
> --
> 1.7.11.3
