From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 30 Nov 2015 16:10:55 +0900
Subject: [PATCH] CLK: s3c2410: removed unneeded code in
 s3c24xx_clkout_set_parent
In-Reply-To: <20151130070044.GA23071@jci-VirtualBox>
References: <20151130070044.GA23071@jci-VirtualBox>
Message-ID: <565BF67F.3070705@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.11.2015 16:01, Mutharaju, Prasanna (P.) wrote:
> From: Prasanna Karthik <mkarthi3@visteon.com>
> 
> Remove unneeded variable used to store return value.
> 
> Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>

You need to sign it off too.

The prefix in subject should be lowercase 'clk:' and you are removing
rather a variable, not code.

The patch looks good, so with these changes:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof


> ---
>  drivers/clk/samsung/clk-s3c2410-dclk.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-s3c2410-dclk.c b/drivers/clk/samsung/clk-s3c2410-dclk.c
> index e9eb935..ec6fb14 100644
> --- a/drivers/clk/samsung/clk-s3c2410-dclk.c
> +++ b/drivers/clk/samsung/clk-s3c2410-dclk.c
> @@ -77,12 +77,11 @@ static u8 s3c24xx_clkout_get_parent(struct clk_hw *hw)
>  static int s3c24xx_clkout_set_parent(struct clk_hw *hw, u8 index)
>  {
>  	struct s3c24xx_clkout *clkout = to_s3c24xx_clkout(hw);
> -	int ret = 0;
>  
>  	s3c2410_modify_misccr((clkout->mask << clkout->shift),
>  			      (index << clkout->shift));
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static const struct clk_ops s3c24xx_clkout_ops = {
> 
