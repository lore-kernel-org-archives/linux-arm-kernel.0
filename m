From: mturquette@linaro.org (Mike Turquette)
Date: Sun, 14 Apr 2013 00:03:38 -0700
Subject: [PATCH] clk: vt8500: Missing breaks in
 vtwm_pll_round_rate/_set_rate.
In-Reply-To: <1365917315-3615-1-git-send-email-linux@prisktech.co.nz>
References: <1365917315-3615-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <20130414070338.6507.10991@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Tony Prisk (2013-04-13 22:28:35)
> The case of PLL_TYPE_WM8750 in both these functions is missing a break
> statement causing a fall-through to the default: case.
> 
> Insert the missing break statements.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
> Mike,
> 
> Any chance this can still go in as a fix for 3.9
> The fault makes it impossible to set the PLL clocks on WM8750 and later SoCs.

Definitely not too late for fixes.  Taken into clk-next.

Thanks,
Mike

> 
> Regards
> Tony P
>  drivers/clk/clk-vt8500.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/clk-vt8500.c b/drivers/clk/clk-vt8500.c
> index 09c6331..debf688 100644
> --- a/drivers/clk/clk-vt8500.c
> +++ b/drivers/clk/clk-vt8500.c
> @@ -488,6 +488,7 @@ static int vtwm_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>         case PLL_TYPE_WM8750:
>                 wm8750_find_pll_bits(rate, parent_rate, &filter, &mul, &div1, &div2);
>                 pll_val = WM8750_BITS_TO_VAL(filter, mul, div1, div2);
> +               break;
>         default:
>                 pr_err("%s: invalid pll type\n", __func__);
>                 return 0;
> @@ -523,6 +524,7 @@ static long vtwm_pll_round_rate(struct clk_hw *hw, unsigned long rate,
>         case PLL_TYPE_WM8750:
>                 wm8750_find_pll_bits(rate, *prate, &filter, &mul, &div1, &div2);
>                 round_rate = WM8750_BITS_TO_FREQ(*prate, mul, div1, div2);
> +               break;
>         default:
>                 round_rate = 0;
>         }
> -- 
> 1.7.9.5
