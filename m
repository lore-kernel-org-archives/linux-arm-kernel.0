From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 2 Mar 2017 14:11:50 +0000
Subject: [PATCHv2 01/14] treewide: Move set_memory_* functions away from
 cacheflush.h
In-Reply-To: <1488413706-9739-2-git-send-email-labbott@redhat.com>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
 <1488413706-9739-2-git-send-email-labbott@redhat.com>
Message-ID: <20170302141150.GL19632@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 01, 2017 at 04:14:53PM -0800, Laura Abbott wrote:
> diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
> index a12f1af..e419965 100644
> --- a/arch/arm64/include/asm/Kbuild
> +++ b/arch/arm64/include/asm/Kbuild
> @@ -27,6 +27,7 @@ generic-y += preempt.h
>  generic-y += resource.h
>  generic-y += rwsem.h
>  generic-y += segment.h
> +generic-y += set_memory.h
>  generic-y += sembuf.h
>  generic-y += serial.h

Nit: alphabetical order, please.

>  generic-y += shmbuf.h
> diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
> index 5a2a6ee..7db6962 100644
> --- a/arch/arm64/include/asm/cacheflush.h
> +++ b/arch/arm64/include/asm/cacheflush.h
> @@ -20,6 +20,7 @@
>  #define __ASM_CACHEFLUSH_H
>  
>  #include <linux/mm.h>
> +#include <asm/set_memory.h>
>  
>  /*
>   * This flag is used to indicate that the page pointed to by a pte is clean
> @@ -150,9 +151,4 @@ static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
>  {
>  }
>  
> -int set_memory_ro(unsigned long addr, int numpages);
> -int set_memory_rw(unsigned long addr, int numpages);
> -int set_memory_x(unsigned long addr, int numpages);
> -int set_memory_nx(unsigned long addr, int numpages);
> -
>  #endif

> diff --git a/include/asm-generic/set_memory.h b/include/asm-generic/set_memory.h
> new file mode 100644
> index 0000000..83e81f8
> --- /dev/null
> +++ b/include/asm-generic/set_memory.h
> @@ -0,0 +1,12 @@
> +#ifndef __ASM_SET_MEMORY_H
> +#define __ASM_SET_MEMORY_H
> +
> +/*
> + * Functions to change memory attributes.
> + */
> +int set_memory_ro(unsigned long addr, int numpages);
> +int set_memory_rw(unsigned long addr, int numpages);
> +int set_memory_x(unsigned long addr, int numpages);
> +int set_memory_nx(unsigned long addr, int numpages);
> +
> +#endif

Otherwise, this looks fine to me. FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
