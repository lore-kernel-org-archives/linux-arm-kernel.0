From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 23 Sep 2013 12:16:18 -0600
Subject: [PATCH 06/12] clk: tegra: add common infra for DT clocks
In-Reply-To: <1379515331-19427-7-git-send-email-pdeschrijver@nvidia.com>
References: <1379515331-19427-1-git-send-email-pdeschrijver@nvidia.com>
 <1379515331-19427-7-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <52408572.2030907@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2013 08:40 AM, Peter De Schrijver wrote:
> Introduce a common infrastructure for registering DT IDs for tegra clocks and
> sharing clock initialization between SoCs. Move Tegra114 to this new
> infrastructure.

> diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c

> +static struct tegra_clk __initdata tegra114_clks[tegra_clk_max] = {
> +	[tegra_clk_rtc] = { .dt_id = TEGRA114_CLK_RTC, .present = true },
> +	[tegra_clk_timer] = { .dt_id = TEGRA114_CLK_TIMER, .present = true },

It seems rather odd for a patch that adds "common infrastructure" to be
adding a Tegra114-specific table of clock IDs, especially since this new
table isn't actually used at all. I think I would expect a separate
patch for the common infra-structure and the Tegra114-specific table.
Hopefully there will be Tegra20-/30-specific tables added too in that
second patch?
