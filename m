From: mcuos.com@gmail.com (Wan ZongShun)
Date: Tue, 8 Jun 2010 14:57:43 +0800
Subject: [PATCH] pxa168 and pxa930 build fix - plat-pxa/pmu.c dependent on
	ARCH_PXA for IRQ_PMU
In-Reply-To: <1275932959-474-1-git-send-email-jic23@cam.ac.uk>
References: <1275932959-474-1-git-send-email-jic23@cam.ac.uk>
Message-ID: <AANLkTilXErDZHWf71e7pwUbt1i66MVrfP_lPisgoBZ0G@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/6/8 Jonathan Cameron <jic23@cam.ac.uk>:
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
> ?Found this build issue whilst browsing kautobuild logs.
> ?There may well be a better fix but until someone with
> ?a board in ARCH_MMP can test it, lets just not build
> ?pmu.c. ?Can't find equivalent fix in Eric's tree so I
> ?think this is still a live problem.
>

When building pxa168 platform, IRQ_PMU cannot be find and error occurs.
Eric, before delete it from MMP, should not we check whether the
performance counter function
is necessary for MMP or not?

If necessary , we should fix this issue by define IRQ_PMU to
IRQ_PXA168_PMU, or we can delete it.

> ?arch/arm/plat-pxa/Makefile | ? ?3 ++-
> ?1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/plat-pxa/Makefile b/arch/arm/plat-pxa/Makefile
> index 6187edf..a17cc0c 100644
> --- a/arch/arm/plat-pxa/Makefile
> +++ b/arch/arm/plat-pxa/Makefile
> @@ -2,8 +2,9 @@
> ?# Makefile for code common across different PXA processor families
> ?#
>
> -obj-y ?:= dma.o pmu.o
> +obj-y ?:= dma.o
>
> +obj-$(CONFIG_ARCH_PXA) ? ? ? ? += pmu.o
> ?obj-$(CONFIG_GENERIC_GPIO) ? ? += gpio.o
> ?obj-$(CONFIG_PXA3xx) ? ? ? ? ? += mfp.o
> ?obj-$(CONFIG_ARCH_MMP) ? ? ? ? += mfp.o
> --
> 1.6.4.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
*linux-arm-kernel mailing list
mail addr:linux-arm-kernel at lists.infradead.org
you can subscribe by:
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

* linux-arm-NUC900 mailing list
mail addr:NUC900 at googlegroups.com
main web: https://groups.google.com/group/NUC900
you can subscribe it by sending me mail:
mcuos.com at gmail.com
