From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 20 Jun 2014 16:21:00 -0400
Subject: [PATCH] ARM: mvebu: rename ARM_ERRATA_753970
In-Reply-To: <1401094871.25902.20.camel@x220>
References: <201404052101.19381.arnd@arndb.de>
 <201404052104.11363.arnd@arndb.de> <1396777049.30640.9.camel@x220>
 <53418889.2050002@free-electrons.com>
 <1396805315.7723.8.camel@x220> <1401094871.25902.20.camel@x220>
Message-ID: <20140620202100.GG21711@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul,

Working through my back-log...

On Mon, May 26, 2014 at 11:01:11AM +0200, Paul Bolle wrote:
> ARM_ERRATA_753970 was renamed to PL310_ERRATA_753970 in v3.2, through
> commit fa0ce4035d48 ("ARM: 7162/1: errata: tidy up Kconfig options for
> PL310 errata workarounds"). Two selects were added in v3.15-rc1 that
> still use the previous name. Rename these.
> 
> Make these statements depend on CACHE_PL310, like all other selects of
> PL310_ERRATA_753970. That way it will only be selected if its dependency
> is met.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> I reported this before v3.15-rc1. I don't know whether any fixes are
> pending. None are in linux-next. 

It looks like rmk just added a patch to fixing the selection of the
erratas.  Could you please take a look and either rebase or drop this
patch?

thx,

Jason.

> And ignoring an errata were one
> apparently could be needed sounds, well, scary. Perhaps it is not.
> Anyhow, to make sure this gets fixed, hopefully before v3.15, I'm
> submitting this (untested!) patch.
> 
> A related observation. There are three PL310 errata options: one depends
> on CACHE_PL310, three depend on CACHE_L2X0. The one depending on
> CACHE_PL310 is selected only if CACHE_PL310 is set.
> 
> But the three depending on CACHE_L2X0 are selected a few times if
> CACHE_L2X0 is set, in other cases if CACHE_PL310 is set, and in some
> cases always. There may be good reasons for this, but it looks odd. I
> know nothing about the PL310 cache and its erratas, so I haven't looked
> into this any further.
> 
>  arch/arm/mach-mvebu/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> index 3f73eecbcfb0..501d0f42e7b2 100644
> --- a/arch/arm/mach-mvebu/Kconfig
> +++ b/arch/arm/mach-mvebu/Kconfig
> @@ -35,7 +35,7 @@ config MACH_ARMADA_370
>  config MACH_ARMADA_375
>  	bool "Marvell Armada 375 boards" if ARCH_MULTI_V7
>  	select ARM_ERRATA_720789
> -	select ARM_ERRATA_753970
> +	select PL310_ERRATA_753970 if CACHE_PL310
>  	select ARM_GIC
>  	select ARMADA_375_CLK
>  	select CPU_V7
> @@ -48,7 +48,7 @@ config MACH_ARMADA_375
>  config MACH_ARMADA_38X
>  	bool "Marvell Armada 380/385 boards" if ARCH_MULTI_V7
>  	select ARM_ERRATA_720789
> -	select ARM_ERRATA_753970
> +	select PL310_ERRATA_753970 if CACHE_PL310
>  	select ARM_GIC
>  	select ARMADA_38X_CLK
>  	select CPU_V7
> -- 
> 1.9.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
