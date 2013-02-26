From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 26 Feb 2013 09:29:26 -0700
Subject: [PATCH 1/2] ARM: tegra: pmc: add specific compatible DT string
 for Tegra30 and Tegra114
In-Reply-To: <1361872727-4388-1-git-send-email-josephl@nvidia.com>
References: <1361872727-4388-1-git-send-email-josephl@nvidia.com>
Message-ID: <512CE2E6.5020904@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/2013 02:58 AM, Joseph Lo wrote:
> The PMC HW dose not 100% compatible across all Tegra series. We need to
> specify each of them in the DT match table.

> diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c

>  static const struct of_device_id matches[] __initconst = {
>  	{ .compatible = "nvidia,tegra20-pmc" },
> +	{ .compatible = "nvidia,tegra30-pmc" },
> +	{ .compatible = "nvidia,tegra114-pmc" },
>  	{ }
>  };

Those should be listed in order of most recent device through least
recent device, i.e. in the opposite order.
