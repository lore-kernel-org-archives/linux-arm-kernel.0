From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 25 Jul 2011 09:14:49 -0700
Subject: [PATCH 1/2] ARM: tegra: only select
	MACH_HAS_SND_SOC_TEGRA_WM8903 if SOUND_SOC
In-Reply-To: <1311608874-31863-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1311608874-31863-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF049EBDF52B@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig wrote at Monday, July 25, 2011 9:48 AM:
> This fixes:
> 	warning: (MACH_HARMONY && MACH_KAEN && MACH_SEABOARD) selects MACH_HAS_SND_SOC_TEGRA_WM8903
> which has unmet direct dependencies (SOUND && !M68K && SND && SND_SOC)

> diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
...
>  config MACH_HARMONY
>         bool "Harmony board"
> -       select MACH_HAS_SND_SOC_TEGRA_WM8903
> +       select MACH_HAS_SND_SOC_TEGRA_WM8903 if SOUND_SOC

Shouldn't that be SND_SOC?

-- 
nvpublic
