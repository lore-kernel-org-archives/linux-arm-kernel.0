From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Jun 2013 11:05:12 +0200
Subject: [RFC] ARM: Allow use debug_ll_io_init as .map_io in machine
 description
In-Reply-To: <1372221227-20091-1-git-send-email-shc_work@mail.ru>
References: <1372221227-20091-1-git-send-email-shc_work@mail.ru>
Message-ID: <5856677.qmH9YB8W5A@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 June 2013 08:33:47 Alexander Shiyan wrote:
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/include/asm/mach/map.h | 4 +---
>  arch/arm/mm/mmu.c               | 4 ++++
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/include/asm/mach/map.h b/arch/arm/include/asm/mach/map.h
> index 2fe141f..c1fafc5 100644
> --- a/arch/arm/include/asm/mach/map.h
> +++ b/arch/arm/include/asm/mach/map.h
> @@ -42,10 +42,8 @@ extern void vm_reserve_area_early(unsigned long addr, unsigned long size,
>  
>  #ifdef CONFIG_DEBUG_LL
>  extern void debug_ll_addr(unsigned long *paddr, unsigned long *vaddr);
> -extern void debug_ll_io_init(void);
> -#else
> -static inline void debug_ll_io_init(void) {}
>  #endif
> +extern void debug_ll_io_init(void);
>  
>  struct mem_type;

Hi Alexander,

I don't think you need this, since having a NULL .map_io callback means
the same thing. Just remove the reference in your platform code.

	Arnd
