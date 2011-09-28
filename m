From: tony@atomide.com (Tony Lindgren)
Date: Tue, 27 Sep 2011 18:04:09 -0700
Subject: [PATCH v2 15/16] ARM: omap2plus: convert to
	CONFIG_MULTI_IRQ_HANDLER
In-Reply-To: <1317034955-1029-16-git-send-email-marc.zyngier@arm.com>
References: <1317034955-1029-1-git-send-email-marc.zyngier@arm.com>
	<1317034955-1029-16-git-send-email-marc.zyngier@arm.com>
Message-ID: <20110928010408.GW6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marc Zyngier <marc.zyngier@arm.com> [110926 07:02]:
> Convert the omap2plus platforms to be using CONFIG_MULTI_IRQ_HANDLER.
> Each machine is modified to provide either omap2_intc_handle_irq(),
> omap3_intc_handle_irq() or gic_handle_irq().
> 
> This allows for a major cleanup, removing the MULTI_OMAP setup
> from the interrupt path.
> 
> Tested on both Panda and IGEPv2 (single kernel image)
...

> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -25,6 +25,7 @@ config ARCH_OMAP2
>  	depends on ARCH_OMAP2PLUS
>  	default y
>  	select CPU_V6
> +	select MULTI_IRQ_HANDLER
>  
>  config ARCH_OMAP3
>  	bool "TI OMAP3"

This one selects it only for ARCH_OMAP2, not for ARCH_OMAP2PLUS.

This might require minor merging with the cleanup I've posted, but
that should be trivial.

Other than that:

Tested-by: Tony Lindgren <tony@atomide.com>
