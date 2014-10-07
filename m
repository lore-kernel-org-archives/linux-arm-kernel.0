From: dianders@chromium.org (Doug Anderson)
Date: Tue, 7 Oct 2014 09:56:32 -0700
Subject: [PATCH 1/2] clk: rockchip: add 400MHz and 500MHz for rk3288 clock
 rate
In-Reply-To: <1412674438-26160-2-git-send-email-kever.yang@rock-chips.com>
References: <1412674438-26160-1-git-send-email-kever.yang@rock-chips.com>
 <1412674438-26160-2-git-send-email-kever.yang@rock-chips.com>
Message-ID: <CAD=FV=VjgO=4j+5=yC+THE2hWM_zSXhyvo22oHHXOjm98LkaAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kever,

On Tue, Oct 7, 2014 at 2:33 AM, Kever Yang <kever.yang@rock-chips.com> wrote:
> This patch add 400MHz and 500MHz to clock rate table for rk3288.
>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
>
>  drivers/clk/rockchip/clk-rk3288.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
> index d053529..f6ea9c6 100644
> --- a/drivers/clk/rockchip/clk-rk3288.c
> +++ b/drivers/clk/rockchip/clk-rk3288.c
> @@ -86,8 +86,10 @@ struct rockchip_pll_rate_table rk3288_pll_rates[] = {
>         RK3066_PLL_RATE( 594000000, 2, 198, 4),
>         RK3066_PLL_RATE( 552000000, 1, 46, 2),
>         RK3066_PLL_RATE( 504000000, 1, 84, 4),
> +       RK3066_PLL_RATE( 500000000, 3, 125, 2),
>         RK3066_PLL_RATE( 456000000, 1, 76, 4),
>         RK3066_PLL_RATE( 408000000, 1, 68, 4),
> +       RK3066_PLL_RATE( 400000000, 3, 50, 1),

This violates the constraints in the TRM.  That says:

Fvco = (Fin/NR)*NF value range requirement: 440MHz ? 2200MHz

I believe you end up with 400Mhz, not 440.  Are you aware of this?  Is
there some reason it's OK to violate the TRM in this case?

-Doug
