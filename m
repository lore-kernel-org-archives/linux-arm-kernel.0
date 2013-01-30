From: matt@genesi-usa.com (Matt Sealey)
Date: Wed, 30 Jan 2013 14:41:40 -0600
Subject: [PATCH 1/2] ARM: memory: use SZ_ constants for defining the
 virtual memory layout
In-Reply-To: <1359554912-26872-1-git-send-email-will.deacon@arm.com>
References: <1359554912-26872-1-git-send-email-will.deacon@arm.com>
Message-ID: <CAKGA1b=dM3RASMKmGDWue=_A-ieNOyr-Mp_L2LJHVtg8D8m_3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 8:08 AM, Will Deacon <will.deacon@arm.com> wrote:
> Parts of the virtual memory layout (mainly the modules area) are
> described using open-coded immediate values.
>
> Use the SZ_ definitions from linux/sizes.h instead to make the code
> clearer.
>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
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
>  #define PAGE_OFFSET            UL(CONFIG_PAGE_OFFSET)
> -#define TASK_SIZE              (UL(CONFIG_PAGE_OFFSET) - UL(0x01000000))
> +#define TASK_SIZE              (UL(CONFIG_PAGE_OFFSET) - UL(SZ_16M))
>  #define TASK_UNMAPPED_BASE     (UL(CONFIG_PAGE_OFFSET) / 3)
>
>  /*
>   * The maximum size of a 26-bit user space task.
>   */
> -#define TASK_SIZE_26           UL(0x04000000)
> +#define TASK_SIZE_26           UL(SZ_64M)

Wouldn't this make far more sense as UL(1<<26) ?

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
