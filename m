From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 17 Oct 2013 09:58:41 -0600
Subject: [PATCH v4 00/15] Introduce common infra for tegra clocks
In-Reply-To: <1382013674-12901-1-git-send-email-pdeschrijver@nvidia.com>
References: <1382013674-12901-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <52600931.1020803@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/2013 06:41 AM, Peter De Schrijver wrote:
> This patchset introduces common infrastructure for clocks which exist in
> several Tegra SoCs. We also also move Tegra20, Tegra30 and Tegra114 to
> this new infrastructure.

This series, and the other series "[PATCH v3 0/7] Tegra124 clock support",

Tested-by: Stephen Warren <swarren@nvidia.com>

Patch 1 in this series also (or the whole lot if you want),
Acked-by: Stephen Warren <swarren@nvidia.com>

There are some ifdef issues though, which should be fixed before
actually applying this:

tegra_defconfig builds fine.

tegra_defconfig minus CONFIG_ARCH_TEGRA_114_SOC yields:

> drivers/clk/tegra/clk-pll.c:1734:12: error: ?clk_pll_iddq_enable? undeclared here (not in a function)
> drivers/clk/tegra/clk-pll.c:1735:13: error: ?clk_pll_iddq_disable? undeclared here (not in a function)
> drivers/clk/tegra/clk-pll.c:1737:16: error: ?clk_pll_ramp_round_rate? undeclared here (not in a function)
> drivers/clk/tegra/clk-pll.c:1738:14: error: ?clk_pllxc_set_rate? undeclared here (not in a function)
> drivers/clk/tegra/clk-pll.c: In function ?tegra_clk_register_pllss?:
> drivers/clk/tegra/clk-pll.c:1781:2: error: implicit declaration of function ?_clip_vco_min? [-Werror=implicit-function-declaration]
> drivers/clk/tegra/clk-pll.c:1785:2: error: implicit declaration of function ?_pll_fixed_mdiv? [-Werror=implicit-function-declaration]

(Thanks for Aaron Plattner for pointing that out)

Can you please double-check all 15 valid combinations of
CONFIG_ARCH_TEGRA_xx_SOC to make sure they all build.
