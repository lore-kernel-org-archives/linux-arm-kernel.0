From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 23 Sep 2013 12:31:43 -0600
Subject: [PATCH 08/12] clk: tegra: move periph clocks to common file
In-Reply-To: <1379515331-19427-9-git-send-email-pdeschrijver@nvidia.com>
References: <1379515331-19427-1-git-send-email-pdeschrijver@nvidia.com>
 <1379515331-19427-9-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <5240890F.6050807@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2013 08:41 AM, Peter De Schrijver wrote:
> Introduce a new file for peripheral clocks common between several Tegra
> SoCs and move Tegra114 to this new infrastructure. Also PLLP and the PLLP_OUT
> clocks will be initialized here.

> diff --git a/drivers/clk/tegra/clk-tegra-periph.c b/drivers/clk/tegra/clk-tegra-periph.c

Similarly here: don't the following differences exist between the SoCs:

* At least the set of extant peripheral clocks, and perhaps some
parameters of those clocks.

* The set of legal parents for some peripheral clocks (?)

* pll_p frequency table, params, nmp bit positions in registers (?)

I'd really like to see this series completed so it's obvious exactly
what data/code really is common, and hence whether it makes sense to
move everything into a single cross-SoC clk-tegra-periph.c, or whether
some parts should be kept in the per-SoC files.

> diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c

> @@ -2107,9 +1503,10 @@ static void __init tegra114_clock_init(struct device_node *np)
...
>  	tegra114_pmc_clk_init(pmc_base);
> +
>  	tegra114_super_clk_init(clk_base);

Seems superfluous.
