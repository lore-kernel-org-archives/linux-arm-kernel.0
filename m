From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 20 Oct 2014 13:56:28 +0200
Subject: [PATCH] clk: rockchip: rk3288: removing the CLK_SET_RATE_PARENT
 from i2s_clkout
In-Reply-To: <1413798903-13967-1-git-send-email-jay.xu@rock-chips.com>
References: <1413798903-13967-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <1581410.KVPbBdLuDz@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 20. Oktober 2014, 17:55:03 schrieb Jianqun:
> Removing the CLK_SET_RATE_PARENT from i2s_clkout, to limit i2s0_clkout
> to select between its two parent without being able influence the core
> i2s clock.
> 
> Tested on rk3288 board, suggested by Heiko.
> 
> Signed-off-by: Jianqun <jay.xu@rock-chips.com>

applied this to my v3.19-clk/next branch


Thanks
Heiko

> ---
>  drivers/clk/rockchip/clk-rk3288.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3288.c
> b/drivers/clk/rockchip/clk-rk3288.c index 2327829..6f97fe4 100644
> --- a/drivers/clk/rockchip/clk-rk3288.c
> +++ b/drivers/clk/rockchip/clk-rk3288.c
> @@ -305,7 +305,7 @@ static struct rockchip_clk_branch rk3288_clk_branches[]
> __initdata = { RK3288_CLKGATE_CON(4), 2, GFLAGS),
>  	MUX(0, "i2s_pre", mux_i2s_pre_p, CLK_SET_RATE_PARENT,
>  			RK3288_CLKSEL_CON(4), 8, 2, MFLAGS),
> -	COMPOSITE_NODIV(0, "i2s0_clkout", mux_i2s_clkout_p, CLK_SET_RATE_PARENT,
> +	COMPOSITE_NODIV(0, "i2s0_clkout", mux_i2s_clkout_p, 0,
>  			RK3288_CLKSEL_CON(4), 12, 1, MFLAGS,
>  			RK3288_CLKGATE_CON(4), 0, GFLAGS),
>  	GATE(SCLK_I2S0, "sclk_i2s0", "i2s_pre", CLK_SET_RATE_PARENT,
