From: hl@rock-chips.com (hl)
Date: Wed, 18 Jan 2017 12:27:03 +0800
Subject: [PATCH] clk: rockchip: fix the incorrect pclk_edp div width for
 RK3399
In-Reply-To: <1484713256-3005-1-git-send-email-zhengxing@rock-chips.com>
References: <1484713256-3005-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <587EEE97.804@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested-by: Lin Huang <hl@rock-chips.com>

On 2017?01?18? 12:20, Xing Zheng wrote:
> The range of the  pclk_edp_div_con is [13:8] and 6 bits, not 5.
>
> Reported-by: Lin Huang <hl@rock-chips.com>
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> ---
>
>   drivers/clk/rockchip/clk-rk3399.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
> index 3490887..73121b14 100644
> --- a/drivers/clk/rockchip/clk-rk3399.c
> +++ b/drivers/clk/rockchip/clk-rk3399.c
> @@ -1132,7 +1132,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
>   			RK3399_CLKGATE_CON(11), 8, GFLAGS),
>   
>   	COMPOSITE(PCLK_EDP, "pclk_edp", mux_pll_src_cpll_gpll_p, 0,
> -			RK3399_CLKSEL_CON(44), 15, 1, MFLAGS, 8, 5, DFLAGS,
> +			RK3399_CLKSEL_CON(44), 15, 1, MFLAGS, 8, 6, DFLAGS,
>   			RK3399_CLKGATE_CON(11), 11, GFLAGS),
>   	GATE(PCLK_EDP_NOC, "pclk_edp_noc", "pclk_edp", CLK_IGNORE_UNUSED,
>   			RK3399_CLKGATE_CON(32), 12, GFLAGS),

-- 
Lin Huang
