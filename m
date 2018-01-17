From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 17 Jan 2018 20:29:31 +0530
Subject: [PATCH v5 16/44] clk: davinci: Add platform information for TI
 DM646x PSC
In-Reply-To: <1515377863-20358-17-git-send-email-david@lechnology.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
 <1515377863-20358-17-git-send-email-david@lechnology.com>
Message-ID: <000fc63a-bba5-6fac-450b-5ed0f8a9bfea@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 January 2018 07:47 AM, David Lechner wrote:

> +void __init dm646x_psc_clk_init(void __iomem *psc)
> +{
> +	struct clk_onecell_data *clk_data;
> +
> +	clk_data = davinci_psc_register_clocks(psc, dm646x_psc_info, 41);
> +	if (!clk_data)
> +		return;
> +
> +	clk_register_clkdev(clk_data->clks[0], "arm", NULL);

I don't think this "arm" con_id is used any where for non-DA850 SoCs.
And same with "dsp" in other files. Probably best to drop these dubious
usage ones rather than carry them forward.

Thanks,
Sekhar
