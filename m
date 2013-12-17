From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 17 Dec 2013 10:33:04 +0100
Subject: [PATCH] clk: at91: fix pmc_clk_ids data type attriubte
In-Reply-To: <1387229127-7605-1-git-send-email-b.brezillon@overkiz.com>
References: <1387229127-7605-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <52B01A50.4080209@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/12/2013 22:25, Boris BREZILLON :
> Fix pmc_clk_ids data type attribute (__initdata -> __initconst).
> 
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
> Reported-by: Fengguang Wu <fengguang.wu@intel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

I take it in at91-3.14-cleanup2 branch and send it upstream through
arm-soc like any other CCF material for AT91 for the 3.14 release.

I guess that even without Mike Acked-by, this little fix can follow this
path.

Bye,

> ---
>  drivers/clk/at91/pmc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
> index 7b9db60..4c03eda 100644
> --- a/drivers/clk/at91/pmc.c
> +++ b/drivers/clk/at91/pmc.c
> @@ -228,7 +228,7 @@ out_free_pmc:
>  	return NULL;
>  }
>  
> -static const struct of_device_id pmc_clk_ids[] __initdata = {
> +static const struct of_device_id pmc_clk_ids[] __initconst = {
>  	/* Main clock */
>  	{
>  		.compatible = "atmel,at91rm9200-clk-main",
> 


-- 
Nicolas Ferre
