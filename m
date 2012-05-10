From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 10 May 2012 11:23:55 -0600
Subject: [PATCH 1/4] ARM: tegra20: Add Tegra Memory Controller(MC) driver
In-Reply-To: <1336635764-30597-1-git-send-email-hdoyu@nvidia.com>
References: <1336635764-30597-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <4FABF9AB.6020902@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/2012 01:42 AM, Hiroshi DOYU wrote:
> Tegra Memory Controller(MC) driver for Tegra20
> Added to support MC General interrupts, mainly for IOMMU(GART).

Greg, you appear to have been commiting all of drivers/memory. I assume
you'll take patches 1 and 3 in this series, and I will take 2 and 4
through the Tegra tree? I can take them all through the Tegra tree if
you want. Taking the .dts patches through your tree might cause
conflicts in 3.6, since I anticipate some DT-wide cleanup in 3.6.

Hiroshi, one question below (same for patch 3)

> diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig

> @@ -20,6 +20,8 @@ config ARCH_TEGRA_2x_SOC
>  	select PL310_ERRATA_727915 if CACHE_L2X0
>  	select PL310_ERRATA_769419 if CACHE_L2X0
>  	select CPU_FREQ_TABLE if CPU_FREQ
> +	select MEMORY
> +	select TEGRA20_MC

Does ARCH_TEGRA_2x_SOC /have/ to select these?

I'd be inclined to drop the change to mach-tegra/Kconfig. As rationale,
the code works fine without the driver right now. You'd need to make
config TEGRA*_MC user-visible/selectable though.

You could replace this change with a patch to tegra_defconfig which
enables MEMORY and TEGRA*_MC, or perhaps make config TEGRA20_MC default y.

What are people's thoughts here?

Aside from this, the series looks fine to me.
