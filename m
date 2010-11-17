From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 17 Nov 2010 16:40:47 +0100
Subject: [PATCH v3 15/20] ARM: LPAE: use phys_addr_t instead of unsigned
	long for physical addresses
In-Reply-To: <AANLkTik39iqXsLJiJ7cWwweO2VBoJ0Y4ymwKqx7X5ziA@mail.gmail.com>
References: <1289842829-3027-1-git-send-email-catalin.marinas@arm.com>
	<201011171218.13910.arnd@arndb.de>
	<AANLkTik39iqXsLJiJ7cWwweO2VBoJ0Y4ymwKqx7X5ziA@mail.gmail.com>
Message-ID: <201011171640.47639.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 17 November 2010, Catalin Marinas wrote:
> That's what I plan to add, though it may be better to push as a
> separate patch to fix compiler warnings now. I don't know when the
> LPAE patches would go in.
> 
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -189,7 +189,7 @@
>   * translation for translating DMA addresses.  Use the driver
>   * DMA support - see dma-mapping.h.
>   */
> -static inline phys_addr_t virt_to_phys(void *x)
> +static inline phys_addr_t virt_to_phys(const volatile void *x)
>  {
>         return __virt_to_phys((unsigned long)(x));
>  }

The only impact of this patch is reducing compiler warnings, it should
not add any. Since the patch is correct and independent of the other
changes, it still sounds like a good idea to push it into -next now.

	Arnd
