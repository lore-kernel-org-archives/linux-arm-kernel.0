From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 18 Oct 2012 16:43:56 -0600
Subject: [PATCH 3/5] ARM: tegra: fix clock entry of slink controller
In-Reply-To: <1350557795-31487-4-git-send-email-ldewangan@nvidia.com>
References: <1350557795-31487-1-git-send-email-ldewangan@nvidia.com>
 <1350557795-31487-4-git-send-email-ldewangan@nvidia.com>
Message-ID: <5080862C.9030203@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/18/2012 04:56 AM, Laxman Dewangan wrote:
> Fix the driver name, connection name and clock name
> for slink controller clocks in clock table of
> Tegra20 and Tegra30.

The patch subject isn't entirely accurate here; this patch isn't just
about fixing clock entries.

> diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c

> @@ -90,6 +90,10 @@ struct of_dev_auxdata tegra20_auxdata_lookup[] __initdata = {
>  		       &tegra_ehci3_pdata),
>  	OF_DEV_AUXDATA("nvidia,tegra20-apbdma", TEGRA_APB_DMA_BASE, "tegra-apbdma", NULL),
>  	OF_DEV_AUXDATA("nvidia,tegra20-pwm", TEGRA_PWFM_BASE, "tegra-pwm", NULL),
> +	OF_DEV_AUXDATA("nvidia,tegra20-slink", TEGRA_SLINK1_BASE, "spi-tegra-slink.0", NULL),

Here, can't we just use the existing device names in the clock files...

So we can completely drop the changes to these two files:

> diff --git a/arch/arm/mach-tegra/tegra20_clocks_data.c b/arch/arm/mach-tegra/tegra20_clocks_data.c
> diff --git a/arch/arm/mach-tegra/tegra30_clocks_data.c b/arch/arm/mach-tegra/tegra30_clocks_data.c

The device names will hopefully be irrelevant once we're able to use
DT-based clock lookups.
