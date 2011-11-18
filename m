From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Nov 2011 13:43:24 -0800
Subject: [PATCH 08/10] arm/tegra: pinmux tables and definitions for tegra30
In-Reply-To: <1321546766-26770-9-git-send-email-pdeschrijver@nvidia.com>
References: <1321546766-26770-1-git-send-email-pdeschrijver@nvidia.com>
 <1321546766-26770-9-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20111118214324.GD31678@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


> @@ -667,7 +710,12 @@ void tegra_pinmux_config_pullupdown_table(const struct tegra_pingroup_config *co
>  }
>  
>  static struct of_device_id tegra_pinmux_of_match[] __devinitdata = {
> +#ifdef CONFIG_ARCH_TEGRA_2x_SOC
>  	{ .compatible = "nvidia,tegra20-pinmux", tegra20_pinmux_init },
> +#endif
> +#ifdef CONFIG_ARCH_TEGRA_3x_SOC
> +	{ .compatible = "nvidia,tegra30-pinmux", tegra30_pinmux_init },
> +#endif

Again, provide empty stubs instead of ifdeffing the table.


-Olof
