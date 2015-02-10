From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 10 Feb 2015 11:35:01 +0100
Subject: [PATCH] ARM: mm: Remove Kconfig symbol CACHE_PL310
In-Reply-To: <1423562453.5346.18.camel@x220>
References: <1423562453.5346.18.camel@x220>
Message-ID: <54D9DED5.9090700@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 10/02/2015 11:00, Paul Bolle a ?crit :
> Commit 20e783e39e55 ("ARM: 8296/1: cache-l2x0: clean up aurora cache
> handling") removed the only user of the Kconfig symbol CACHE_PL310.
> Setting CACHE_PL310 is now pointless. Remove its Kconfig entry, and one
> select of this symbol.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>

Okay then:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
> Please note that the commit hash is valid for next-20150209. So if the
> tree that this commit is coming from will be rebased, or similar, it
> shouldn't be used.
> 
>  arch/arm/mach-at91/Kconfig | 1 -
>  arch/arm/mm/Kconfig        | 7 -------
>  2 files changed, 8 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index c6740e359a44..c74a44324e5b 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -64,7 +64,6 @@ config SOC_SAMA5D4
>  	select SOC_SAMA5
>  	select CLKSRC_MMIO
>  	select CACHE_L2X0
> -	select CACHE_PL310
>  	select HAVE_FB_ATMEL
>  	select HAVE_AT91_UTMI
>  	select HAVE_AT91_SMD
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index c43c71455566..9b4f29e595a4 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -892,13 +892,6 @@ config CACHE_L2X0
>  
>  if CACHE_L2X0
>  
> -config CACHE_PL310
> -	bool
> -	default y if CPU_V7 && !(CPU_V6 || CPU_V6K)
> -	help
> -	  This option enables optimisations for the PL310 cache
> -	  controller.
> -
>  config PL310_ERRATA_588369
>  	bool "PL310 errata: Clean & Invalidate maintenance operations do not invalidate clean lines"
>  	help
> 


-- 
Nicolas Ferre
