From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 6 Jan 2015 10:37:22 +0000
Subject: [PATCH 1/4] arm64: fix missing asm/pgtable-hwdef.h include in
 asm/processor.h
In-Reply-To: <20150106015156.27249.32173.stgit@dusk.lan>
References: <20150106014554.27249.89116.stgit@dusk.lan>
 <20150106015156.27249.32173.stgit@dusk.lan>
Message-ID: <20150106103722.GC4858@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 06, 2015 at 01:52:10AM +0000, Paul Walmsley wrote:
> On next-20150105, defconfig compilation breaks with:
> 
> ./arch/arm64/include/asm/processor.h:47:32: error: ?PHYS_MASK? undeclared (first use in this function)
> 
> Fix by including asm/pgtable-hwdef.h, where PHYS_MASK is defined.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Paul Walmsley <pwalmsley@nvidia.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/processor.h |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index 286b1bec547c..e271690753ff 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -33,6 +33,7 @@
>  #include <asm/hw_breakpoint.h>
>  #include <asm/ptrace.h>
>  #include <asm/types.h>
> +#include <asm/pgtable-hwdef.h>

If you can move this above the include of asm/ptrace.h,

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

>  
>  #ifdef __KERNEL__
>  #define STACK_TOP_MAX		TASK_SIZE_64
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
