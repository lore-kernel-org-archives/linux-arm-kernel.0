From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 11 Oct 2014 20:37:20 +0200
Subject: [PATCH] clk: rockchip: Add CLK_SET_RATE_PARENT to aclk_cpu_pre
In-Reply-To: <1412615727-8772-1-git-send-email-dianders@chromium.org>
References: <1412615727-8772-1-git-send-email-dianders@chromium.org>
Message-ID: <1438809.8b7neIcoln@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

Am Montag, 6. Oktober 2014, 10:15:27 schrieb Doug Anderson:
> We'd like to be able to call clk_set_rate() on aclk_cpu (a gate) at
> bootup.  In order for this to have any effect we need its parent
> (aclk_cpu_pre) to percolate the rate change to _its_ parent
> (aclk_cpu_src).  Add CLK_SET_RATE_PARENT to make this happen.

added this to a branch for 3.19


Thanks
Heiko

> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>  drivers/clk/rockchip/clk-rk3288.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3288.c
> b/drivers/clk/rockchip/clk-rk3288.c index d053529..4d98f53 100644
> --- a/drivers/clk/rockchip/clk-rk3288.c
> +++ b/drivers/clk/rockchip/clk-rk3288.c
> @@ -279,7 +279,7 @@ static struct rockchip_clk_branch rk3288_clk_branches[]
> __initdata = { RK3288_CLKGATE_CON(0), 11, GFLAGS),
>  	COMPOSITE_NOGATE(0, "aclk_cpu_src", mux_aclk_cpu_src_p, 0,
>  			RK3288_CLKSEL_CON(1), 15, 1, MFLAGS, 3, 5, DFLAGS),
> -	DIV(0, "aclk_cpu_pre", "aclk_cpu_src", 0,
> +	DIV(0, "aclk_cpu_pre", "aclk_cpu_src", CLK_SET_RATE_PARENT,
>  			RK3288_CLKSEL_CON(1), 0, 3, DFLAGS),
>  	GATE(ACLK_CPU, "aclk_cpu", "aclk_cpu_pre", 0,
>  			RK3288_CLKGATE_CON(0), 3, GFLAGS),
