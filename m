From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 16 Sep 2009 19:25:04 -0400
Subject: [PATCH] Include device.h in VIC driver
In-Reply-To: <1252927430-23866-1-git-send-email-linus.walleij@stericsson.com>
References: <1252927430-23866-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901CBF463@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, September 14, 2009 4:24 AM, Linus Walleij wrote:
>
> Currently build with the next head fails on archs using PL190
> VIC because when we include amba/bus.h we need to include
> device.h first.
> 

The same problem is seen on the ep93xx platform.  This does fix the
issue.

Tested-by: H Hartley Sweeten <hsweeten@visionengravers.com>

> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
>  arch/arm/common/vic.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
> index 920ced0..f232941 100644
> --- a/arch/arm/common/vic.c
> +++ b/arch/arm/common/vic.c
> @@ -22,6 +22,7 @@
>  #include <linux/list.h>
>  #include <linux/io.h>
>  #include <linux/sysdev.h>
> +#include <linux/device.h>
>  #include <linux/amba/bus.h>
>  
>  #include <asm/mach/irq.h>
