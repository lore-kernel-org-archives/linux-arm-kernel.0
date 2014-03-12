From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 12 Mar 2014 18:17:27 +0100
Subject: [PATCH 1/3] ARM: at91: add PWM clock
In-Reply-To: <1387425558-8589-2-git-send-email-voice.shen@atmel.com>
References: <1387425558-8589-1-git-send-email-voice.shen@atmel.com>
 <1387425558-8589-2-git-send-email-voice.shen@atmel.com>
Message-ID: <532096A7.30202@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/12/2013 04:59, Bo Shen :
> Add PWM clock for AT91 series SoC which include PWM controller.
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>

This one was forgotten in previous update.

Stacked on at91-3.15-cleanup because of dependency on 9rl modifications.

Thanks.


> ---
>  arch/arm/mach-at91/at91sam9263.c |    1 +
>  arch/arm/mach-at91/at91sam9g45.c |    1 +
>  arch/arm/mach-at91/at91sam9n12.c |    1 +
>  arch/arm/mach-at91/at91sam9rl.c  |    1 +
>  arch/arm/mach-at91/at91sam9x5.c  |    1 +
>  5 files changed, 5 insertions(+)
> 
> diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
> index 37b90f4..fbd771d 100644
> --- a/arch/arm/mach-at91/at91sam9263.c
> +++ b/arch/arm/mach-at91/at91sam9263.c
> @@ -223,6 +223,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
>  	CLKDEV_CON_DEV_ID(NULL, "fffff600.gpio", &pioCDE_clk),
>  	CLKDEV_CON_DEV_ID(NULL, "fffff800.gpio", &pioCDE_clk),
>  	CLKDEV_CON_DEV_ID(NULL, "fffffa00.gpio", &pioCDE_clk),
> +	CLKDEV_CON_DEV_ID(NULL, "fffb8000.pwm", &pwm_clk),
>  };
>  
>  static struct clk_lookup usart_clocks_lookups[] = {
> diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
> index 2f455ce..e9ba934 100644
> --- a/arch/arm/mach-at91/at91sam9g45.c
> +++ b/arch/arm/mach-at91/at91sam9g45.c
> @@ -284,6 +284,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
>  	CLKDEV_CON_ID("pioE", &pioDE_clk),
>  	/* Fake adc clock */
>  	CLKDEV_CON_ID("adc_clk", &tsc_clk),
> +	CLKDEV_CON_DEV_ID(NULL, "fffb8000.pwm", &pwm_clk),
>  };
>  
>  static struct clk_lookup usart_clocks_lookups[] = {
> diff --git a/arch/arm/mach-at91/at91sam9n12.c b/arch/arm/mach-at91/at91sam9n12.c
> index 4ef088c..f2ea7b0 100644
> --- a/arch/arm/mach-at91/at91sam9n12.c
> +++ b/arch/arm/mach-at91/at91sam9n12.c
> @@ -182,6 +182,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
>  	/* additional fake clock for macb_hclk */
>  	CLKDEV_CON_DEV_ID("hclk", "500000.ohci", &uhp_clk),
>  	CLKDEV_CON_DEV_ID("ohci_clk", "500000.ohci", &uhp_clk),
> +	CLKDEV_CON_DEV_ID(NULL, "f8034000.pwm", &pwm_clk),
>  };
>  
>  /*
> diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
> index 3651517..e577d37 100644
> --- a/arch/arm/mach-at91/at91sam9rl.c
> +++ b/arch/arm/mach-at91/at91sam9rl.c
> @@ -196,6 +196,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
>  	CLKDEV_CON_ID("pioB", &pioB_clk),
>  	CLKDEV_CON_ID("pioC", &pioC_clk),
>  	CLKDEV_CON_ID("pioD", &pioD_clk),
> +	CLKDEV_CON_DEV_ID(NULL, "fffc8000.pwm", &pwm_clk),
>  };
>  
>  static struct clk_lookup usart_clocks_lookups[] = {
> diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-at91/at91sam9x5.c
> index 3e8ec26..9ad781d 100644
> --- a/arch/arm/mach-at91/at91sam9x5.c
> +++ b/arch/arm/mach-at91/at91sam9x5.c
> @@ -253,6 +253,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
>  	CLKDEV_CON_DEV_ID("ehci_clk", "700000.ehci", &uhphs_clk),
>  	CLKDEV_CON_DEV_ID("hclk", "500000.gadget", &utmi_clk),
>  	CLKDEV_CON_DEV_ID("pclk", "500000.gadget", &udphs_clk),
> +	CLKDEV_CON_DEV_ID(NULL, "f8034000.pwm", &pwm_clk),
>  };
>  
>  /*
> 


-- 
Nicolas Ferre
