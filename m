From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 25 Sep 2013 09:18:11 +0200
Subject: [PATCH] ARM: at91: sama5d: add the PWM clock
In-Reply-To: <1380043832-26600-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1380043832-26600-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <52428E33.6010306@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I modify the subject: s/sama5d/sama5d3/ and push it to our
at91-3.13-soc branch on:
https://github.com/at91linux/linux-at91/commits/at91-3.13-soc

With:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks, bye,

On 24/09/2013 19:30, Alexandre Belloni :
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>   arch/arm/mach-at91/sama5d3.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/mach-at91/sama5d3.c b/arch/arm/mach-at91/sama5d3.c
> index 4012797..8e43e8d 100644
> --- a/arch/arm/mach-at91/sama5d3.c
> +++ b/arch/arm/mach-at91/sama5d3.c
> @@ -241,6 +241,11 @@ static struct clk tdes_clk = {
>   	.pid		= SAMA5D3_ID_TDES,
>   	.type		= CLK_TYPE_PERIPHERAL,
>   };
> +static struct clk pwm_clk = {
> +	.name		= "pwm_clk",
> +	.pid		= SAMA5D3_ID_PWM,
> +	.type		= CLK_TYPE_PERIPHERAL,
> +};
>
>   static struct clk *periph_clocks[] __initdata = {
>   	&pioA_clk,
> @@ -281,6 +286,7 @@ static struct clk *periph_clocks[] __initdata = {
>   	&sha_clk,
>   	&aes_clk,
>   	&tdes_clk,
> +	&pwm_clk,
>   };
>
>   static struct clk pck0 = {
> @@ -345,6 +351,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
>   	CLKDEV_CON_DEV_ID("sha_clk", "f8034000.sha", &sha_clk),
>   	CLKDEV_CON_DEV_ID("aes_clk", "f8038000.aes", &aes_clk),
>   	CLKDEV_CON_DEV_ID("tdes_clk", "f803c000.tdes", &tdes_clk),
> +	CLKDEV_CON_DEV_ID(NULL, "f002c000.pwm", &pwm_clk),
>   };
>
>   static void __init sama5d3_register_clocks(void)
>


-- 
Nicolas Ferre
