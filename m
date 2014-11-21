From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 20 Nov 2014 18:18:28 -0800
Subject: [PATCH 6/7] clk: qcom: ipq: Add lpass clock controller driver
In-Reply-To: <1416442245-21967-7-git-send-email-sboyd@codeaurora.org>
References: <1416442245-21967-1-git-send-email-sboyd@codeaurora.org>
 <1416442245-21967-7-git-send-email-sboyd@codeaurora.org>
Message-ID: <546EA0F4.10006@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19/2014 04:10 PM, Stephen Boyd wrote:
> +
> +static struct clk_regmap_div mi2s_bit_div_clk = {
> +	.reg = 0x48,
> +	.shift = 10,
> +	.width = 4,
> +	.clkr = {
> +		.enable_reg = 0x48,
> +		.enable_mask = BIT(15),

This also has a halt bit so I'll add that in the next version by
splitting this down further into a divider and a branch.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
