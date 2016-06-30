From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 30 Jun 2016 10:31:08 +0200
Subject: [PATCH v3 13/14] clk: sunxi-ng: Add H3 clocks
In-Reply-To: <20160629190535.11855-14-maxime.ripard@free-electrons.com>
References: <20160629190535.11855-1-maxime.ripard@free-electrons.com>
 <20160629190535.11855-14-maxime.ripard@free-electrons.com>
Message-ID: <20160630103108.66faa9f392f050de6106d194@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 29 Jun 2016 21:05:34 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> +static void __init sun8i_h3_ccu_setup(struct device_node *node)
> +{
> +	void __iomem *reg;
> +	u32 val;
> +
> +	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
> +	if (IS_ERR(reg)) {
> +		pr_err("%s: Could not map the clock registers\n",
> +		       of_node_full_name(node));
> +		return;
> +	}
> +
> +	/* Force the PLL-Audio-1x divider to 4 */
> +	val = readl(reg + SUN8I_H3_PLL_AUDIO_REG);
> +	val &= ~GENMASK(4, 0);
> +	writel(val | 3, reg + SUN8I_H3_PLL_AUDIO_REG);
> +
> +	sunxi_ccu_probe(node, reg, &sun8i_h3_ccu_desc);
> +}

FYI, the pll-audio PLL_POST_DIV is 19:16.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
