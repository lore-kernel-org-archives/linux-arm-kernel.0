From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 15 Oct 2013 13:01:43 -0600
Subject: [PATCH v3 08/19] clk: tegra: add common infra for DT clocks
In-Reply-To: <1381848794-11761-9-git-send-email-pdeschrijver@nvidia.com>
References: <1381848794-11761-1-git-send-email-pdeschrijver@nvidia.com>
 <1381848794-11761-9-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <525D9117.9050009@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/2013 08:52 AM, Peter De Schrijver wrote:
> Introduce a common infrastructure for sharing clock initialization between
> SoCs.

> diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c

> +struct clk ** __init tegra_lookup_dt_id(int clk_id,
> +					struct tegra_clk *tegra_clk)
> +{
> +	if (tegra_clk[clk_id].present)
> +		return &clks[tegra_clk[clk_id].dt_id];
> +	else
> +		return NULL;

Does this need range-checking? Or do we assume that since this is an
internal function, "clk_id" will never be out-of-range?
