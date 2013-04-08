From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Apr 2013 16:27:25 -0700
Subject: [PATCH] ARM: OMAP4: Enable fix for Cortex-A9 erratas
In-Reply-To: <1363876938-31724-1-git-send-email-r.sricharan@ti.com>
References: <1363876938-31724-1-git-send-email-r.sricharan@ti.com>
Message-ID: <20130408232725.GF10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sricharan R <r.sricharan@ti.com> [130321 07:46]:
> This enables the fixes for the below erratas
> applicable for OMAP4 Socs.
> 
> 754322: Faulty MMU translations following ASID switch
> 
> 775420: A data cache maintenance operation which aborts,
>         followed by an ISB, without any DSB in-between,
>         might lead to deadlock
> 
> Signed-off-by: Sricharan R <r.sricharan@ti.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Thanks applying into omap-for-v3.10/soc.

Tony

> ---
>  arch/arm/mach-omap2/Kconfig |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index c3477e7..c4a3f3f 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -73,6 +73,8 @@ config ARCH_OMAP4
>  	select PM_RUNTIME if CPU_IDLE
>  	select USB_ARCH_HAS_EHCI if USB_SUPPORT
>  	select COMMON_CLK
> +	select ARM_ERRATA_754322
> +	select ARM_ERRATA_775420
>  
>  config SOC_OMAP5
>  	bool "TI OMAP5"
> -- 
> 1.7.9.5
> 
