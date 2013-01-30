From: matthieu.castet@parrot.com (Matthieu CASTET)
Date: Wed, 30 Jan 2013 17:54:54 +0100
Subject: [PATCH 4/6] usb: chipidea: add PTW and PTS handling
In-Reply-To: <1359559782-14552-5-git-send-email-s.hauer@pengutronix.de>
References: <1359559782-14552-1-git-send-email-s.hauer@pengutronix.de>
 <1359559782-14552-5-git-send-email-s.hauer@pengutronix.de>
Message-ID: <5109505E.7040204@parrot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index 57cae1f..dcb650f 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -67,6 +67,8 @@
>  #include <linux/usb/gadget.h>
>  #include <linux/usb/otg.h>
>  #include <linux/usb/chipidea.h>
> +#include <linux/usb/of.h>
> +#include <linux/phy.h>
>  
>  #include "ci.h"
>  #include "udc.h"
> @@ -211,6 +213,42 @@ static int hw_device_init(struct ci13xxx *ci, void __iomem *base)
>  	return 0;
>  }
>  
> +static void hw_phymode_configure(struct ci13xxx *ci)
> +{
> +	u32 portsc;
> +
> +	/*
> +	 * The lpm version has the corresponding bits in the devlc register.
> +	 * Currently not implemented.
> +	 */
> +	if (ci->hw_bank.lpm)
> +		return;
Why you don't implement it ?

If you don't implement it, I believe you should add a warning in order to catch
it when used with lpm devices.


Matthieu
