From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 13 Sep 2011 12:03:31 -0700
Subject: [PATCH 04/11] clk: Add simple gated clock
In-Reply-To: <1314191759-16941-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20110824131324.GB16520@opensource.wolfsonmicro.com>
	<1314191759-16941-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1314191759-16941-4-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <4E6FA903.1040407@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24/11 06:15, Mark Brown wrote:
> +static int clk_gate_enable(struct clk_hw *clk)
> +{
> +	struct clk_gate *gate = to_clk_gate(clk);
> +	u32 reg;
> +
> +	reg = __raw_readl(gate->reg);
> +	reg |= 1 << gate->bit_idx;

The BIT() macro might be clearer.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
