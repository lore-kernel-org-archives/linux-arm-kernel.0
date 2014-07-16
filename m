From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Jul 2014 16:59:05 +0100
Subject: [PATCH 1/4] asm-generic: Add dma-contiguous.h
In-Reply-To: <1405525892-60383-2-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1405525892-60383-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1405525892-60383-2-git-send-email-Zubair.Kakakhel@imgtec.com>
Message-ID: <20140716155905.GS29414@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 04:51:29PM +0100, Zubair Lutfullah Kakakhel wrote:
> This header is used by arm64 and x86 individually.
> 
> Adding to asm-generic to avoid further code repetition while adding cma
> to mips.
> 
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> ---
>  include/asm-generic/dma-contiguous.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>  create mode 100644 include/asm-generic/dma-contiguous.h
> 
> diff --git a/include/asm-generic/dma-contiguous.h b/include/asm-generic/dma-contiguous.h
> new file mode 100644
> index 0000000..292c571
> --- /dev/null
> +++ b/include/asm-generic/dma-contiguous.h
> @@ -0,0 +1,9 @@
> +#ifndef _ASM_GENERIC_DMA_CONTIGUOUS_H
> +#define _ASM_GENERIC_DMA_CONTIGUOUS_H
> +
> +#include <linux/types.h>
> +
> +static inline void
> +dma_contiguous_early_fixup(phys_addr_t base, unsigned long size) { }
> +
> +#endif

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
