From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 5 Jan 2011 11:04:43 -0600
Subject: [RFC 1/5] ARM: P2V: separate PHYS_OFFSET from platform definitions
In-Reply-To: <E1PaDOb-00023Z-CR@rmk-PC.arm.linux.org.uk>
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
	<E1PaDOb-00023Z-CR@rmk-PC.arm.linux.org.uk>
Message-ID: <0D753D10438DA54287A00B027084269764C3FB5B87@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, January 04, 2011 1:22 PM, Russell King wrote:
> This uncouple PHYS_OFFSET from the platform definitions, thereby
> facilitating run-time computation of the physical memory offset.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> diff --git a/arch/arm/mach-ep93xx/include/mach/memory.h b/arch/arm/mach-ep93xx/include/mach/memory.h
> index 554064e..c9400cf 100644
> --- a/arch/arm/mach-ep93xx/include/mach/memory.h
> +++ b/arch/arm/mach-ep93xx/include/mach/memory.h
> @@ -6,15 +6,15 @@
>  #define __ASM_ARCH_MEMORY_H
>  
>  #if defined(CONFIG_EP93XX_SDCE3_SYNC_PHYS_OFFSET)
> -#define PHYS_OFFSET		UL(0x00000000)
> +#define PLAT_PHYS_OFFSET		UL(0x00000000)
>  #elif defined(CONFIG_EP93XX_SDCE0_PHYS_OFFSET)
> -#define PHYS_OFFSET		UL(0xc0000000)
> +#define PLAT_PHYS_OFFSET		UL(0xc0000000)
>  #elif defined(CONFIG_EP93XX_SDCE1_PHYS_OFFSET)
> -#define PHYS_OFFSET		UL(0xd0000000)
> +#define PLAT_PHYS_OFFSET		UL(0xd0000000)
>  #elif defined(CONFIG_EP93XX_SDCE2_PHYS_OFFSET)
> -#define PHYS_OFFSET		UL(0xe0000000)
> +#define PLAT_PHYS_OFFSET		UL(0xe0000000)
>  #elif defined(CONFIG_EP93XX_SDCE3_ASYNC_PHYS_OFFSET)
> -#define PHYS_OFFSET		UL(0xf0000000)
> +#define PLAT_PHYS_OFFSET		UL(0xf0000000)
>  #else
>  #error "Kconfig bug: No EP93xx PHYS_OFFSET set"
>  #endif

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
