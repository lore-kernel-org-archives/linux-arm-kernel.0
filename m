From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 4 Feb 2014 10:05:08 +0100
Subject: [PATCH 3/3] clk: at91: propagate rate change on system clks
In-Reply-To: <1391426731-9392-4-git-send-email-b.brezillon@overkiz.com>
References: <1391426731-9392-1-git-send-email-b.brezillon@overkiz.com>
 <1391426731-9392-4-git-send-email-b.brezillon@overkiz.com>
Message-ID: <52F0AD44.6090203@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/02/2014 12:25, Boris BREZILLON :
> System clks are just gates, and thus do not provide any rate operations.
> Authorize clk rate change to be propagated to system clk parents.
> 
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  drivers/clk/at91/clk-system.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/at91/clk-system.c b/drivers/clk/at91/clk-system.c
> index 8f7c043..a98557b 100644
> --- a/drivers/clk/at91/clk-system.c
> +++ b/drivers/clk/at91/clk-system.c
> @@ -84,7 +84,8 @@ at91_clk_register_system(struct at91_pmc *pmc, const char *name,
>  	 * (see drivers/memory) which would request and enable the ddrck clock.
>  	 * When this is done we will be able to remove CLK_IGNORE_UNUSED flag.
>  	 */
> -	init.flags = CLK_IGNORE_UNUSED;
> +	init.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT |
> +		     CLK_IGNORE_UNUSED;
>  
>  	sys->id = id;
>  	sys->hw.init = &init;
> 


-- 
Nicolas Ferre
