From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 17 Oct 2013 15:52:08 +0300
Subject: [PATCH v4 00/15] Introduce common infra for tegra clocks
In-Reply-To: <1382013674-12901-1-git-send-email-pdeschrijver@nvidia.com>
References: <1382013674-12901-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20131017125207.GT5643@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 17, 2013 at 02:41:13PM +0200, Peter De Schrijver wrote:
> This patchset introduces common infrastructure for clocks which exist in
> several Tegra SoCs. We also also move Tegra20, Tegra30 and Tegra114 to
> this new infrastructure.
> 
> Changes since v1:
> + move common clks allocation to patch 2                                                                                                                       
> + adapt also Tegra20 and Tegra30 to the changes in patch 2                                                                                                     
> 
> Changes since v2:
> + move Tegra20 and Tegra30 to the common infrastructure
> + bug fixes and comments
> + merge clk-tegra-osc.c and clk-tegra-fixed.c in 1 file
> 
> Changes since v3:
> + aggregate all changes for Tegra20 and Tegra30 into 1 file per SoC
> + add CLK_SET_RATE_PARENT for NODIV clocks to fix some warnings on Tegra30
> + rename tegra_clk_periph_banks()
> 
> Peter De Schrijver (15):
>   ARM: tegra30: add missing CLK IDs
>   clk: tegra: simplify periph clock data
>   clk: tegra: common periph_clk_enb_refcnt and clks
>   clk: tegra: Add TEGRA_PERIPH_NO_DIV flag
>   clk: tegra: move some PLLC and PLLXC init to clk-pll.c
>   clk: tegra: move fields to tegra_clk_pll_params
>   clk: tegra: add header for common tegra clock IDs
>   clk: tegra: add common infra for DT clocks
>   clk: tegra: add clkdev registration infra
>   clk: tegra: move audio clk to common file
>   clk: tegra: move periph clocks to common file
>   clk: tegra: move PMC, fixed clocks to common files
>   clk: tegra: introduce common gen4 super clock
>   clk: tegra: move tegra30 to common infra
>   clk: tegra: move tegra20 to common infra
> 

on top of git://nv-tegra.nvidia.com/user/pdeschrijver/linux.git tegra-clk-patches-1
