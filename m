From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 6 Mar 2017 11:03:56 +0000
Subject: [PATCHv3 2/4] ARM: versatile: define empty debug_ll_io_init() for
 no-MMU
In-Reply-To: <1488332385-3367-3-git-send-email-gerg@uclinux.org>
References: <1488332385-3367-1-git-send-email-gerg@uclinux.org>
 <1488332385-3367-3-git-send-email-gerg@uclinux.org>
Message-ID: <05c7cff1-d45f-2589-028a-f1892b11fdd2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/17 01:39, Greg Ungerer wrote:
> No-MMU configured targets have no definition for debug_ll_io_init().
> Not all machines use this and it will only be required if CONFIG_DEBUG_LL
> is enabled.
> 
> But when compiling for a target that uses it and it is configured for
> no-MMU (!CONFIG_MMU), for example the versatile machine, you will get:
> 
>   CC      arch/arm/mach-versatile/versatile_dt.o
> arch/arm/mach-versatile/versatile_dt.c: In function ?versatile_map_io?:
> arch/arm/mach-versatile/versatile_dt.c:283:2: error: implicit declaration of function ?debug_ll_io_init? [-Werror=implicit-function-declaration]
>   debug_ll_io_init();
>   ^
> 
> Fix by adding a macro for it to the !CONFIG_MMU path in map.h.
> 
> Signed-off-by: Greg Ungerer <gerg@uclinux.org>
> ---
>  arch/arm/include/asm/mach/map.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> v2: no change
> v3: rebase on top of linux-4.10
> 
> diff --git a/arch/arm/include/asm/mach/map.h b/arch/arm/include/asm/mach/map.h
> index 9b7c328..b1fe9c8 100644
> --- a/arch/arm/include/asm/mach/map.h
> +++ b/arch/arm/include/asm/mach/map.h
> @@ -62,6 +62,7 @@ extern int ioremap_page(unsigned long virt, unsigned long phys,
>  #else
>  #define iotable_init(map,num)	do { } while (0)
>  #define vm_reserve_area_early(a,s,c)	do { } while (0)
> +#define debug_ll_io_init()	do { } while (0)
>  #endif
>  
>  #endif
> 

I ended up with the similar patch and I'd like to see fix merged, so FWIW

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

Thanks
Vladimir
