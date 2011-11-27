From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 27 Nov 2011 08:09:39 +0800
Subject: [PATCH v3 4/5] clk: basic gateable and fixed-rate clks
In-Reply-To: <1321926047-14211-5-git-send-email-mturquette@linaro.org>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
 <1321926047-14211-5-git-send-email-mturquette@linaro.org>
Message-ID: <20111127000938.GE19025@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One comment was missed.

On Mon, Nov 21, 2011 at 05:40:46PM -0800, Mike Turquette wrote:
[...]
> +struct clk_hw_ops clk_hw_gate_set_enable_ops = {

const?

> +	.enable = clk_hw_gate_enable_set,
> +	.disable = clk_hw_gate_disable_clear,
> +	.recalc_rate = clk_hw_gate_recalc_rate,
> +	.get_parent = clk_hw_gate_get_parent,
> +};
> +EXPORT_SYMBOL_GPL(clk_hw_gate_set_enable_ops);
> +
> +static int clk_hw_gate_enable_clear(struct clk *clk)
> +{
> +	clk_hw_gate_clear_bit(clk);
> +
> +	return 0;
> +}
> +
> +static void clk_hw_gate_disable_set(struct clk *clk)
> +{
> +	clk_hw_gate_set_bit(clk);
> +}
> +
> +struct clk_hw_ops clk_hw_gate_set_disable_ops = {

ditto

Regards,
Shawn

> +	.enable = clk_hw_gate_enable_clear,
> +	.disable = clk_hw_gate_disable_set,
> +	.recalc_rate = clk_hw_gate_recalc_rate,
> +	.get_parent = clk_hw_gate_get_parent,
> +};
> +EXPORT_SYMBOL_GPL(clk_hw_gate_set_disable_ops);
