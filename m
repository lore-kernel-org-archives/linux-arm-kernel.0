From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 15 Oct 2013 14:21:35 -0600
Subject: [PATCH v2 4/7] clk: tegra124: Add new peripheral clocks
In-Reply-To: <1381850098-12357-5-git-send-email-pdeschrijver@nvidia.com>
References: <1381850098-12357-1-git-send-email-pdeschrijver@nvidia.com>
 <1381850098-12357-5-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <525DA3CF.4020900@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/2013 09:14 AM, Peter De Schrijver wrote:
> Tegra124 introduces a number of new peripheral clocks. This patch adds those
> to the common peripheral clock code.

> diff --git a/drivers/clk/tegra/clk-tegra-periph.c b/drivers/clk/tegra/clk-tegra-periph.c

> @@ -453,6 +501,12 @@ static struct tegra_periph_init_data gate_clks[] = {
>  	GATE("dsib", "dsib_mux", 82, 0, tegra_clk_dsib, 0),
>  	GATE("emc", "emc_mux", 57, 0, tegra_clk_emc, CLK_IGNORE_UNUSED),
>  	GATE("sata_cold", "clk_m", 129, TEGRA_PERIPH_ON_APB, tegra_clk_sata_cold, 0),
> +	GATE("sata_cold", "clk_m", 129, TEGRA_PERIPH_ON_APB, tegra_clk_sata_cold, 0),

That's a duplicate.
