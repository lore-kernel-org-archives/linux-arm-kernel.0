From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 30 Jan 2013 13:49:27 -0500 (EST)
Subject: [PATCH 1/2] ARM: memory: use SZ_ constants for defining the
 virtual memory layout
In-Reply-To: <1359554912-26872-1-git-send-email-will.deacon@arm.com>
References: <1359554912-26872-1-git-send-email-will.deacon@arm.com>
Message-ID: <alpine.LFD.2.02.1301301348550.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Jan 2013, Will Deacon wrote:

> Parts of the virtual memory layout (mainly the modules area) are
> described using open-coded immediate values.
> 
> Use the SZ_ definitions from linux/sizes.h instead to make the code
> clearer.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/include/asm/memory.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index 73cf03a..a0fd518 100644
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -36,23 +36,23 @@
>   * TASK_UNMAPPED_BASE - the lower boundary of the mmap VM area
>   */
>  #define PAGE_OFFSET		UL(CONFIG_PAGE_OFFSET)
> -#define TASK_SIZE		(UL(CONFIG_PAGE_OFFSET) - UL(0x01000000))
> +#define TASK_SIZE		(UL(CONFIG_PAGE_OFFSET) - UL(SZ_16M))
>  #define TASK_UNMAPPED_BASE	(UL(CONFIG_PAGE_OFFSET) / 3)
>  
>  /*
>   * The maximum size of a 26-bit user space task.
>   */
> -#define TASK_SIZE_26		UL(0x04000000)
> +#define TASK_SIZE_26		UL(SZ_64M)
>  
>  /*
>   * The module space lives between the addresses given by TASK_SIZE
>   * and PAGE_OFFSET - it must be within 32MB of the kernel text.
>   */
>  #ifndef CONFIG_THUMB2_KERNEL
> -#define MODULES_VADDR		(PAGE_OFFSET - 16*1024*1024)
> +#define MODULES_VADDR		(PAGE_OFFSET - SZ_16M)
>  #else
>  /* smaller range for Thumb-2 symbols relocation (2^24)*/
> -#define MODULES_VADDR		(PAGE_OFFSET - 8*1024*1024)
> +#define MODULES_VADDR		(PAGE_OFFSET - SZ_8M)
>  #endif
>  
>  #if TASK_SIZE > MODULES_VADDR
> -- 
> 1.8.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
