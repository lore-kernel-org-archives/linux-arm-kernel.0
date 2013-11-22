From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 22 Nov 2013 15:33:51 +0100
Subject: [PATCH] ARM: at91: sama5d3: reduce TWI internal clock frequency
In-Reply-To: <1385129228-11225-1-git-send-email-ludovic.desroches@atmel.com>
References: <1385129228-11225-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20131122143350.GA7420@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 22, 2013 at 03:07:08PM +0100, ludovic.desroches at atmel.com wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> There are still I2C unexpected behaviors which are solved by reducing TWI
> internal frequency.
> 
> Cc: <stable@vger.kernel.org> #3.10+
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

I think the commit message needs more details. Is this a true bugfix
because the real bus frequency was too high because of the wrong
divider? Is this a workaround which makes things work but will make the
bus frequency slower than it should be?

> ---
>  arch/arm/mach-at91/sama5d3.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/sama5d3.c b/arch/arm/mach-at91/sama5d3.c
> index 4012797..4ee0de5 100644
> --- a/arch/arm/mach-at91/sama5d3.c
> +++ b/arch/arm/mach-at91/sama5d3.c
> @@ -95,19 +95,19 @@ static struct clk twi0_clk = {
>  	.name		= "twi0_clk",
>  	.pid		= SAMA5D3_ID_TWI0,
>  	.type		= CLK_TYPE_PERIPHERAL,
> -	.div		= AT91_PMC_PCR_DIV2,
> +	.div		= AT91_PMC_PCR_DIV8,
>  };
>  static struct clk twi1_clk = {
>  	.name		= "twi1_clk",
>  	.pid		= SAMA5D3_ID_TWI1,
>  	.type		= CLK_TYPE_PERIPHERAL,
> -	.div		= AT91_PMC_PCR_DIV2,
> +	.div		= AT91_PMC_PCR_DIV8,
>  };
>  static struct clk twi2_clk = {
>  	.name		= "twi2_clk",
>  	.pid		= SAMA5D3_ID_TWI2,
>  	.type		= CLK_TYPE_PERIPHERAL,
> -	.div		= AT91_PMC_PCR_DIV2,
> +	.div		= AT91_PMC_PCR_DIV8,
>  };
>  static struct clk mmc0_clk = {
>  	.name		= "mci0_clk",
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131122/6a9cebe4/attachment.sig>
