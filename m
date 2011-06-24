From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 24 Jun 2011 10:12:05 +0200
Subject: [PATCH] at91: fix udc,
	ehci and mmc clock device name for cap9/9g45/9rl
In-Reply-To: <1308865732-16464-1-git-send-email-plagnioj@jcrosoft.com>
References: <1308865732-16464-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <4E0446D5.5010501@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 23/06/2011 23:48, Jean-Christophe PLAGNIOL-VILLARD :
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

We absolutely have to queue this one for 3.0-final.

Thanks,

> ---
>  arch/arm/mach-at91/at91cap9.c    |    4 ++--
>  arch/arm/mach-at91/at91sam9g45.c |   10 +++++-----
>  arch/arm/mach-at91/at91sam9rl.c  |    4 ++--
>  3 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
> index 1f07c3f..e6e5f77 100644
> --- a/arch/arm/mach-at91/at91cap9.c
> +++ b/arch/arm/mach-at91/at91cap9.c
> @@ -219,8 +219,8 @@ static struct clk *periph_clocks[] __initdata = {
>  };
>  
>  static struct clk_lookup periph_clocks_lookups[] = {
> -	CLKDEV_CON_DEV_ID("hclk", "atmel_usba_udc.0", &utmi_clk),
> -	CLKDEV_CON_DEV_ID("pclk", "atmel_usba_udc.0", &udphs_clk),
> +	CLKDEV_CON_DEV_ID("hclk", "atmel_usba_udc", &utmi_clk),
> +	CLKDEV_CON_DEV_ID("pclk", "atmel_usba_udc", &udphs_clk),
>  	CLKDEV_CON_DEV_ID("mci_clk", "at91_mci.0", &mmc0_clk),
>  	CLKDEV_CON_DEV_ID("mci_clk", "at91_mci.1", &mmc1_clk),
>  	CLKDEV_CON_DEV_ID("spi_clk", "atmel_spi.0", &spi0_clk),
> diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
> index d4ba73a..f5e72da 100644
> --- a/arch/arm/mach-at91/at91sam9g45.c
> +++ b/arch/arm/mach-at91/at91sam9g45.c
> @@ -213,11 +213,11 @@ static struct clk *periph_clocks[] __initdata = {
>  static struct clk_lookup periph_clocks_lookups[] = {
>  	/* One additional fake clock for ohci */
>  	CLKDEV_CON_ID("ohci_clk", &uhphs_clk),
> -	CLKDEV_CON_DEV_ID("ehci_clk", "atmel-ehci.0", &uhphs_clk),
> -	CLKDEV_CON_DEV_ID("hclk", "atmel_usba_udc.0", &utmi_clk),
> -	CLKDEV_CON_DEV_ID("pclk", "atmel_usba_udc.0", &udphs_clk),
> -	CLKDEV_CON_DEV_ID("mci_clk", "at91_mci.0", &mmc0_clk),
> -	CLKDEV_CON_DEV_ID("mci_clk", "at91_mci.1", &mmc1_clk),
> +	CLKDEV_CON_DEV_ID("ehci_clk", "atmel-ehci", &uhphs_clk),
> +	CLKDEV_CON_DEV_ID("hclk", "atmel_usba_udc", &utmi_clk),
> +	CLKDEV_CON_DEV_ID("pclk", "atmel_usba_udc", &udphs_clk),
> +	CLKDEV_CON_DEV_ID("mci_clk", "atmel_mci.0", &mmc0_clk),
> +	CLKDEV_CON_DEV_ID("mci_clk", "atmel_mci.1", &mmc1_clk),
>  	CLKDEV_CON_DEV_ID("spi_clk", "atmel_spi.0", &spi0_clk),
>  	CLKDEV_CON_DEV_ID("spi_clk", "atmel_spi.1", &spi1_clk),
>  	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.0", &tcb0_clk),
> diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
> index a8d2ad8..0788adb 100644
> --- a/arch/arm/mach-at91/at91sam9rl.c
> +++ b/arch/arm/mach-at91/at91sam9rl.c
> @@ -183,8 +183,8 @@ static struct clk *periph_clocks[] __initdata = {
>  };
>  
>  static struct clk_lookup periph_clocks_lookups[] = {
> -	CLKDEV_CON_DEV_ID("hclk", "atmel_usba_udc.0", &utmi_clk),
> -	CLKDEV_CON_DEV_ID("pclk", "atmel_usba_udc.0", &udphs_clk),
> +	CLKDEV_CON_DEV_ID("hclk", "atmel_usba_udc", &utmi_clk),
> +	CLKDEV_CON_DEV_ID("pclk", "atmel_usba_udc", &udphs_clk),
>  	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.0", &tc0_clk),
>  	CLKDEV_CON_DEV_ID("t1_clk", "atmel_tcb.0", &tc1_clk),
>  	CLKDEV_CON_DEV_ID("t2_clk", "atmel_tcb.0", &tc2_clk),


-- 
Nicolas Ferre
