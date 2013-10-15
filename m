From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 15 Oct 2013 13:43:03 -0600
Subject: [PATCH v3 19/19] clk: tegra30: move to common tegra clk infra
In-Reply-To: <1381848794-11761-20-git-send-email-pdeschrijver@nvidia.com>
References: <1381848794-11761-1-git-send-email-pdeschrijver@nvidia.com>
 <1381848794-11761-20-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <525D9AC7.5040800@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/2013 08:53 AM, Peter De Schrijver wrote:
> Move tegra30 to the common tegra clks.

Nit: Tegra30 not tegra30. Perhaps the same applies elsewhere?

> diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c

> +static struct tegra_clk tegra30_clks[tegra_clk_max] __initdata = {
> +	[tegra_clk_clk_32k] = { .dt_id = TEGRA30_CLK_CLK_32K, .present = true },
...
> +	[tegra_clk_pll_a_out0] = { .dt_id = TEGRA30_CLK_PLL_A_OUT0, .present = true },
>  
> -static unsigned int tegra30_get_pll_ref_div(void)
...
> -}
> +};

Nit: There's an extra blank line at the end of that table, which makes
the diff look a little odd.
