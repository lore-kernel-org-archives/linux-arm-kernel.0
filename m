From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 17 Jun 2014 16:22:50 +0100
Subject: [PATCH 05/24] ARM64:UAPI: Set the correct __BITS_PER_LONG for
 ILP32.
In-Reply-To: <1400914939-9708-6-git-send-email-apinski@cavium.com>
References: <1400914939-9708-1-git-send-email-apinski@cavium.com>
 <1400914939-9708-6-git-send-email-apinski@cavium.com>
Message-ID: <20140617152250.GC21752@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 24, 2014 at 12:02:00AM -0700, Andrew Pinski wrote:
> diff --git a/arch/arm64/include/uapi/asm/bitsperlong.h b/arch/arm64/include/uapi/asm/bitsperlong.h
> index fce9c29..5e06c59 100644
> --- a/arch/arm64/include/uapi/asm/bitsperlong.h
> +++ b/arch/arm64/include/uapi/asm/bitsperlong.h
> @@ -16,7 +16,12 @@
>  #ifndef __ASM_BITSPERLONG_H
>  #define __ASM_BITSPERLONG_H
>  
> -#define __BITS_PER_LONG 64
> +/* Assuming __LP64__ will be defined for native ELF64's and not for ILP32. */
> +#ifdef __LP64__
> +# define __BITS_PER_LONG 64
> +#else
> +# define __BITS_PER_LONG 32
> +#endif

I think it's enough to just define it for the __LP64__ case.

>  #include <asm-generic/bitsperlong.h>

The asm-generic definition if 32 by default.

-- 
Catalin
