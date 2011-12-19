From: balbi@ti.com (Felipe Balbi)
Date: Mon, 19 Dec 2011 15:29:24 +0200
Subject: [PATCH 1/7] s3c-hsudc: move platform_data struct to global header
In-Reply-To: <201112191424.24502.heiko@sntech.de>
References: <201112191423.21461.heiko@sntech.de>
 <201112191424.24502.heiko@sntech.de>
Message-ID: <20111219132923.GE3146@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 19, 2011 at 02:24:24PM +0100, Heiko St?bner wrote:
> diff --git a/include/linux/usb/s3c-hsudc.h b/include/linux/usb/s3c-hsudc.h
> new file mode 100644
> index 0000000..6fa1093
> --- /dev/null
> +++ b/include/linux/usb/s3c-hsudc.h
> @@ -0,0 +1,34 @@
> +/*
> + * S3C24XX USB 2.0 High-speed USB controller gadget driver
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * The S3C24XX USB 2.0 high-speed USB controller supports upto 9 endpoints.
> + * Each endpoint can be configured as either in or out endpoint. Endpoints
> + * can be configured for Bulk or Interrupt transfer mode.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#ifndef __LINUX_USB_S3C_HSUDC_H
> +#define __LINUX_USB_S3C_HSUDC_H
> +
> +/**
> + * s3c24xx_hsudc_platdata - Platform data for USB High-Speed gadget controller.
> + * @epnum: Number of endpoints to be instantiated by the controller driver.
> + * @gpio_init: Platform specific USB related GPIO initialization.
> + * @gpio_uninit: Platform specific USB releted GPIO uninitialzation.
> + *
> + * Representation of platform data for the S3C24XX USB 2.0 High Speed gadget
> + * controllers.
> + */
> +struct s3c24xx_hsudc_platdata {
> +	unsigned int	epnum;
> +	void		(*gpio_init)(void);
> +	void		(*gpio_uninit)(void);
> +};
> +
> +#endif	/* __LINUX_USB_S3C_HSUDC_H */

this holds platform_data only, how about
<linux/platform_data/s3c-hsudc.h> ??

other than that, it looks good.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111219/07222b53/attachment.sig>
