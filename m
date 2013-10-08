From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 8 Oct 2013 18:29:44 +0200
Subject: [PATCH v3 19/19] ARM: at91: add new compatible strings for pmc
 driver
In-Reply-To: <1375949965-10586-1-git-send-email-b.brezillon@overkiz.com>
References: <1375937608-3773-1-git-send-email-b.brezillon@overkiz.com>
 <1375949965-10586-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <525432F8.9060600@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2013 10:19, Boris BREZILLON :
> This patch adds new compatible string for PMC node to prepare the
> transition to common clk.
>
> These compatible string come from pmc driver in clk subsystem and are
> needed to provide new device tree compatibility with old at91 clks
> (device tree using common clks will use the new compatible strings).
>
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
> ---
>   arch/arm/mach-at91/clock.c |    6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/mach-at91/clock.c b/arch/arm/mach-at91/clock.c
> index 5f02aea..4d4463a 100644
> --- a/arch/arm/mach-at91/clock.c
> +++ b/arch/arm/mach-at91/clock.c
> @@ -884,6 +884,12 @@ static int __init at91_pmc_init(unsigned long main_clock)
>   #if defined(CONFIG_OF)
>   static struct of_device_id pmc_ids[] = {
>   	{ .compatible = "atmel,at91rm9200-pmc" },
> +	{ .compatible = "atmel,at91sam9260-pmc" },
> +	{ .compatible = "atmel,at91sam9g45-pmc" },
> +	{ .compatible = "atmel,at91sam9n12-pmc" },
> +	{ .compatible = "atmel,at91sam9x5-pmc" },
> +	{ .compatible = "atmel,at91sam9g35-pmc" },

With removal of this compatibility string:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> +	{ .compatible = "atmel,sama5d3-pmc" },
>   	{ /*sentinel*/ }
>   };
>
>


-- 
Nicolas Ferre
