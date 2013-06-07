From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 7 Jun 2013 13:50:29 -0400
Subject: [PATCH] cpuidle: fix ARCH_NEEDS_CPU_IDLE_COUPLED dependency
 warning
In-Reply-To: <1370626856-2876-1-git-send-email-daniel.lezcano@linaro.org>
References: <1370626856-2876-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <51B21D65.3040604@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looping Colin,

On Friday 07 June 2013 01:40 PM, Daniel Lezcano wrote:
> Before the commit d6f346f2d2bf511c2c59176121a6e42ce60173a0, the
> ARCH_NEEDS_CPU_IDLE_COUPLED option was wrongly not depending on the CPU_IDLE
> and the Kconfig for OMAP / TEGRA was not checking this dependency when setting
> the option.
> 
> With this patch, the ARCH_NEEDS_CPU_IDLE_COUPLED has been moved under the
> CPU_IDLE option. The dependency has been fixed in the relevant arch's Kconfig.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-omap2/Kconfig |    2 +-
>  arch/arm/mach-tegra/Kconfig |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index f49cd51..831e89e 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -83,7 +83,7 @@ config ARCH_OMAP4
>  	depends on ARCH_OMAP2PLUS
>  	depends on ARCH_MULTI_V7
>  	select ARCH_HAS_OPP
> -	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
> +	select ARCH_NEEDS_CPU_IDLE_COUPLED if (SMP && CPU_IDLE)
I remember Colin mentioning about above dependency is taken care
already in design [1]

Regards,
Santosh

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-March/092080.html
