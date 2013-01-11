From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Fri, 11 Jan 2013 14:17:25 +0200
Subject: [PATCH v4 7/9] clk: tegra: add clock support for tegra30
In-Reply-To: <1357890387-23245-8-git-send-email-pgaikwad@nvidia.com>
References: <1357890387-23245-1-git-send-email-pgaikwad@nvidia.com>
 <1357890387-23245-8-git-send-email-pgaikwad@nvidia.com>
Message-ID: <20130111141725.ce3177ad04fc700186dc694d@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Jan 2013 08:46:25 +0100
Prashant Gaikwad <pgaikwad@nvidia.com> wrote:

> Add tegra30 clock support based on common clock framework.
> 
> Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
.......
> +static void __init tegra30_pll_init(void)
> +{
> +       struct clk *clk;
> +
> +       /* PLLC */
> +       clk = tegra_clk_pll("pll_c", "pll_ref", clk_base, pmc_base, 0,
> +                           0, &pll_c_params,
> +                           TEGRA_PLL_HAS_CPCON | TEGRA_PLL_USE_LOCK,
> +                           pll_c_freq_table, NULL);
> +       clk_register_clkdev(clk, "pll_c", NULL);
> +       clks[pll_c] = clk;

Just I noticed that there are quite many same itegration of:

	clk_register_clkdev(clk, <ID name>, ?);
	clks[<ID>] = clk;

ID == <ID name>

Can any macro/func do the above at once?
