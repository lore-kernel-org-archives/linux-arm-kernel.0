From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 8 Mar 2012 23:31:56 +0100
Subject: [PATCH v4] USB: Support for LPC32xx SoC
In-Reply-To: <1331244574-32570-1-git-send-email-stigge@antcom.de>
References: <1331244574-32570-1-git-send-email-stigge@antcom.de>
Message-ID: <20120308223155.GA19176@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> --- linux-2.6.orig/drivers/usb/host/ohci-hcd.c
> +++ linux-2.6/drivers/usb/host/ohci-hcd.c
> @@ -1055,6 +1055,11 @@ MODULE_LICENSE ("GPL");
>  #define PLATFORM_DRIVER		usb_hcd_pnx4008_driver
>  #endif
>  
> +#ifdef CONFIG_ARCH_LPC32XX
> +#include "ohci-pnx4008.c"
> +#define PLATFORM_DRIVER		usb_hcd_pnx4008_driver
> +#endif

Can't we just do

#if defined(CONFIG_ARCH_PNX4008) || defined(CONFIG_ARCH_LPC32XX)

to save the duplicate entry?

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120308/5a622cc2/attachment.sig>
