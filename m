From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 26 Jul 2011 08:48:08 -0700
Subject: [PATCH v2] ARM: tegra: only select
	MACH_HAS_SND_SOC_TEGRA_WM8903 if SND_SOC
In-Reply-To: <1311668159-11337-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <74CDBE0F657A3D45AFBB94109FB122FF049EBDF52B@HQMAIL01.nvidia.com>
	<1311668159-11337-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF049EBDF7DE@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig wrote at Tuesday, July 26, 2011 2:16 AM:
> This fixes:
> 	warning: (MACH_HARMONY && MACH_KAEN && MACH_SEABOARD) selects MACH_HAS_SND_SOC_TEGRA_WM8903
> which has unmet direct dependencies (SOUND && !M68K && SND && SND_SOC)
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Acked-by: Stephen Warren <swarren@nvidia.com>

(I'm also CC'ing the various maintainers explicitly, so they see the patch,
and can decide which git tree to take this through)

> ---
> Changes since (implicit) v1:
>  - correctly depend on SND_SOC instead of the non-existent SOUND_SOC
>  - fix commit log accordingly
> 
> Thanks to Stephen Warren for noticing.
> 
> Best regards
> Uwe
> 
>  arch/arm/mach-tegra/Kconfig |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
> index 5ec1846..fec64f3 100644
> --- a/arch/arm/mach-tegra/Kconfig
> +++ b/arch/arm/mach-tegra/Kconfig
> @@ -27,14 +27,14 @@ comment "Tegra board type"
> 
>  config MACH_HARMONY
>         bool "Harmony board"
> -       select MACH_HAS_SND_SOC_TEGRA_WM8903
> +       select MACH_HAS_SND_SOC_TEGRA_WM8903 if SND_SOC
>         help
>           Support for nVidia Harmony development platform
> 
>  config MACH_KAEN
>         bool "Kaen board"
>         select MACH_SEABOARD
> -       select MACH_HAS_SND_SOC_TEGRA_WM8903
> +       select MACH_HAS_SND_SOC_TEGRA_WM8903 if SND_SOC
>         help
>           Support for the Kaen version of Seaboard
> 
> @@ -45,7 +45,7 @@ config MACH_PAZ00
> 
>  config MACH_SEABOARD
>         bool "Seaboard board"
> -       select MACH_HAS_SND_SOC_TEGRA_WM8903
> +       select MACH_HAS_SND_SOC_TEGRA_WM8903 if SND_SOC
>         help
>           Support for nVidia Seaboard development platform. It will
>  	 also be included for some of the derivative boards that
> --
> 1.7.5.4

-- 
nvpublic
