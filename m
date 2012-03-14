From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 14 Mar 2012 15:59:42 +0800
Subject: [PATCH 4/7] dt/clock: Add handling for fixed clocks and a clock
 node setup iterator
In-Reply-To: <1331680947-29861-5-git-send-email-robherring2@gmail.com>
References: <1331680947-29861-1-git-send-email-robherring2@gmail.com>
 <1331680947-29861-5-git-send-email-robherring2@gmail.com>
Message-ID: <20120314075930.GF21337@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2012 at 06:22:24PM -0500, Rob Herring wrote:
...
> +/**
> + * of_fixed_clk_setup() - Setup function for simple fixed rate clock
> + */
> +void __init of_fixed_clk_setup(struct device_node *node)
> +{
> +	struct clk *clk;
> +	const char *clk_name = node->name;
> +	u32 rate;
> +
> +	if (of_property_read_u32(node, "clock-frequency", &rate))
> +		return;
> +
> +	of_property_read_string(node, "clock-output-names", &clk_name);
> +
> +	clk = clk_register_fixed_rate(NULL, clk_name, NULL, CLK_IS_ROOT, rate);
> +	if (clk)
> +		of_clk_add_provider(node, of_fixed_clk_get, clk);
> +}

It seems my comment[1] did not get addressed in this post.

Regards,
Shawn

[1] http://article.gmane.org/gmane.linux.drivers.devicetree/10589
