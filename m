From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 12 Jan 2015 15:51:17 -0800
Subject: [PATCH 3/4] arm: pxa: move gpio11 clock to board files
In-Reply-To: <1419688528-760-4-git-send-email-robert.jarzmik@free.fr>
References: <1419688528-760-1-git-send-email-robert.jarzmik@free.fr>
 <1419688528-760-4-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20150112235117.20842.79524@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Robert Jarzmik (2014-12-27 05:55:27)
> The pxa25x gpio11 clock output was previously selected on its pin by the
> clock enabling, toggling the pin function.
> 
> As we transition to common clock framework, the pin function is moved to
> board file for the 2 users, ie. lubbock and eseries.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

Reviewed-by: Michael Turquette <mturquette@linaro.org>

> ---
>  arch/arm/mach-pxa/eseries.c | 5 ++++-
>  arch/arm/mach-pxa/lubbock.c | 3 +++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
> index cfb8641..d8fc9a3 100644
> --- a/arch/arm/mach-pxa/eseries.c
> +++ b/arch/arm/mach-pxa/eseries.c
> @@ -683,7 +683,7 @@ static unsigned long e750_pin_config[] __initdata = {
>         /* PC Card */
>         GPIO8_GPIO,   /* CD0 */
>         GPIO44_GPIO,  /* CD1 */
> -       GPIO11_GPIO,  /* IRQ0 */
> +       /* GPIO11_GPIO,  IRQ0 */
>         GPIO6_GPIO,   /* IRQ1 */
>         GPIO27_GPIO,  /* RST0 */
>         GPIO24_GPIO,  /* RST1 */
> @@ -778,6 +778,9 @@ static unsigned long e800_pin_config[] __initdata = {
>         GPIO29_AC97_SDATA_IN_0,
>         GPIO30_AC97_SDATA_OUT,
>         GPIO31_AC97_SYNC,
> +
> +       /* tc6393xb */
> +       GPIO11_3_6MHz,
>  };
>  
>  static struct w100_gen_regs e800_lcd_regs = {
> diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
> index d8a1be6..b742708 100644
> --- a/arch/arm/mach-pxa/lubbock.c
> +++ b/arch/arm/mach-pxa/lubbock.c
> @@ -101,6 +101,9 @@ static unsigned long lubbock_pin_config[] __initdata = {
>         GPIO6_MMC_CLK,
>         GPIO8_MMC_CS0,
>  
> +       /* SA1111 chip */
> +       GPIO11_3_6MHz,
> +
>         /* wakeup */
>         GPIO1_GPIO | WAKEUP_ON_EDGE_RISE,
>  };
> -- 
> 2.1.0
> 
