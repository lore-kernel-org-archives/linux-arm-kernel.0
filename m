From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 6 Oct 2015 11:06:17 -0700
Subject: [PATCH v3 2/4] drivers: clk: st: PLL rate change implementation
 for DVFS
In-Reply-To: <1444032393-13433-3-git-send-email-gabriel.fernandez@linaro.org>
References: <1444032393-13433-1-git-send-email-gabriel.fernandez@linaro.org>
 <1444032393-13433-3-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <20151006180617.GE12338@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/05, Gabriel Fernandez wrote:
> @@ -452,7 +651,7 @@ static const struct clk_ops st_pll1200c32_ops = {
>  static struct clk * __init clkgen_pll_register(const char *parent_name,
>  				struct clkgen_pll_data	*pll_data,
>  				void __iomem *reg,
> -				const char *clk_name)
> +				const char *clk_name, spinlock_t *lock)

Is there a reason we pass lock here but never use it in this
function?

>  {
>  	struct clkgen_pll *pll;
>  	struct clk *clk;

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
