From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 May 2018 13:42:00 +0100
Subject: [PATCH v9 01/12] ARM: Allow this header to be included by
 assembly files
In-Reply-To: <20180504190545.5114-2-mylene.josserand@bootlin.com>
References: <20180504190545.5114-1-mylene.josserand@bootlin.com>
 <20180504190545.5114-2-mylene.josserand@bootlin.com>
Message-ID: <20180508124200.GM16141@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2018 at 09:05:34PM +0200, Myl?ne Josserand wrote:
> From: Doug Berger <opendmb@gmail.com>
> 
> The constants defined in this file are equally useful in assembly and C
> source files. The arm64 architecture version of this file allows
> inclusion in both assembly and C source files, so this this commit adds
> that capability to the arm architecture version so that the constants
> don't need to be defined in multiple places.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks.

> ---
>  arch/arm/include/asm/cputype.h | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
> index cb546425da8a..e7632f536633 100644
> --- a/arch/arm/include/asm/cputype.h
> +++ b/arch/arm/include/asm/cputype.h
> @@ -2,9 +2,6 @@
>  #ifndef __ASM_ARM_CPUTYPE_H
>  #define __ASM_ARM_CPUTYPE_H
>  
> -#include <linux/stringify.h>
> -#include <linux/kernel.h>
> -
>  #define CPUID_ID	0
>  #define CPUID_CACHETYPE	1
>  #define CPUID_TCM	2
> @@ -98,6 +95,11 @@
>  /* Qualcomm implemented cores */
>  #define ARM_CPU_PART_SCORPION		0x510002d0
>  
> +#ifndef __ASSEMBLY__
> +
> +#include <linux/stringify.h>
> +#include <linux/kernel.h>
> +
>  extern unsigned int processor_id;
>  
>  #ifdef CONFIG_CPU_CP15
> @@ -326,4 +328,6 @@ static inline int __attribute_const__ cpuid_feature_extract_field(u32 features,
>  #define cpuid_feature_extract(reg, field) \
>  	cpuid_feature_extract_field(read_cpuid_ext(reg), field)
>  
> +#endif /* __ASSEMBLY__ */
> +
>  #endif
> -- 
> 2.11.0
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
