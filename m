From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 03 Dec 2014 17:05:44 -0800
Subject: [PATCH v2 6/8] clk: qcom: Add IPQ806X LPASS clock controller
 (LCC) driver
In-Reply-To: <1416965735-10583-7-git-send-email-sboyd@codeaurora.org>
References: <1416965735-10583-1-git-send-email-sboyd@codeaurora.org>
 <1416965735-10583-7-git-send-email-sboyd@codeaurora.org>
Message-ID: <547FB368.8020003@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25/2014 05:35 PM, Stephen Boyd wrote:
> +
> +static struct clk_regmap_div mi2s_div_clk = {
> +	.reg = 0x48,
> +	.shift = 10,
> +	.width = 4,
> +	.clkr = {
> +		.hw.init = &(struct clk_init_data){
> +			.name = "mi2s_div_clk",
> +			.parent_names = lcc_mi2s_parents,
> +			.num_parents = 1,
> +			.ops = &clk_regmap_div_ops,
> +		},
> +	},
> +};

Oops this is wrong. Let's fold in this patch.

diff --git a/drivers/clk/qcom/lcc-ipq806x.c b/drivers/clk/qcom/lcc-ipq806x.c
index 80a1ecf2fe69..121ffde25dc3 100644
--- a/drivers/clk/qcom/lcc-ipq806x.c
+++ b/drivers/clk/qcom/lcc-ipq806x.c
@@ -188,7 +188,7 @@ static struct clk_branch mi2s_bit_div_clk = {
 		.enable_mask = BIT(15),
 		.hw.init = &(struct clk_init_data){
 			.name = "mi2s_bit_div_clk",
-			.parent_names = lcc_mi2s_parents,
+			.parent_names = (const char *[]){ "mi2s_div_clk" },
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 			.flags = CLK_SET_RATE_PARENT,


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
