From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Mon, 1 Aug 2016 16:47:32 +0800
Subject: [RESEND PATCH 5/6] clk: rockchip: rk3399: delete the
 CLK_IGNORE_UNUSED for aclk_pcie
In-Reply-To: <1470025485-4218-1-git-send-email-zhengxing@rock-chips.com>
References: <1470025389-4094-1-git-send-email-zhengxing@rock-chips.com>
 <1470025485-4218-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <8ee66f8c-f758-45ef-6e21-f757157d2fe4@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/8/1 12:24, Xing Zheng wrote:
> From: Elaine Zhang <zhangqing@rock-chips.com>
>
> allow aclk_pcie and aclk_perf_pcie disabled when unused.
>

Thanks for landing it. Yes, my pcie driver will control it
manually, and this patch looks the same as what we land on
the downstream tree, so

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
>
> ---
>
>  drivers/clk/rockchip/clk-rk3399.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
> index 74afec0..4a15ce5b 100644
> --- a/drivers/clk/rockchip/clk-rk3399.c
> +++ b/drivers/clk/rockchip/clk-rk3399.c
> @@ -848,9 +848,9 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
>  			RK3399_CLKSEL_CON(14), 12, 2, DFLAGS,
>  			RK3399_CLKGATE_CON(5), 4, GFLAGS),
>
> -	GATE(ACLK_PERF_PCIE, "aclk_perf_pcie", "aclk_perihp", CLK_IGNORE_UNUSED,
> +	GATE(ACLK_PERF_PCIE, "aclk_perf_pcie", "aclk_perihp", 0,
>  			RK3399_CLKGATE_CON(20), 2, GFLAGS),
> -	GATE(ACLK_PCIE, "aclk_pcie", "aclk_perihp", CLK_IGNORE_UNUSED,
> +	GATE(ACLK_PCIE, "aclk_pcie", "aclk_perihp", 0,
>  			RK3399_CLKGATE_CON(20), 10, GFLAGS),
>  	GATE(0, "aclk_perihp_noc", "aclk_perihp", CLK_IGNORE_UNUSED,
>  			RK3399_CLKGATE_CON(20), 12, GFLAGS),
>


-- 
Best Regards
Shawn Lin
