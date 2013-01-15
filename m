From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 15 Jan 2013 11:10:53 -0700
Subject: [PATCH 4/4] pinctrl/abx500: add AB8500 pinctrl driver
In-Reply-To: <1358242994-5200-1-git-send-email-linus.walleij@stericsson.com>
References: <1358242994-5200-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <50F59BAD.6000609@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/15/2013 02:43 AM, Linus Walleij wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
> 
> This adds a subdriver for the AB8500 pinctrl portions.

> diff --git a/drivers/pinctrl/pinctrl-ab8500.c b/drivers/pinctrl/pinctrl-ab8500.c

> +static struct abx500_pinctrl_soc_data ab8500_ranges_soc = {
> +	.gpio_ranges = ab8500_pinranges,
> +	.gpio_num_ranges = ARRAY_SIZE(ab8500_pinranges),
> +	.pins = ab8500_ranges_pins,
> +	.npins = ARRAY_SIZE(ab8500_ranges_pins),
> +	.functions = ab8500_ranges_functions,
> +	.nfunctions = ARRAY_SIZE(ab8500_ranges_functions),
> +	.groups = ab8500_ranges_groups,
> +	.ngroups = ARRAY_SIZE(ab8500_ranges_groups),
> +	.alternate_functions = ab8500_alternate_functions,
> +	.gpio_irq_cluster = ab8500_gpio_irq_cluster,
> +	.ngpio_irq_cluster = ARRAY_SIZE(ab8500_gpio_irq_cluster),
> +	.irq_gpio_rising_offset = AB8500_INT_GPIO6R,
> +	.irq_gpio_falling_offset = AB8500_INT_GPIO6F,
> +	.irq_gpio_factor = 1,
> +};
> +
> +void __devinit
> +abx500_pinctrl_ab8500_init(struct abx500_pinctrl_soc_data **soc)
> +{
> +	*soc = &ab8500_ranges_soc;
> +}

"ranges" in that variable name seems a little odd since it's much more
than ranges... But otherwise, this patch, very briefly,

Reviewed-by: Stephen Warren <swarren@nvidia.com>
