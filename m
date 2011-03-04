From: robherring2@gmail.com (Rob Herring)
Date: Fri, 04 Mar 2011 08:31:05 -0600
Subject: [PATCH] ARM: fix compile error in tlb.h
In-Reply-To: <1299248663-27130-1-git-send-email-linus.walleij@stericsson.com>
References: <1299248663-27130-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4D70F7A9.3010203@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

On 03/04/2011 08:24 AM, Linus Walleij wrote:
> From: Linus Walleij<linus.walleij@linaro.org>
>
> It seems some of the new tlb handling code merged for 2.6.38-rc7
> use<linux/pagemap.h>  while this is only included for the NON-MMU
> case. This moves the inclusion out of the clause so the kernel
> compiles.
>
> Signed-off-by: Linus Walleij<linus.walleij@linaro.org>
> ---
> Symptom without this patch:
>
> n file included from /home/elinwal/linux-2.6/arch/arm/mm/init.c:27:
> /home/elinwal/linux-2.6/arch/arm/include/asm/tlb.h: In function 'tlb_flush_mmu':
> /home/elinwal/linux-2.6/arch/arm/include/asm/tlb.h:104: error: implicit declaration of function 'release_pages'
> /home/elinwal/linux-2.6/arch/arm/include/asm/tlb.h: In function 'tlb_remove_page':
> /home/elinwal/linux-2.6/arch/arm/include/asm/tlb.h:168: error: implicit declaration of function 'page_cache_release'
> make[3]: *** [arch/arm/mm/init.o] Error 1

There's already a patch in the patch system and Russell's tree for this. 
Perhaps it did not get in due to Russell's machine crashing.

ARM: 6757/1: fix tlb.h induced linux/swap.h build failure

Rob
