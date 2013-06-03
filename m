From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Mon, 3 Jun 2013 21:33:19 +0200
Subject: [PATCH RFC 2/3] clk: dt: binding for basic multiplexor clock
In-Reply-To: <1370281990-15090-3-git-send-email-mturquette@linaro.org>
References: <1370281990-15090-1-git-send-email-mturquette@linaro.org>
 <1370281990-15090-3-git-send-email-mturquette@linaro.org>
Message-ID: <201306032133.20039.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

I think it's a multiplexEr clock in the patch title, and see below


Am Montag, 3. Juni 2013, 19:53:09 schrieb Mike Turquette:
> Device Tree binding for the basic clock multiplexor, plus the setup
> function to register the clock.  Based on the existing fixed-clock
> binding.
> 
> Also relocate declaration of of_fixed_factor_clk_setup to keep things
> tidy.
> 
> Signed-off-by: Mike Turquette <mturquette@linaro.org>

[...]

> +
> +	reg = of_iomap(node, 0);
> +	pr_err("%s: reg is 0x%p\n", __func__, reg);
> +
> +	if (of_property_read_u32(node, "mask", &mask)) {
> +		pr_err("%s: missing mask property for %s\n", __func__, node->name);
> +		return;
> +	}
> +
> +	if (of_property_read_u32(node, "shift", &shift))
> +		pr_debug("%s: missing shift property defaults to zero for %s\n",
> +				__func__, node->name);
> +
> +	if (of_property_read_bool(node, "index_one"))
> +		clk_mux_flags |= CLK_MUX_INDEX_ONE;
> +
> +	clk = clk_register_mux_table(NULL, clk_name, parent_names, num_parents,
> +			0, reg, 0, mask, clk_mux_flags,

                      ^- should probably be shift


Otherwise looks cool and I'm currently trying it with my Rockchip code.


Heiko
