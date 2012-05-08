From: tony@atomide.com (Tony Lindgren)
Date: Tue, 8 May 2012 09:11:15 -0700
Subject: [PATCH 3/4] ARM: OMAP2+: CLEANUP: Remove unnecessary ifdef
 around __omap2_set_globals
In-Reply-To: <1336489364-19200-4-git-send-email-hvaibhav@ti.com>
References: <1336489364-19200-1-git-send-email-hvaibhav@ti.com>
 <1336489364-19200-4-git-send-email-hvaibhav@ti.com>
Message-ID: <20120508161114.GW5088@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Vaibhav Hiremath <hvaibhav@ti.com> [120508 08:10]:
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -20,12 +20,16 @@ config ARCH_OMAP2PLUS_TYPICAL
>  	help
>  	  Compile a kernel suitable for booting most boards
>  
> +config SOC_HAS_SDRC
> +	bool "SDRAM Controller support"
> +
>  config ARCH_OMAP2
>  	bool "TI OMAP2"
>  	depends on ARCH_OMAP2PLUS
>  	default y
>  	select CPU_V6
>  	select MULTI_IRQ_HANDLER
> +	select SOC_HAS_SDRC
>  
>  config ARCH_OMAP3
>  	bool "TI OMAP3"

These still need to have OMAP in them, and ideally the type
of the block. Something like SOC_HAS_OMAP2_SDRC?

Regards,

Tony
