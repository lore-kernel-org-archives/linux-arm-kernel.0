From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 1 Feb 2018 14:58:01 +0530
Subject: [PATCH v6 06/41] clk: davinci: Add platform information for TI
 DM365 PLL
In-Reply-To: <1516468460-4908-7-git-send-email-david@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-7-git-send-email-david@lechnology.com>
Message-ID: <c80a7a0b-4fc8-6255-ce9e-9849d3ab7ac0@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 20 January 2018 10:43 PM, David Lechner wrote:
> +
> +void __init dm365_pll_clk_init(void __iomem *pll1, void __iomem *pll2)
> +{
> +	const struct davinci_pll_sysclk_info *info;
> +
> +	davinci_pll_clk_register(&dm365_pll1_info, "ref_clk", pll1);
> +
> +	davinci_pll_auxclk_register("pll1_auxclk", pll1);
> +
> +	davinci_pll_sysclkbp_clk_register("pll1_sysclkbp", pll1);
> +
> +	davinci_pll_obsclk_register(&dm365_pll1_obsclk_info, pll1);
> +
> +	for (info = dm365_pll1_sysclk_info; info->name; info++)
> +		davinci_pll_sysclk_register(info, pll1);
> +
> +	davinci_pll_clk_register(&dm365_pll2_info, "oscin", pll2);

As pointed out in other patches, I think we can remove "oscin" here and
also get rid of clk_register_fixed_factor() for oscin in
davinci_pll_clk_register().

Rest of the patch looks good to me.

Thanks,
Sekhar
