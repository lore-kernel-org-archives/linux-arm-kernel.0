From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 12 Jul 2012 14:20:53 +0200
Subject: [PATCHv11 4/6] i2c: omap: Remove the definition of
 SYSS_RESETDONE_MASK
In-Reply-To: <1340896292-12112-5-git-send-email-shubhrajyoti@ti.com>
References: <1340896292-12112-1-git-send-email-shubhrajyoti@ti.com>
 <1340896292-12112-5-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20120712122053.GD2194@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2012 at 08:41:30PM +0530, Shubhrajyoti D wrote:
> Remove the definition of SYSS_RESETDONE_MASK and use the
> one in omap_hwmod.h.
> 
> Reviewed-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> - Add Felipe's reviewed by tag
> 
>  drivers/i2c/busses/i2c-omap.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 6d05f18..4bbf288 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -43,6 +43,7 @@
>  #include <linux/slab.h>
>  #include <linux/i2c-omap.h>
>  #include <linux/pm_runtime.h>
> +#include <plat/omap_hwmod.h>

Hmmm, so far the driver has no plat/mach dependencies and now this gets
added. Need to think about it a bit more...

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120712/898892f0/attachment.sig>
