From: caesar.upstream@gmail.com (Caesar Wang)
Date: Fri, 16 Oct 2015 09:19:34 +0800
Subject: [PATCH] soc: rockchip: power-domain: don't try to print the clock
 name in error case
In-Reply-To: <1764593.eLkUiZigaK@diego>
References: <1764593.eLkUiZigaK@diego>
Message-ID: <562050A6.7080002@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

Thanks to fix it.

? 2015?10?15? 21:22, Heiko St?bner ??:
> When we never got the the clock-reference, i.e. when IS_ERR(clk) is true,
> don't try to print the clock name via %pC as this of course produces a
> null-pointer-dereference in __clk_get_name().
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Look good to me, you can free add that.

Reviewed-by: Caesar Wang <wxt@rock-chips.com>

> ---
>   drivers/soc/rockchip/pm_domains.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
> index 8268d5d..534c589 100644
> --- a/drivers/soc/rockchip/pm_domains.c
> +++ b/drivers/soc/rockchip/pm_domains.c
> @@ -265,8 +265,8 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
>   		if (IS_ERR(clk)) {
>   			error = PTR_ERR(clk);
>   			dev_err(pmu->dev,
> -				"%s: failed to get clk %pC (index %d): %d\n",
> -				node->name, clk, i, error);
> +				"%s: failed to get clk at index %d: %d\n",
> +				node->name, i, error);
>   			goto err_out;
>   		}
>   
>
> -- 
> Thanks,
> Caesar
