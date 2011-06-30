From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 30 Jun 2011 17:49:39 +0200
Subject: [PATCH] ARM i.MX23/28: platform-mxsfb: Add missing include of
	linux/dma-mapping.h
In-Reply-To: <1309440903.22791.1.camel@phoenix>
References: <1309440903.22791.1.camel@phoenix>
Message-ID: <20110630154939.GN11559@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2011 at 09:35:03PM +0800, Axel Lin wrote:
> Fix below build error:
>   CC      arch/arm/mach-mxs/devices/platform-mxsfb.o
> arch/arm/mach-mxs/devices/platform-mxsfb.c: In function 'mx23_add_mxsfb':
> arch/arm/mach-mxs/devices/platform-mxsfb.c:27: error: implicit declaration of function 'DMA_BIT_MASK'
> make[2]: *** [arch/arm/mach-mxs/devices/platform-mxsfb.o] Error 1
> make[1]: *** [arch/arm/mach-mxs/devices] Error 2
> make: *** [arch/arm/mach-mxs] Error 2
I bisected the problem and it occurs since 

	b7f080c (net: remove mm.h inclusion from netdevice.h)

which is currently in next (pulled in via net-next-2.6).

Tested-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe
 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  arch/arm/mach-mxs/devices/platform-mxsfb.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/devices/platform-mxsfb.c b/arch/arm/mach-mxs/devices/platform-mxsfb.c
> index bf72c9b..5a75b71 100644
> --- a/arch/arm/mach-mxs/devices/platform-mxsfb.c
> +++ b/arch/arm/mach-mxs/devices/platform-mxsfb.c
> @@ -5,6 +5,7 @@
>   * the terms of the GNU General Public License version 2 as published by the
>   * Free Software Foundation.
>   */
> +#include <linux/dma-mapping.h>
>  #include <asm/sizes.h>
>  #include <mach/mx23.h>
>  #include <mach/mx28.h>
> -- 
> 1.7.4.1
> 
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
