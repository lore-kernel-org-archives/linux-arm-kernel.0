From: balbi@ti.com (Felipe Balbi)
Date: Wed, 8 Feb 2012 13:03:18 +0200
Subject: [PATCH 3.3] OMAP4: PRM: fix build breakage when CONFIG_OF is not
 defined
In-Reply-To: <1328698752-18756-1-git-send-email-coelho@ti.com>
References: <1328698752-18756-1-git-send-email-coelho@ti.com>
Message-ID: <20120208110318.GC16334@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2012 at 12:59:12PM +0200, Luciano Coelho wrote:
> Since 3.3-rc1, prm44xx.c build breaks if CONFIG_OF is not set:
> 
> arch/arm/mach-omap2/prm44xx.c:41: error: 'OMAP44XX_IRQ_PRCM' undeclared here (not in a function)
> make[1]: *** [arch/arm/mach-omap2/prm44xx.o] Error 1
> 
> This is because of a missing include, which is added indirectly if
> CONFIG_OF is defined.  This problem was introduced in commit
> 2f31b51659c2d8315ea2888ba5b93076febe672b

same as previous patch. Abbreviated commit and commit subject.

> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Luciano Coelho <coelho@ti.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/mach-omap2/prm44xx.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
> index 33dd655..f2e06ad 100644
> --- a/arch/arm/mach-omap2/prm44xx.c
> +++ b/arch/arm/mach-omap2/prm44xx.c
> @@ -20,6 +20,7 @@
>  #include "common.h"
>  #include <plat/cpu.h>
>  #include <plat/prcm.h>
> +#include <plat/irqs.h>
>  
>  #include "vp.h"
>  #include "prm44xx.h"
> -- 
> 1.7.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120208/7e7e7f0b/attachment.sig>
