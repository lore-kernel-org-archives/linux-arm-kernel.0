From: jassisinghbrar@gmail.com (jassi brar)
Date: Fri, 20 Nov 2009 23:42:36 +0900
Subject: [PATCH 01/20] ARM: S5PC100: use 0x30008000 as memory base
In-Reply-To: <1258724572-19176-2-git-send-email-m.szyprowski@samsung.com>
References: <1258551194-16018-1-git-send-email-m.szyprowski@samsung.com>
	<1258724572-19176-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1b68c6790911200642j792834e9q47d605b80c2e36d2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2009 at 10:42 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> From: Kyungmin Park <kyungmin.park@samsung.com>
>
> We decided to use 0x3000'0000 as base memory address on S5PC1XX SoCs
> (s5pc100 and s5pc110).
you might as well want to explain the reason behind it, if any?

> A patch to u-boot that configures SMDKC100 board and sets base memory
> as 0x3000'0000 has been already posted.
>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> ?arch/arm/mach-s5pc100/Makefile.boot ? ? ? ? | ? ?4 ++--
> ?arch/arm/mach-s5pc100/include/mach/map.h ? ?| ? ?2 +-
> ?arch/arm/mach-s5pc100/include/mach/memory.h | ? ?2 +-
> ?3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-s5pc100/Makefile.boot b/arch/arm/mach-s5pc100/Makefile.boot
> index ff90aa1..b0909e3 100644
> --- a/arch/arm/mach-s5pc100/Makefile.boot
> +++ b/arch/arm/mach-s5pc100/Makefile.boot
> @@ -1,2 +1,2 @@
> - ? zreladdr-y ?:= 0x20008000
> -params_phys-y ?:= 0x20000100
> + ? zreladdr-y ?:= 0x30008000
> +params_phys-y ?:= 0x30000100
> diff --git a/arch/arm/mach-s5pc100/include/mach/map.h b/arch/arm/mach-s5pc100/include/mach/map.h
> index 4681ebe..f90c033 100644
> --- a/arch/arm/mach-s5pc100/include/mach/map.h
> +++ b/arch/arm/mach-s5pc100/include/mach/map.h
> @@ -113,7 +113,7 @@
> ?#define S5PC100_PA_TSADC ? ? ? (0xF3000000)
>
> ?/* ETC */
> -#define S5PC100_PA_SDRAM ? ? ? (0x20000000)
> +#define S5PC100_PA_SDRAM ? ? ? (0x30000000)
> ?#define S5PC1XX_PA_SDRAM ? ? ? S5PC100_PA_SDRAM
>
> ?/* compatibility defines. */
> diff --git a/arch/arm/mach-s5pc100/include/mach/memory.h b/arch/arm/mach-s5pc100/include/mach/memory.h
> index 4b60d18..21cc182 100644
> --- a/arch/arm/mach-s5pc100/include/mach/memory.h
> +++ b/arch/arm/mach-s5pc100/include/mach/memory.h
> @@ -13,6 +13,6 @@
> ?#ifndef __ASM_ARCH_MEMORY_H
> ?#define __ASM_ARCH_MEMORY_H
>
> -#define PHYS_OFFSET ? ? ? ? ? ?UL(0x20000000)
> +#define PHYS_OFFSET ? ? ? ? ? ?UL(0x30000000)
>
> ?#endif
> --
> 1.6.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
