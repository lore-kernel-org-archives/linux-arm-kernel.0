From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 17 Dec 2012 11:22:23 +0100
Subject: [PATCH] ARM: imx: Move platform-mx2-emma to
 arch/arm/mach-imx/devices
In-Reply-To: <1353946282-12439-1-git-send-email-fabio.estevam@freescale.com>
References: <1353946282-12439-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20121217102223.GJ26326@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2012 at 02:11:22PM -0200, Fabio Estevam wrote:
> Move platform-mx2-emma to arch/arm/mach-imx/devices and fix the following build
> error:
> 
> make[2]: *** No rule to make target `arch/arm/mach-imx/devices/platform-mx2-emma.o', needed by `arch/arm/mach-imx/devices/built-in.o'.  Stop.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks

Sascha

> ---
>  .../devices/platform-mx2-emma.c                    |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>  rename arch/arm/{plat-mxc => mach-imx}/devices/platform-mx2-emma.c (94%)
> 
> diff --git a/arch/arm/plat-mxc/devices/platform-mx2-emma.c b/arch/arm/mach-imx/devices/platform-mx2-emma.c
> similarity index 94%
> rename from arch/arm/plat-mxc/devices/platform-mx2-emma.c
> rename to arch/arm/mach-imx/devices/platform-mx2-emma.c
> index 508404d..11bd01d 100644
> --- a/arch/arm/plat-mxc/devices/platform-mx2-emma.c
> +++ b/arch/arm/mach-imx/devices/platform-mx2-emma.c
> @@ -6,8 +6,8 @@
>   * the terms of the GNU General Public License version 2 as published by the
>   * Free Software Foundation.
>   */
> -#include <mach/hardware.h>
> -#include <mach/devices-common.h>
> +#include "../hardware.h"
> +#include "devices-common.h"
>  
>  #define imx_mx2_emmaprp_data_entry_single(soc)				\
>  	{								\
> -- 
> 1.7.9.5
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
