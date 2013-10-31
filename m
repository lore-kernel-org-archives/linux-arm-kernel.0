From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 31 Oct 2013 10:12:32 -0700
Subject: [PATCH] clk: Do not dereference potential NULL pointer
In-Reply-To: <1383221036-26890-1-git-send-email-treding@nvidia.com>
References: <1383221036-26890-1-git-send-email-treding@nvidia.com>
Message-ID: <52728F80.8080203@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/13 05:03, Thierry Reding wrote:
> A NULL pointer may be passed to _clk_register() for the dev parameter
> (via clk_register()). Make sure not to dereference it before checking
> that it's valid.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---

Ugh I had this fixed but didn't send it.

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

>  drivers/clk/clk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index b68a999..c0b52e3 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1976,7 +1976,7 @@ static int _clk_register(struct device *dev, struct clk_hw *hw, struct clk *clk)
>  		hw->regmap = hw->init->regmap;
>  	else if (dev && dev_get_regmap(dev, NULL))
>  		hw->regmap = dev_get_regmap(dev, NULL);
> -	else if (dev->parent)
> +	else if (dev && dev->parent)
>  		hw->regmap = dev_get_regmap(dev->parent, NULL);
>  
>  	/* allocate local copy in case parent_names is __initdata */


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
