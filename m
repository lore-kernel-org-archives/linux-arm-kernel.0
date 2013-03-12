From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Mar 2013 11:27:50 +0000
Subject: [PATCH 1/7] clk: samsung: add plls used in s3c2416 and s3c2443
In-Reply-To: <201303120142.19842.heiko@sntech.de>
References: <201303120141.31262.heiko@sntech.de>
 <201303120142.19842.heiko@sntech.de>
Message-ID: <20130312112750.GR4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 01:42:19AM +0100, Heiko St?bner wrote:
> +	clk = clk_register(NULL, &pll->hw);
> +	if (IS_ERR(clk)) {
> +		pr_err("%s: failed to register pll clock %s\n", __func__,
> +				name);
> +		kfree(pll);
> +	}
> +
> +	if (clk_register_clkdev(clk, name, NULL))
> +		pr_err("%s: failed to register lookup for %s", __func__, name);

The above looks wrong to me.

> +	clk = clk_register(NULL, &pll->hw);
> +	if (IS_ERR(clk)) {
> +		pr_err("%s: failed to register pll clock %s\n", __func__,
> +				name);
> +		kfree(pll);
> +	}
> +
> +	if (clk_register_clkdev(clk, name, NULL))
> +		pr_err("%s: failed to register lookup for %s", __func__, name);

Same pattern here.

> +	clk = clk_register(NULL, &pll->hw);
> +	if (IS_ERR(clk)) {
> +		pr_err("%s: failed to register pll clock %s\n", __func__,
> +				name);
> +		kfree(pll);
> +	}
> +
> +	if (clk_register_clkdev(clk, name, NULL))
> +		pr_err("%s: failed to register lookup for %s", __func__, name);

And again here.

> +	clk = clk_register(NULL, &pll->hw);
> +	if (IS_ERR(clk)) {
> +		pr_err("%s: failed to register pll clock %s\n", __func__,
> +				name);
> +		kfree(pll);
> +	}
> +
> +	if (clk_register_clkdev(clk, name, NULL))
> +		pr_err("%s: failed to register lookup for %s", __func__, name);

And again here... do you notice something about these?  They're all the
same.  Do you know what we do when we have the same thing repeated and
only the data is different?
