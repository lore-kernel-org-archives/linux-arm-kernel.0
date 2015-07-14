From: tony@atomide.com (Tony Lindgren)
Date: Tue, 14 Jul 2015 00:03:17 -0700
Subject: [PATCH] ARM: OMAP2+: Add HAVE_ARM_SCU for AM43XX
In-Reply-To: <1436562348-53396-1-git-send-email-d-gerlach@ti.com>
References: <1436562348-53396-1-git-send-email-d-gerlach@ti.com>
Message-ID: <20150714070317.GG17550@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dave Gerlach <d-gerlach@ti.com> [150710 14:08]:
> CONFIG_HAVE_ARM_SCU only gets selected if CONFIG_SMP is selected in an OMAP
> system, however AM43XX needs this option regardless of CONFIG_SMP and also
> for an AM43XX only build as it is important for controlling power in the SoC.
> Without this we cannot suspend the CPU for SoC suspend or cpuidle. The
> ARM Cortex A9 needs SCU CPU Power Status bits to be set to off mode in order
> for the PRCM to transition the MPU to low power modes.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>  arch/arm/mach-omap2/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index ecc04ff..4a023e8 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -60,6 +60,7 @@ config SOC_AM43XX
>  	select ARM_GIC
>  	select MACH_OMAP_GENERIC
>  	select MIGHT_HAVE_CACHE_L2X0
> +	select HAVE_ARM_SCU
>  
>  config SOC_DRA7XX
>  	bool "TI DRA7XX"

Applying into omap-for-v4.2/fixes thanks.

Tony
