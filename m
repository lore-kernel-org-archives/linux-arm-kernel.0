From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 17 Jan 2014 23:18:09 +0100
Subject: [PATCH] ARM: kirkwood: kirkwood_pm_init() should return void
In-Reply-To: <1389984731-20220-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1389984731-20220-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140117221809.GW17530@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 03:52:11PM -0300, Ezequiel Garcia wrote:
> This function was originally meant to return void as declared in the
> common.h header. Fix it and include the header to catch these errors
> in the future.
> 
> Reported-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Acked-by: Andrew Lunn <andrew@lunn.ch>

	  Andrew

> ---
>  arch/arm/mach-kirkwood/pm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-kirkwood/pm.c b/arch/arm/mach-kirkwood/pm.c
> index 8783a71..c11f7f5 100644
> --- a/arch/arm/mach-kirkwood/pm.c
> +++ b/arch/arm/mach-kirkwood/pm.c
> @@ -18,6 +18,7 @@
>  #include <linux/suspend.h>
>  #include <linux/io.h>
>  #include <mach/bridge-regs.h>
> +#include "common.h"
>  
>  static void __iomem *ddr_operation_base;
>  
> @@ -65,7 +66,7 @@ static const struct platform_suspend_ops kirkwood_suspend_ops = {
>  	.valid = kirkwood_pm_valid_standby,
>  };
>  
> -int __init kirkwood_pm_init(void)
> +void __init kirkwood_pm_init(void)
>  {
>  	ddr_operation_base = ioremap(DDR_OPERATION_BASE, 4);
>  	suspend_set_ops(&kirkwood_suspend_ops);
> -- 
> 1.8.1.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
