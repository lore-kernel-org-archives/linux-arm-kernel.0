From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 27 Jul 2011 10:09:57 +0800
Subject: [PATCH] usb/ehci-mxc: add missing inclusion of mach/hardware.h
In-Reply-To: <1311258250-22013-1-git-send-email-shawn.guo@linaro.org>
References: <1311258250-22013-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110727020951.GF19600@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan,

Linus tree is currently failing on i.mx build because of this.

Regards,
Shawn

On Thu, Jul 21, 2011 at 10:24:10PM +0800, Shawn Guo wrote:
> As cpu_is_mx stuff is being used in the driver, header mach/hardware.h
> should be explicitly included.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> The missing of the header is causing today's linux-next build error
> as bleow.
> 
>   CC      drivers/usb/host/ehci-hcd.o
> In file included from linux-next/drivers/usb/host/ehci-hcd.c:1190:0:
> linux-next/drivers/usb/host/ehci-mxc.c: In function 'ehci_mxc_drv_probe':
> linux-next/drivers/usb/host/ehci-mxc.c:175:2: error: implicit declaration of function 'cpu_is_mx35'
> linux-next/drivers/usb/host/ehci-mxc.c:175:2: error: implicit declaration of function 'cpu_is_mx25'
> linux-next/drivers/usb/host/ehci-mxc.c:185:2: error: implicit declaration of function 'cpu_is_mx51'
> 
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
> -- 
> 1.7.4.1
