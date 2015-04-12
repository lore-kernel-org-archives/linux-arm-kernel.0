From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Sun, 12 Apr 2015 17:31:09 +0300
Subject: [PATCH] v4l: omap4iss: Replace outdated OMAP4 control pad API
 with syscon
In-Reply-To: <1428841693-15109-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <3292592.cickJMVhRq@wuerfel>
 <1428841693-15109-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <20150412143109.GP20756@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Sun, Apr 12, 2015 at 03:28:13PM +0300, Laurent Pinchart wrote:
> diff --git a/drivers/staging/media/omap4iss/iss_csiphy.c b/drivers/staging/media/omap4iss/iss_csiphy.c
> index 7c3d55d..748607f 100644
> --- a/drivers/staging/media/omap4iss/iss_csiphy.c
> +++ b/drivers/staging/media/omap4iss/iss_csiphy.c
> @@ -13,6 +13,7 @@
>  
>  #include <linux/delay.h>
>  #include <linux/device.h>
> +#include <linux/regmap.h>
>  
>  #include "../../../../arch/arm/mach-omap2/control.h"
>  
> @@ -140,9 +141,11 @@ int omap4iss_csiphy_config(struct iss_device *iss,
>  	 * - bit [18] : CSIPHY1 CTRLCLK enable
>  	 * - bit [17:16] : CSIPHY1 config: 00 d-phy, 01/10 ccp2
>  	 */
> -	cam_rx_ctrl = omap4_ctrl_pad_readl(
> -			OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_CAMERA_RX);
> -
> +	/*
> +	 * TODO: When implementing DT support specify the CONTROL_CAMERA_RX
> +	 * register offset in the syscon property instead of hardcoding it.
> +	 */
> +	regmap_read(iss->syscon, 0x68, &cam_rx_ctrl);

Do you use platform data now? I guess the address is the same on all SoCs
that use the OMAP 4 ISS?

Acked-by: Sakari Alius <sakari.ailus@iki.fi>

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus at iki.fi	XMPP: sailus at retiisi.org.uk
