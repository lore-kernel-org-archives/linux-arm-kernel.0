From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Tue, 13 Mar 2018 14:18:45 +0900
Subject: [PATCH] arm: ubsan: select ARCH_HAS_UBSAN_SANITIZE_ALL
In-Reply-To: <20180313045357epcms1p34fb1e2ad09a8288017058c414c21ce26@epcms1p3>
References: <CGME20180313045357epcms1p34fb1e2ad09a8288017058c414c21ce26@epcms1p3>
 <20180313045357epcms1p34fb1e2ad09a8288017058c414c21ce26@epcms1p3>
Message-ID: <4eb795d0-42ce-a8e1-00c5-b779a5fe282c@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2018 01:53 PM, Jinbum Park wrote:
> To enable UBSAN on arm, ARCH_HAS_UBSAN_SANITIZE_ALL is needed to be selected.
> 
> Basic test has passed on Raspberry Pi2, Raspbian jessi lite with
> CONFIG_UBSAN_SANITIZE_ALL, CONFIG_UBSAN_NULL.

This patch had been already sent from Seungwoo.

https://patchwork.kernel.org/patch/9344477/

Best Regards,
Jaehoon Chung

> 
> Signed-off-by: Jinbum Park <jinb.park@samsung.com>
> ---
>  arch/arm/Kconfig                  | 1 +
>  arch/arm/boot/compressed/Makefile | 1 +
>  arch/arm/vdso/Makefile            | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 1878083..bdd1561 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -7,6 +7,7 @@ config ARM
>  	select ARCH_HAS_DEBUG_VIRTUAL if MMU
>  	select ARCH_HAS_DEVMEM_IS_ALLOWED
>  	select ARCH_HAS_ELF_RANDOMIZE
> +	select ARCH_HAS_UBSAN_SANITIZE_ALL
>  	select ARCH_HAS_SET_MEMORY
>  	select ARCH_HAS_PHYS_TO_DMA
>  	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 45a6b9b..1b374ba 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -24,6 +24,7 @@ OBJS		+= hyp-stub.o
>  endif
>  
>  GCOV_PROFILE		:= n
> +UBSAN_SANITIZE		:= n
>  
>  #
>  # Architecture dependencies
> diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
> index bb411821..05597f7 100644
> --- a/arch/arm/vdso/Makefile
> +++ b/arch/arm/vdso/Makefile
> @@ -29,6 +29,7 @@ CFLAGS_vgettimeofday.o = -O2
>  
>  # Disable gcov profiling for VDSO code
>  GCOV_PROFILE := n
> +UBSAN_SANITIZE := n
>  
>  # Force dependency
>  $(obj)/vdso.o : $(obj)/vdso.so
> 
