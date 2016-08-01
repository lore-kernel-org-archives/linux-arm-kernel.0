From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 01 Aug 2016 21:10:22 +0200
Subject: [RFT PATCH v2 2/3] ARM: Fix *MIGHT_HAVE_PCI* config from being
 selected redundantly
In-Reply-To: <1470049950-4697-3-git-send-email-kishon@ti.com> (Kishon Vijay
 Abraham, I's message of "Mon, 1 Aug 2016 16:42:29 +0530")
References: <1470049950-4697-1-git-send-email-kishon@ti.com>
 <1470049950-4697-3-git-send-email-kishon@ti.com>
Message-ID: <87oa5cxq3l.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kishon Vijay Abraham I <kishon@ti.com> writes:

> *MIGHT_HAVE_PCI* config is already selected in ARCH_MULTIPLATFORM.
> Fix it from getting redundantly selected in all
> ARCH_MULTIPLATFORM based machines.

If that's the purpose, then CM-X255 and CM-X270 don't fall in that category, as
they are not part of ARCH_MULTIPLATFORM nor ready for it AFAIK. So the change
below shouldn't be done according to the commit message.

> diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
> index cd894d6..39f7755 100644
> --- a/arch/arm/mach-pxa/Kconfig
> +++ b/arch/arm/mach-pxa/Kconfig
> @@ -113,7 +113,6 @@ config MACH_ARMCORE
>  	bool "CompuLab CM-X255/CM-X270 modules"
>  	select ARCH_HAS_DMA_SET_COHERENT_MASK if PCI
>  	select IWMMXT
> -	select MIGHT_HAVE_PCI
>  	select NEED_MACH_IO_H if PCI
>  	select PXA25x
>  	select PXA27x

Cheers.

--
Robert
