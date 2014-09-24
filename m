From: dianders@chromium.org (Doug Anderson)
Date: Wed, 24 Sep 2014 15:51:20 -0700
Subject: [PATCH] clk: rockchip: add missing rk3288 npll rate table
In-Reply-To: <1631893.xHvKLXVMyM@phil>
References: <1631893.xHvKLXVMyM@phil>
Message-ID: <CAD=FV=WCZt5cQ3Z4wWHyqgOh32X-Hztnyzs3-fpXh2nj7ROyfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Wed, Sep 24, 2014 at 2:41 PM, Heiko St?bner <heiko@sntech.de> wrote:
> The npll on rk3288 is exactly the same pll type as the other 4. Yet it
> was missing the link to the rate table, making rate changes impossible.
> Change that by setting the table.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/clk/rockchip/clk-rk3288.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
> index 8ea885b..938d30b 100644
> --- a/drivers/clk/rockchip/clk-rk3288.c
> +++ b/drivers/clk/rockchip/clk-rk3288.c
> @@ -143,7 +143,7 @@ static struct rockchip_pll_clock rk3288_pll_clks[] __initdata = {
>         [gpll] = PLL(pll_rk3066, PLL_GPLL, "gpll", mux_pll_p, 0, RK3288_PLL_CON(12),
>                      RK3288_MODE_CON, 12, 8, rk3288_pll_rates),
>         [npll] = PLL(pll_rk3066, PLL_NPLL, "npll",  mux_pll_p, 0, RK3288_PLL_CON(16),
> -                    RK3288_MODE_CON, 14, 9, NULL),
> +                    RK3288_MODE_CON, 14, 9, rk3288_pll_rates),
>  };

Works for me.  Any reason not to add it to dpll, too?

-Doug
