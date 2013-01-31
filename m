From: bp@alien8.de (Borislav Petkov)
Date: Thu, 31 Jan 2013 07:44:35 +0100
Subject: [RFC] arm: use built-in byte swap function
In-Reply-To: <20130130200900.9d7cf7908caeaef4ecee1d61@freescale.com>
References: <20130128193033.8a0b0a871150c99247f05a95@freescale.com>
 <20130129083522.GA14302@pd.tnic>
 <1359478014.3529.157.camel@shinybook.infradead.org>
 <20130129174249.GB25415@pd.tnic>
 <1359482147.3529.161.camel@shinybook.infradead.org>
 <20130129181046.GC25415@pd.tnic>
 <1359541333.3529.186.camel@shinybook.infradead.org>
 <20130130200900.9d7cf7908caeaef4ecee1d61@freescale.com>
Message-ID: <20130131064435.GB4926@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 08:09:00PM -0600, Kim Phillips wrote:
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 40e2b12..c8798b9 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -141,6 +141,16 @@ config ARCH_USE_BUILTIN_BSWAP
>  	 instructions should set this. And it shouldn't hurt to set it
>  	 on architectures that don't have such instructions.
>  
> +config ARCH_DEFINES_BUILTIN_BSWAP
> +       depends on ARCH_USE_BUILTIN_BSWAP
> +       bool
> +       help
> +	 ARCH selects this when it wants to control HAVE_BUILTIN_BSWAPxx

This is what threw me off: if ARCH selects this, I don't think we want
to have a help text and the option be user visible? Normally such
options are only bool and are selected automatically by hm.. ARCH, as
you say above and do so below. :-)

> +	 definitions over those in the generic compiler headers.  It
> +	 can be dependent on a combination of byte swapping instruction
> +	 availability, the instruction set version, and the state
> +	 of support in different compiler versions.
> +
>  config HAVE_SYSCALL_WRAPPERS
>  	bool
>  
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 73027aa..b5868c2 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -57,6 +57,8 @@ config ARM
>  	select CLONE_BACKWARDS
>  	select OLD_SIGSUSPEND3
>  	select OLD_SIGACTION
> +	select ARCH_USE_BUILTIN_BSWAP
> +	select ARCH_DEFINES_BUILTIN_BSWAP
>  	help

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
