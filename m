From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 18 Dec 2013 23:56:36 -0800
Subject: [PATCH] clk: at91: fix pmc_clk_ids data type attriubte
In-Reply-To: <1387229127-7605-1-git-send-email-b.brezillon@overkiz.com>
References: <1387229127-7605-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <20131219075636.18119.74853@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Boris BREZILLON (2013-12-16 13:25:27)
> Fix pmc_clk_ids data type attribute (__initdata -> __initconst).
> 
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
> Reported-by: Fengguang Wu <fengguang.wu@intel.com>

Acked-by: Mike Turquette <mturquette@linaro.org>

> ---
>  drivers/clk/at91/pmc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
> index 7b9db60..4c03eda 100644
> --- a/drivers/clk/at91/pmc.c
> +++ b/drivers/clk/at91/pmc.c
> @@ -228,7 +228,7 @@ out_free_pmc:
>         return NULL;
>  }
>  
> -static const struct of_device_id pmc_clk_ids[] __initdata = {
> +static const struct of_device_id pmc_clk_ids[] __initconst = {
>         /* Main clock */
>         {
>                 .compatible = "atmel,at91rm9200-clk-main",
> -- 
> 1.7.9.5
> 
