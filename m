From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 28 May 2015 15:03:27 -0700
Subject: [PATCHv3 02/27] clk: ti: move generic OMAP DPLL implementation
 under drivers/clk
In-Reply-To: <1432566032-10860-3-git-send-email-t-kristo@ti.com>
References: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
 <1432566032-10860-3-git-send-email-t-kristo@ti.com>
Message-ID: <20150528220327.GF24204@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/25, Tero Kristo wrote:
> @@ -281,7 +282,7 @@ unsigned long omap2_get_dpll_rate(struct clk_hw_omap *clk)
>   * be rounded, or the rounded rate upon success.
>   */
>  long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
> -		unsigned long *parent_rate)
> +			   unsigned long *parent_rate)
>  {
>  	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
>  	int m, n, r, scaled_max_m;
> @@ -310,7 +311,6 @@ long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
>  	dd->last_rounded_rate = 0;
>  
>  	for (n = dd->min_divider; n <= dd->max_divider; n++) {
> -
>  		/* Is the (input clk, divider) pair valid for the DPLL? */
>  		r = _dpll_test_fint(clk, n);
>  		if (r == DPLL_FINT_UNDERFLOW)
> @@ -367,4 +367,3 @@ long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
>  
>  	return dd->last_rounded_rate;
>  }
> -

It's a lot easier to see the cleanup that happened while copying
code over. Thanks.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
