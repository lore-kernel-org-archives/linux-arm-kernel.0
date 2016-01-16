From: plaes@plaes.org (Priit Laes)
Date: Sat, 16 Jan 2016 16:08:01 +0200
Subject: [linux-sunxi] [PATCH v2 05/26] clk: sunxi: Add display and
 TCON0 clocks driver
In-Reply-To: <1452785109-6172-6-git-send-email-maxime.ripard@free-electrons.com>
References: <1452785109-6172-1-git-send-email-maxime.ripard@free-electrons.com>
 <1452785109-6172-6-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1452953281.12419.2.camel@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-01-14 at 16:24 +0100, Maxime Ripard wrote:
> The A10 SoCs and its relatives has a special clock controller to drive the
> display engines (both frontend and backend), that have a lot in common with
> the clock to drive the first TCON channel.
> 
> Add a driver to support both.

...

> +static void __init sun4i_a10_display_init(struct device_node *node,
> +					??struct sun4i_a10_display_clk_data *data)
> +{
> +	const char *parents[data->parents];
> +	const char *clk_name = node->name;
> +	struct reset_data *reset_data;
> +	struct clk_divider *div = NULL;
> +	struct clk_gate *gate;
> +	struct clk_mux *mux;
> +	void __iomem *reg;
> +	struct clk *clk;
> +	int i;

warning: unused variable 'i'

> +
> +	of_property_read_string(node, "clock-output-names", &clk_name);
> +
> +	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
> +	if (IS_ERR(reg)) {
> +		pr_err("%s: Could not map the clock registers\n", clk_name);
> +		return;
> +	}

...

Thanks for working on this feature ;)

P?ikest,
Priit Laes
