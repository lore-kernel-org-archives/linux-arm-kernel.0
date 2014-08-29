From: varkabhadram@gmail.com (Varka Bhadram)
Date: Fri, 29 Aug 2014 08:57:49 +0530
Subject: [PATCH v4 3/5] ARM: tegra: Initialize interrupt controller from DT
In-Reply-To: <1409239879-12376-3-git-send-email-thierry.reding@gmail.com>
References: <1409239879-12376-1-git-send-email-thierry.reding@gmail.com>
 <1409239879-12376-3-git-send-email-thierry.reding@gmail.com>
Message-ID: <53FFF335.1020402@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/28/2014 09:01 PM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> Obtains the register ranges for the legacy interrupt controller from DT
> and provide hard-coded values as fallback.
>
(...)

> +static const struct tegra_ictlr_soc tegra30_ictlr_soc = {
> +	.num_ictlrs = 5,
> +};
> +
> +static const struct of_device_id ictlr_matches[] = {
> +	{ .compatible = "nvidia,tegra30-ictlr", .data = &tegra30_ictlr_soc },
> +	{ .compatible = "nvidia,tegra20-ictlr", .data = &tegra20_ictlr_soc },
> +	{ }
> +};
> +
> +static const struct of_device_id gic_matches[] = {
> +	{ .compatible = "arm,cortex-a15-gic", },
> +	{ .compatible = "arm,cortex-a9-gic", },
> +	{ }
> +};
> +
>
Missed MODULE_DEVICE_TABLE(of, ...)....?

-- 
Regards,
Varka Bhadram.
