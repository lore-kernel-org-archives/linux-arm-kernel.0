From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 17 Jun 2013 21:51:13 +0900
Subject: [PATCHv3 4/5] arm: fix up ARM_ARCH_TIMER selects
In-Reply-To: <1369395370-21358-5-git-send-email-mark.rutland@arm.com>
References: <1369395370-21358-1-git-send-email-mark.rutland@arm.com>
 <1369395370-21358-5-git-send-email-mark.rutland@arm.com>
Message-ID: <1a1501ce6b59$59711e50$0c535af0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Rutland wrote:
> 
> In 8a4da6e: "arm: arch_timer: move core to drivers/clocksource", the
> selection of ARM_ARCH_TIMER was indirected via HAVE_ARM_ARCH_TIMER,
> though mach-exynos's selection of ARM_ARCH_TIMER was missed, and since
> then mach-shmobile, mach-tegra, and mach-virt have begun selecting
> ARM_ARCH_TIMER. This can lead to architected timer support erroneously
> appearing to not be selected in menuconfig.
> 
> This patch fixes up the Kconfigs for those platforms to select
> HAVE_ARM_ARCH_TIMER.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Stephen Warren <swarren@nvidia.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/mach-exynos/Kconfig   | 2 +-
>  arch/arm/mach-shmobile/Kconfig | 4 ++--
>  arch/arm/mach-tegra/Kconfig    | 2 +-
>  arch/arm/mach-virt/Kconfig     | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index d19edff..3c3f36a 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -76,7 +76,7 @@ config SOC_EXYNOS5440
>  	default y
>  	depends on ARCH_EXYNOS5
>  	select ARCH_HAS_OPP
> -	select ARM_ARCH_TIMER
> +	select HAVE_ARM_ARCH_TIMER

Sorry for late response :(

BTW, above should be put after AUTO_ZRELADDR because of alphabetical
ordering...

>  	select AUTO_ZRELADDR
>  	select PINCTRL
>  	select PINCTRL_EXYNOS5440

Others look good to me,

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks,
- Kukjin
