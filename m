From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 27 Nov 2010 16:39:21 +0100
Subject: [PATCH] ARM: Gemini: Add support for PCI Bus
In-Reply-To: <AANLkTinbAVFE+HZrx+9KUwx8=MKFHPqrhpOpAWAEQFv-@mail.gmail.com>
References: <1290263224-16965-1-git-send-email-ulli.kroll@googlemail.com>
	<alpine.LNX.2.00.1011271306420.7659@localhost.localdomain>
	<AANLkTinbAVFE+HZrx+9KUwx8=MKFHPqrhpOpAWAEQFv-@mail.gmail.com>
Message-ID: <201011271639.21694.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 27 November 2010 14:01:20 Micha? Miros?aw wrote:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index db524e7..74ea522 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1164,7 +1164,7 @@ config ISA_DMA_API
>         bool
> 
>  config PCI
> -       bool "PCI support" if ARCH_INTEGRATOR_AP || ARCH_VERSATILE_PB ||
> ARCH_IXP4XX || ARCH_KS8695 || MACH_ARMCORE || ARCH_CNS3XXX
> +       bool "PCI support" if ARCH_INTEGRATOR_AP || ARCH_VERSATILE_PB ||
> ARCH_IXP4XX || ARCH_KS8695 || MACH_ARMCORE || ARCH_CNS3XXX ||
> ARCH_GEMINI
>         help
>           Find out whether you have a PCI motherboard. PCI is the name of a
>           bus system, i.e. the way the CPU talks to the other stuff inside
> 

This approach really does not scale as we add more boards to the list.

Better make a new CONFIG_HAVE_PCI option that you can select from the
individual boards, and make that the only dependency that CONFIG_PCI has.

	Arnd
