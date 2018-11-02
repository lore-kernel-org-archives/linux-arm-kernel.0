From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 2 Nov 2018 14:49:51 +0200
Subject: [PATCH v3 6/7] clk: clk-twl6040: Free of_provider at remove
In-Reply-To: <855d60c35f092de196b131838fe0b07e9d3080d3.1541161503.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1541161503.git.matti.vaittinen@fi.rohmeurope.com>
 <855d60c35f092de196b131838fe0b07e9d3080d3.1541161503.git.matti.vaittinen@fi.rohmeurope.com>
Message-ID: <4b0cceec-ddc8-5398-33a1-e0e91dabdcdf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/2/18 2:37 PM, Matti Vaittinen wrote:
> use devm variant for of_provider registration so provider is freed
> at exit.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  drivers/clk/clk-twl6040.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/clk-twl6040.c b/drivers/clk/clk-twl6040.c
> index 25dfe050ae9f..e9da09453eb2 100644
> --- a/drivers/clk/clk-twl6040.c
> +++ b/drivers/clk/clk-twl6040.c
> @@ -108,9 +108,8 @@ static int twl6040_pdmclk_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, clkdata);
>  
> -	return of_clk_add_hw_provider(pdev->dev.parent->of_node,
> -				      of_clk_hw_simple_get,
> -				      &clkdata->pdmclk_hw);
> +	return devm_of_clk_add_parent_hw_provider(&pdev->dev,
> +			of_clk_hw_simple_get, &clkdata->pdmclk_hw);
>  }
>  
>  static struct platform_driver twl6040_pdmclk_driver = {
> 

- Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
