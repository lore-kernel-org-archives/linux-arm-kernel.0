From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 05 Jun 2013 09:57:02 -0600
Subject: [PATCH 2/4] clk: tegra: override bits for Tegra114 PLLM
In-Reply-To: <1370441329-8619-3-git-send-email-pdeschrijver@nvidia.com>
References: <1370441329-8619-1-git-send-email-pdeschrijver@nvidia.com>
 <1370441329-8619-3-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <51AF5FCE.6090501@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/2013 08:08 AM, Peter De Schrijver wrote:

Commit description?

> diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c

> +#ifdef CONFIG_PM_SLEEP
> +static struct cpu_clk_suspend_context {
> +	u32 clk_csite_src;
> +} tegra114_cpu_clk_sctx;
> +#endif

That generates:

drivers/clk/tegra/clk-tegra114.c:263:3: warning: ?tegra114_cpu_clk_sctx?
defined but not used [-Wunused-variable]
