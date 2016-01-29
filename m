From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 29 Jan 2016 10:21:37 +0100
Subject: [PATCH v2] clk: rockchip: Allow sclk_i2s0 and i2s0_frac to change
 their parents rate on rk3188
In-Reply-To: <1454054282-16303-1-git-send-email-al.kochet@gmail.com>
References: <1453897469-2134-1-git-send-email-al.kochet@gmail.com>
 <1454054282-16303-1-git-send-email-al.kochet@gmail.com>
Message-ID: <3497216.6Y407LhQuk@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

Am Freitag, 29. Januar 2016, 10:58:02 schrieb Alexander Kochetkov:
> Allow sclk_i2s0 and i2s0_frac to change their parents rate as
> that the upstream dividers are purely there to feed sclk_i2s0
> 
> Tested on radxarock-lite.
> 
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
> 
> Changes in v2:
> Rebased on top of 4.5-rc1 of branch[1]
> 
> [1]
> https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git/log
> /?h=v4.6-clk/next

please put these comments (changes in vY, etc) in the "comment section" 
below the "---" in future patches.

I've removed these lines after the Signed-off here and applied the patch to 
my clk branch for 4.6 now.


Thanks
Heiko

> 
> ---
>  drivers/clk/rockchip/clk-rk3188.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3188.c
> b/drivers/clk/rockchip/clk-rk3188.c index cc1d09d..629c65d 100644
> --- a/drivers/clk/rockchip/clk-rk3188.c
> +++ b/drivers/clk/rockchip/clk-rk3188.c
> @@ -666,7 +666,7 @@ PNAME(mux_hsicphy_p)		= { "sclk_otgphy0_480m",
> "sclk_otgphy1_480m", "gpll", "cpll" };
> 
>  static struct rockchip_clk_branch rk3188_i2s0_fracmux __initdata =
> -	MUX(SCLK_I2S0, "sclk_i2s0", mux_sclk_i2s0_p, 0,
> +	MUX(SCLK_I2S0, "sclk_i2s0", mux_sclk_i2s0_p, CLK_SET_RATE_PARENT,
>  			RK2928_CLKSEL_CON(3), 8, 2, MFLAGS);
> 
>  static struct rockchip_clk_branch rk3188_clk_branches[] __initdata = {
> @@ -722,7 +722,7 @@ static struct rockchip_clk_branch
> rk3188_clk_branches[] __initdata = { COMPOSITE_NOMUX(0, "i2s0_pre",
> "i2s_src", 0,
>  			RK2928_CLKSEL_CON(3), 0, 7, DFLAGS,
>  			RK2928_CLKGATE_CON(0), 9, GFLAGS),
> -	COMPOSITE_FRACMUX(0, "i2s0_frac", "i2s0_pre", 0,
> +	COMPOSITE_FRACMUX(0, "i2s0_frac", "i2s0_pre", CLK_SET_RATE_PARENT,
>  			RK2928_CLKSEL_CON(7), 0,
>  			RK2928_CLKGATE_CON(0), 10, GFLAGS,
>  			&rk3188_i2s0_fracmux),
