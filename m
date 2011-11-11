From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 11 Nov 2011 16:43:41 +0800
Subject: [PATCH] Solve compilation problem when using host usb with mx27
 boards
In-Reply-To: <1320921777.46031.YahooMailNeo@web28503.mail.ukl.yahoo.com>
References: <1320921777.46031.YahooMailNeo@web28503.mail.ukl.yahoo.com>
Message-ID: <20111111084339.GH8732@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2011 at 10:42:57AM +0000, Aurelien Bouin wrote:
> Without this patch, when you are compiling the kernel for mx27 mach you will get an include problem...

> Signed-off-by: Aurelien bouin <a_bouin@yahoo.fr>
> ---
>  drivers/usb/host/ehci-mxc.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
> index 0c058be..555a73c 100644
> --- a/drivers/usb/host/ehci-mxc.c
> +++ b/drivers/usb/host/ehci-mxc.c
> @@ -24,6 +24,7 @@
>  #include <linux/usb/ulpi.h>
>  #include <linux/slab.h>
>  
> +#include <mach/hardware.h>
>  #include <mach/mxc_ehci.h>
>  
>  #include <asm/mach-types.h>

What is your base?  This has been fixed on mainline.

-- 
Regards,
Shawn
