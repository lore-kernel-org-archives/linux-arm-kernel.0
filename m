From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 6 Jan 2015 10:40:08 +0000
Subject: [PATCH 3/4] arm64: fix missing asm/alternative.h include in
 kernel/module.c
In-Reply-To: <20150106015215.27249.86394.stgit@dusk.lan>
References: <20150106014554.27249.89116.stgit@dusk.lan>
 <20150106015215.27249.86394.stgit@dusk.lan>
Message-ID: <20150106104008.GD4858@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 06, 2015 at 01:52:20AM +0000, Paul Walmsley wrote:
> On next-20150105, defconfig compilation breaks with:
> 
> arch/arm64/kernel/module.c:408:4: error: implicit declaration of function ?apply_alternatives? [-Werror=implicit-function-declaration]
> 
> Fix by including asm/alternative.h, where the apply_alternatives()
> prototype is declared.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Paul Walmsley <pwalmsley@nvidia.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/module.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
> index fd027b101de5..ac081d6fe184 100644
> --- a/arch/arm64/kernel/module.c
> +++ b/arch/arm64/kernel/module.c
> @@ -27,6 +27,7 @@
>  #include <linux/vmalloc.h>
>  #include <asm/insn.h>
>  #include <asm/sections.h>
> +#include <asm/alternative.h>

If this can move above the include of asm/insn.h:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

>  
>  #define	AARCH64_INSN_IMM_MOVNZ		AARCH64_INSN_IMM_MAX
>  #define	AARCH64_INSN_IMM_MOVK		AARCH64_INSN_IMM_16
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
