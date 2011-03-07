From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 7 Mar 2011 09:39:03 -0800
Subject: [PATCH] ARM: tegra: trimslice: enable MMC/SD slots
In-Reply-To: <1299509842-21191-1-git-send-email-mike@compulab.co.il>
References: <1299509842-21191-1-git-send-email-mike@compulab.co.il>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF045687B867@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike Rapoport wrote at Monday, March 07, 2011 7:57 AM:
> TrimSlice has MicroSD and standard MMC/SD slots.
> Register sdhci devices and enable GPIOs for MMC/SD slot.
> 
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> @@ -139,7 +142,13 @@ static __initdata struct tegra_pingroup_config
> trimslice_pinmux[] = {
>  	{TEGRA_PINGROUP_XM2D,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,
> TEGRA_TRI_NORMAL},
>  };
> 
> +static struct tegra_gpio_table gpio_table[] = {
> +	{ .gpio = TEGRA_GPIO_PP1,	.enable = true	}, /* mmc4 cd */
> +	{ .gpio = TEGRA_GPIO_PP2,	.enable = true	}, /* mmc4 wp */
> +};
> +

Not a big deal, but it'd be great if this could use defines that name the
GPIOs, like other boards do now; see Olof's boards-for-next tree for examples
on Harmony and Seaboard.

-- 
nvpublic
