From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Jan 2017 11:24:26 +0000
Subject: [PATCH v2 2/4] linux/const.h: move UL() macro to
 include/linux/const.h
In-Reply-To: <1483582810-7046-3-git-send-email-yamada.masahiro@socionext.com>
References: <1483582810-7046-1-git-send-email-yamada.masahiro@socionext.com>
 <1483582810-7046-3-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20170105112425.GT14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2017 at 11:20:07AM +0900, Masahiro Yamada wrote:
> ARM, ARM64 and UniCore32 duplicate the definition of UL():
> 
>   #define UL(x) _AC(x, UL)
> 
> This is not actually arch-specific, so it will be useful to move it
> to a common header.  Currently, we only have the uapi variant for
> linux/const.h, so I am creating include/linux/const.h.
> 
> I am also adding _UL(), _ULL() and ULL() because _AC() is mostly
> used in the form either _AC(..., UL) or _AC(..., ULL).  I expect
> they will be replaced in later cleanups.  The underscore-prefixed
> ones should be used for exported headers.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Guan Xuetao <gxt@mprc.pku.edu.cn>
> ---
> 
> Changes in v2: None
> 
>  arch/arm/include/asm/memory.h       | 6 ------
>  arch/arm64/include/asm/memory.h     | 6 ------
>  arch/unicore32/include/asm/memory.h | 6 ------
>  include/linux/const.h               | 9 +++++++++
>  include/uapi/linux/const.h          | 9 ++++++---
>  5 files changed, 15 insertions(+), 21 deletions(-)
>  create mode 100644 include/linux/const.h
> 
> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index 76cbd9c..7558247 100644
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -22,12 +22,6 @@
>  #include <mach/memory.h>
>  #endif
>  
> -/*
> - * Allow for constants defined here to be used from assembly code
> - * by prepending the UL suffix only with actual C code compilation.
> - */
> -#define UL(x) _AC(x, UL)
> -
>  /* PAGE_OFFSET - the virtual address of the start of the kernel image */
>  #define PAGE_OFFSET		UL(CONFIG_PAGE_OFFSET)
>  

For ARM,

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
