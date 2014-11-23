From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 23 Nov 2014 01:56:27 +0100
Subject: [PATCH] clk: rockchip: fix rk3188 USB HSIC PHY clock divider
In-Reply-To: <1416564527-21327-1-git-send-email-julien.chauveau@neo-technologies.fr>
References: <1416564527-21327-1-git-send-email-julien.chauveau@neo-technologies.fr>
Message-ID: <27247166.7eBDsnluOf@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 21. November 2014, 11:08:47 schrieb Julien CHAUVEAU:
> The USB HSIC PHY clock divider is set in the register RK2928_CLKSEL_CON(11).
> 
> Signed-off-by: Julien CHAUVEAU <julien.chauveau@neo-technologies.fr>

applied to my clk branch for 3.19


Thanks
Heiko

> ---
>  drivers/clk/rockchip/clk-rk3188.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3188.c
> b/drivers/clk/rockchip/clk-rk3188.c index 725d841..f27ea47 100644
> --- a/drivers/clk/rockchip/clk-rk3188.c
> +++ b/drivers/clk/rockchip/clk-rk3188.c
> @@ -664,7 +664,7 @@ static struct rockchip_clk_branch rk3188_clk_branches[]
> __initdata = { RK2928_CLKSEL_CON(30), 0, 2, DFLAGS,
>  			RK2928_CLKGATE_CON(3), 6, GFLAGS),
>  	DIV(0, "sclk_hsicphy_12m", "sclk_hsicphy_480m", 0,
> -			RK2928_CLKGATE_CON(11), 8, 6, DFLAGS),
> +			RK2928_CLKSEL_CON(11), 8, 6, DFLAGS),
> 
>  	MUX(0, "i2s_src", mux_pll_src_gpll_cpll_p, 0,
>  			RK2928_CLKSEL_CON(2), 15, 1, MFLAGS),
