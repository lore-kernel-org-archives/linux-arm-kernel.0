From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 10 Apr 2015 19:54:00 +0200
Subject: [PATCH v5 09/11] ARM: vf610: enable Cortex-M4 configuration on
 Vybrid SoC
In-Reply-To: <1428609855-27657-10-git-send-email-stefan@agner.ch>
References: <1428609855-27657-1-git-send-email-stefan@agner.ch>
 <1428609855-27657-10-git-send-email-stefan@agner.ch>
Message-ID: <1428688440.17822.33.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just two whitespace nits. (Please don't tell anyone, I'm a bit
embarrassed that I even spot them, let alone that I comment on them.)

On Thu, 2015-04-09 at 22:04 +0200, Stefan Agner wrote:
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug

> @@ -629,10 +631,26 @@ config SOC_IMX6SX
>  	help
>  	  This enables support for Freescale i.MX6 SoloX processor.
>  
> +

This second empty line is unneeded.

> +config SOC_LS1021A
> +	bool "Freescale LS1021A support"
> +	select ARM_GIC
> +	select HAVE_ARM_ARCH_TIMER
> +	select PCI_DOMAINS if PCI
> +	select ZONE_DMA if ARM_LPAE
> +

Please drop this empty line.

> +	help
> +	  This enable support for Freescale LS1021A processor.
> +
> +endif
> +
> +comment "Cortex-A/Cortex-M asymmetric multiprocessing platforms"
> +
> +if ARCH_MULTI_V7 || ARM_SINGLE_ARMV7M
> +
>  config SOC_VF610
>  	bool "Vybrid Family VF610 support"
> -	select IRQ_DOMAIN_HIERARCHY
> -	select ARM_GIC
> +	select ARM_GIC if ARCH_MULTI_V7
>  	select PINCTRL_VF610
>  	select PL310_ERRATA_769419 if CACHE_L2X0
>  

Thanks,


Paul Bolle
