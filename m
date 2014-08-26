From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 26 Aug 2014 17:27:59 +0100
Subject: [PATCH 5/9] arm64: Fix include header order in vmlinux.lds.S
In-Reply-To: <314ef77423f90ed407b54b4658ea41a96b6f6170.1408736066.git.geoff@infradead.org>
References: <cover.1408736066.git.geoff@infradead.org>
 <314ef77423f90ed407b54b4658ea41a96b6f6170.1408736066.git.geoff@infradead.org>
Message-ID: <20140826162759.GG4078@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 22, 2014 at 08:49:16PM +0100, Geoff Levand wrote:
> asm-generic/vmlinux.lds.h should be included after the arch
> specific headers so that the arch headers can override the
> generic macro defs in asm-generic/vmlinux.lds.h.
> 
> Fixes preprosessor redefined warnings when adding arch specific
> macros.

A sample of those warnings would be nice. What do you see being
redefined?

Thanks,
Mark.

> Signed-off-by: Geoff Levand <geoff@infradead.org> for Huawei, Linaro
> ---
>  arch/arm64/kernel/vmlinux.lds.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index fbb1af7..8dc1d46 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -4,10 +4,10 @@
>   * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>
>   */
>  
> -#include <asm-generic/vmlinux.lds.h>
>  #include <asm/thread_info.h>
>  #include <asm/memory.h>
>  #include <asm/page.h>
> +#include <asm-generic/vmlinux.lds.h>
>  
>  #include "image.h"
>  
> -- 
> 1.9.1
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
