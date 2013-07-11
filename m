From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 11 Jul 2013 09:50:16 +0200
Subject: [PATCH v2 2/6] clk: samsung: fix error handling in pll register
 functions
In-Reply-To: <201307100058.13941.heiko@sntech.de>
References: <201307100057.06061.heiko@sntech.de>
 <201307100058.13941.heiko@sntech.de>
Message-ID: <1418034.CJ7vtBLiog@thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Wednesday 10 of July 2013 00:58:13 Heiko St?bner wrote:
> kmalloc has its own error reporting when the allocation fails and
> the register functions also should return the correct ERR_PTR(-ENOMEM)
> when it happens.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/clk/samsung/clk-pll.c |   30 ++++++++++--------------------
>  1 file changed, 10 insertions(+), 20 deletions(-)

This patch looks pretty good, but I'm not sure if this problem still exists 
after applying Yadwinder's patches that completely changes the way of PLL 
registration.

Best regards,
Tomasz

> diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
> index 9153e46..0afaec6 100644
> --- a/drivers/clk/samsung/clk-pll.c
> +++ b/drivers/clk/samsung/clk-pll.c
> @@ -79,10 +79,8 @@ struct clk * __init samsung_clk_register_pll35xx(const
> char *name, struct clk_init_data init;
> 
>  	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
> -	if (!pll) {
> -		pr_err("%s: could not allocate pll clk %s\n", __func__, name);
> -		return NULL;
> -	}
> +	if (!pll)
> +		return ERR_PTR(-ENOMEM);
> 
>  	init.name = name;
>  	init.ops = &samsung_pll35xx_clk_ops;
> @@ -153,10 +151,8 @@ struct clk * __init samsung_clk_register_pll36xx(const
> char *name, struct clk_init_data init;
> 
>  	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
> -	if (!pll) {
> -		pr_err("%s: could not allocate pll clk %s\n", __func__, name);
> -		return NULL;
> -	}
> +	if (!pll)
> +		return ERR_PTR(-ENOMEM);
> 
>  	init.name = name;
>  	init.ops = &samsung_pll36xx_clk_ops;
> @@ -227,10 +223,8 @@ struct clk * __init samsung_clk_register_pll45xx(const
> char *name, struct clk_init_data init;
> 
>  	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
> -	if (!pll) {
> -		pr_err("%s: could not allocate pll clk %s\n", __func__, name);
> -		return NULL;
> -	}
> +	if (!pll)
> +		return ERR_PTR(-ENOMEM);
> 
>  	init.name = name;
>  	init.ops = &samsung_pll45xx_clk_ops;
> @@ -308,10 +302,8 @@ struct clk * __init samsung_clk_register_pll46xx(const
> char *name, struct clk_init_data init;
> 
>  	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
> -	if (!pll) {
> -		pr_err("%s: could not allocate pll clk %s\n", __func__, name);
> -		return NULL;
> -	}
> +	if (!pll)
> +		return ERR_PTR(-ENOMEM);
> 
>  	init.name = name;
>  	init.ops = &samsung_pll46xx_clk_ops;
> @@ -385,10 +377,8 @@ struct clk * __init samsung_clk_register_pll2550x(const
> char *name, struct clk_init_data init;
> 
>  	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
> -	if (!pll) {
> -		pr_err("%s: could not allocate pll clk %s\n", __func__, name);
> -		return NULL;
> -	}
> +	if (!pll)
> +		return ERR_PTR(-ENOMEM);
> 
>  	init.name = name;
>  	init.ops = &samsung_pll2550x_clk_ops;
