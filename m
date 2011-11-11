From: robherring2@gmail.com (Rob Herring)
Date: Fri, 11 Nov 2011 09:17:25 -0600
Subject: [PATCH] mach-ux500: add devicetree compat nodes
In-Reply-To: <1321023902-18870-1-git-send-email-niklas.hernaeus@linaro.org>
References: <1321023902-18870-1-git-send-email-niklas.hernaeus@linaro.org>
Message-ID: <4EBD3C85.1010508@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/2011 09:05 AM, Niklas Hernaeus wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This adds devicetree compat members to all the U8500 reference
> boards.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/mach-ux500/board-mop500.c |   18 ++++++++++++++++++
>  1 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
> index cd54aba..7cbefa7 100644
> --- a/arch/arm/mach-ux500/board-mop500.c
> +++ b/arch/arm/mach-ux500/board-mop500.c
> @@ -643,6 +643,21 @@ static void __init mop500_init_machine(void)
>  	regulator_has_full_constraints();
>  }
>  
> +static const char * mop500_dt_board_compat[] = {
> +	"stericsson,mop500",
> +	NULL
> +};
> +
> +static const char * hrefv60_dt_board_compat[] = {
> +	"stericsson,hrefv60",
> +	NULL
> +};
> +
> +static const char * snowball_dt_board_compat[] = {
> +	"stericsson,snowball",
> +	NULL
> +};
> +
>  MACHINE_START(U8500, "ST-Ericsson MOP500 platform")
>  	/* Maintainer: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com> */
>  	.boot_params	= 0x100,
> @@ -651,6 +666,7 @@ MACHINE_START(U8500, "ST-Ericsson MOP500 platform")
>  	/* we re-use nomadik timer here */
>  	.timer		= &ux500_timer,
>  	.init_machine	= mop500_init_machine,
> +	.dt_compat	= mop500_dt_board_compat,
>  MACHINE_END
>  
>  MACHINE_START(HREFV60, "ST-Ericsson U8500 Platform HREFv60+")
> @@ -659,6 +675,7 @@ MACHINE_START(HREFV60, "ST-Ericsson U8500 Platform HREFv60+")
>  	.init_irq	= ux500_init_irq,
>  	.timer		= &ux500_timer,
>  	.init_machine	= mop500_init_machine,
> +	.dt_compat	= hrefv60_dt_board_compat,
>  MACHINE_END
>  
>  MACHINE_START(SNOWBALL, "Calao Systems Snowball platform")
> @@ -668,4 +685,5 @@ MACHINE_START(SNOWBALL, "Calao Systems Snowball platform")
>  	/* we re-use nomadik timer here */
>  	.timer		= &ux500_timer,
>  	.init_machine	= mop500_init_machine,
> +	.dt_compat	= snowball_dt_board_compat,
>  MACHINE_END

These all look very similar and should be combined. Why do you not have
1 machine for all DT platforms as other SOCs are doing?

Rob
