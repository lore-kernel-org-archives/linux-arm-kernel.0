From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 30 Nov 2015 17:03:07 +0900
Subject: [PATCH v3] clk: s3c2410: removed unneeded variable in
 s3c24xx_clkout_set_parent
In-Reply-To: <20151130075219.GA27737@jci-VirtualBox>
References: <20151130075219.GA27737@jci-VirtualBox>
Message-ID: <565C02BB.5090506@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.11.2015 16:52, Mutharaju, Prasanna (P.) wrote:
> From: Prasanna Karthik <mkarthi3@visteon.com>
> 
> Remove unneeded variable used to store return value.
> ---
> v3: Modified subject and changelog comments
> ---
> 
> Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>

... and now download the patch and try to apply it with "git am". What
is missing? :)

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
