From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 1 Feb 2018 14:47:31 +0530
Subject: [PATCH v6 05/41] clk: davinci: Add platform information for TI
 DM355 PLL
In-Reply-To: <1516468460-4908-6-git-send-email-david@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-6-git-send-email-david@lechnology.com>
Message-ID: <53126e1f-cd75-ea19-ed72-8956adaa1547@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 20 January 2018 10:43 PM, David Lechner wrote:
> +void __init dm355_pll_clk_init(void __iomem *pll1, void __iomem *pll2)
> +{
> +	const struct davinci_pll_sysclk_info *info;
> +
> +	davinci_pll_clk_register(&dm355_pll1_info, "ref_clk", pll1);
> +
> +	for (info = dm355_pll1_sysclk_info; info->name; info++)
> +		davinci_pll_sysclk_register(info, pll1);
> +
> +	davinci_pll_auxclk_register("pll1_auxclk", pll1);
> +
> +	davinci_pll_sysclkbp_clk_register("pll1_sysclkbp", pll1);
> +
> +	davinci_pll_clk_register(&dm355_pll2_info, "oscin", pll2);

Even on DM355, both PLLs accept reference clock from the same input. So
this can be "ref_clk" as well.

Rest of it looks good to me (and thanks for looking up the data manual
for accurate PLLM max and min settings).

Regards,
Sekhar
