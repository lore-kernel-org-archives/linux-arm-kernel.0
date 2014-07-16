From: mina86@mina86.com (Michal Nazarewicz)
Date: Wed, 16 Jul 2014 18:20:49 +0200
Subject: [PATCH 3/4] x86: use generic dma-contiguous.h
In-Reply-To: <1405525892-60383-4-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1405525892-60383-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1405525892-60383-4-git-send-email-Zubair.Kakakhel@imgtec.com>
Message-ID: <xa1ta989b7ha.fsf@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16 2014, Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com> wrote:
> dma-contiguous.h is now in asm-generic. Use that to avoid code
> repetition in x86.
>
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

Acked-by: Michal Nazarewicz <mina86@mina86.com>

But to be honest, I would fold the three into a single commit.

> ---
>  arch/x86/include/asm/Kbuild           |  1 +
>  arch/x86/include/asm/dma-contiguous.h | 12 ------------
>  2 files changed, 1 insertion(+), 12 deletions(-)
>  delete mode 100644 arch/x86/include/asm/dma-contiguous.h
>
> diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
> index 3bf000f..d55a210 100644
> --- a/arch/x86/include/asm/Kbuild
> +++ b/arch/x86/include/asm/Kbuild
> @@ -6,6 +6,7 @@ genhdr-y += unistd_x32.h
>  
>  generic-y += clkdev.h
>  generic-y += cputime.h
> +generic-y += dma-contiguous.h
>  generic-y += early_ioremap.h
>  generic-y += mcs_spinlock.h
>  generic-y += scatterlist.h
> diff --git a/arch/x86/include/asm/dma-contiguous.h b/arch/x86/include/asm/dma-contiguous.h
> deleted file mode 100644
> index b4b38ba..0000000
> --- a/arch/x86/include/asm/dma-contiguous.h
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -#ifndef ASMX86_DMA_CONTIGUOUS_H
> -#define ASMX86_DMA_CONTIGUOUS_H
> -
> -#ifdef __KERNEL__
> -
> -#include <linux/types.h>
> -
> -static inline void
> -dma_contiguous_early_fixup(phys_addr_t base, unsigned long size) { }
> -
> -#endif
> -#endif
> -- 
> 1.9.1
>

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
