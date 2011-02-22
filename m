From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 22 Feb 2011 22:51:53 +0300
Subject: [PATCH] ARM: Fix compile after delay page freeing patch
In-Reply-To: <20110222194332.GQ15225@atomide.com>
References: <20110222194332.GQ15225@atomide.com>
Message-ID: <4D6413D9.7080906@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Tony Lindgren wrote:

> Commit 06824ba824b3e9f2fedb38bee79af0643198ed7f
> (ARM: tlb: delay page freeing for SMP and ARMv7 CPUs) causes
> the following compile error for at least omap1_defconfig:

> In file included from arch/arm/mm/init.c:27:
> arch/arm/include/asm/tlb.h: In function 'tlb_flush_mmu':
> arch/arm/include/asm/tlb.h:101: error: implicit declaration of function 'release_pages'
> arch/arm/include/asm/tlb.h: In function 'tlb_remove_page':
> arch/arm/include/asm/tlb.h:165: error: implicit declaration of function 'page_cache_release'
> 
> Fix this by including pagemap.h.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -19,6 +19,7 @@
>  #include <linux/gfp.h>
>  #include <linux/memblock.h>
>  #include <linux/sort.h>
> +#include <linux/pagemap.h>
>  
>  #include <asm/mach-types.h>
>  #include <asm/sections.h>

    Shouldn't you be #including it into tlb.h instead?

WBR, Sergei
