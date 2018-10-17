From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 17 Oct 2018 08:39:26 -0700
Subject: [PATCH v13 2/8] clk: qcom: Make clk_alpha_pll_configure available
 to modules
In-Reply-To: <20180614215358.11264-3-ilia.lin@gmail.com>
References: <20180614215358.11264-1-ilia.lin@gmail.com>
 <20180614215358.11264-3-ilia.lin@gmail.com>
Message-ID: <153979076609.5275.11289929616133786271@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting ilia.lin at gmail.com (2018-06-14 14:53:49)
> From: Rajendra Nayak <rnayak@codeaurora.org>
> 
> Allow clk_alpha_pll_configure to be called from loadable
> kernel modules.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> Tested-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---

Oh I think this one came via another patch series. Either way, keep
resending this along with everything else to make kbuild happy.

>  drivers/clk/qcom/clk-alpha-pll.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
> index 3c49a60072f1..a43f80ac94a4 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.c
> +++ b/drivers/clk/qcom/clk-alpha-pll.c
> @@ -228,6 +228,7 @@ void clk_alpha_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
>         if (pll->flags & SUPPORTS_FSM_MODE)
>                 qcom_pll_set_fsm_mode(regmap, PLL_MODE(pll), 6, 0);
>  }
> +EXPORT_SYMBOL_GPL(clk_alpha_pll_configure);
>  
>  static int clk_alpha_pll_hwfsm_enable(struct clk_hw *hw)
>  {
> -- 
> 2.11.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
