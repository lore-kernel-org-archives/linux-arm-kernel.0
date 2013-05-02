From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 2 May 2013 14:27:56 +0100
Subject: [PATCH] Move the EM_AARCH64 definition to uapi/linux/elf-em.h
In-Reply-To: <1367495778-6406-1-git-send-email-alonid@stratoscale.com>
References: <1367495778-6406-1-git-send-email-alonid@stratoscale.com>
Message-ID: <20130502132756.GD20730@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 02, 2013 at 12:56:18PM +0100, Dan Aloni wrote:
> Signed-off-by: Dan Aloni <alonid@stratoscale.com>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/include/asm/elf.h |    2 --
>  include/uapi/linux/elf-em.h  |    1 +
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> (fixed the commit message)
> 
> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> index fe32c0e..b3da1c1 100644
> --- a/arch/arm64/include/asm/elf.h
> +++ b/arch/arm64/include/asm/elf.h
> @@ -33,8 +33,6 @@ typedef unsigned long elf_greg_t;
>  typedef elf_greg_t elf_gregset_t[ELF_NGREG];
>  typedef struct user_fpsimd_state elf_fpregset_t;
>  
> -#define EM_AARCH64		183
> -
>  /*
>   * AArch64 static relocation types.
>   */
> diff --git a/include/uapi/linux/elf-em.h b/include/uapi/linux/elf-em.h
> index 8e2b7ba..bc946e9 100644
> --- a/include/uapi/linux/elf-em.h
> +++ b/include/uapi/linux/elf-em.h
> @@ -34,6 +34,7 @@
>  #define EM_MN10300	89	/* Panasonic/MEI MN10300, AM33 */
>  #define EM_BLACKFIN     106     /* ADI Blackfin Processor */
>  #define EM_TI_C6000	140	/* TI C6X DSPs */
> +#define EM_AARCH64	183	/* ARM 64 bit */
>  #define EM_FRV		0x5441	/* Fujitsu FR-V */
>  #define EM_AVR32	0x18ad	/* Atmel AVR32 */

Will you do the same for arch/arm? There is EM_ARM defined under
arch/arm and arch/arm64 (elf.h).

-- 
Catalin
