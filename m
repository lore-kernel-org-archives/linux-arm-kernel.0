From: gxt@mprc.pku.edu.cn (Guan Xuetao)
Date: Wed, 15 Jun 2011 09:24:06 +0800
Subject: [RFC,PATCH] Cleanup PC parallel port Kconfig
In-Reply-To: <20110614190850.GA13526@linux-mips.org>
References: <20110614190850.GA13526@linux-mips.org>
Message-ID: <1308101046.4727.10.camel@epip-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-06-14 at 20:08 +0100, Ralf Baechle wrote:
> The PC parallel port Kconfig as acquired one of those messy terms to
> describe it's architecture dependencies:
> 
>        depends on (!SPARC64 || PCI) && !SPARC32 && !M32R && !FRV && \
>                (!M68K || ISA) && !MN10300 && !AVR32 && !BLACKFIN
> 
> This isn't just ugly - it also almost certainly describes the dependencies
> too coarse grainedly.  This is an attempt at cleaing the mess up.
> 
> I tried to faithfully aproximate the old behaviour but the existing
> behaviour seems inacurate if not wrong for some architectures or platforms.
> To improve on this I rely on comments from other arch and platforms
> maintainers.  Any system that can take PCI multi-IO card or has a PC-style
> parallel port on the mainboard should probably should now do a
> select HAVE_PC_PARPORT.  And some arch Kconfig files should further
> restrict the use of HAVE_PC_PARPORT to only those platforms that actually
> need it.
> 
> Thanks,
> 
>   Ralf

> diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
> index e57dcce..3832e7e 100644
> --- a/arch/unicore32/Kconfig
> +++ b/arch/unicore32/Kconfig
> @@ -8,6 +8,7 @@ config UNICORE32
>  	select HAVE_KERNEL_BZIP2
>  	select HAVE_KERNEL_LZO
>  	select HAVE_KERNEL_LZMA
> +	select HAVE_PC_PARPORT
>  	select GENERIC_FIND_FIRST_BIT
>  	select GENERIC_IRQ_PROBE
>  	select GENERIC_IRQ_SHOW
In UniCore32, only some debug-boards need to support parport.
So I'd like to add HAVE_PC_PARPORT and related configs to certian
*_defconfig, but not in Kconfig.

Thanks Ralf.

Guan Xuetao
