From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 16 May 2012 09:00:43 +0800
Subject: [PATCH 4/8] MXS: Add data shared between imx-otg and EHCI driver
In-Reply-To: <1337070219-3630-5-git-send-email-marex@denx.de>
References: <1337070219-3630-1-git-send-email-marex@denx.de>
 <1337070219-3630-5-git-send-email-marex@denx.de>
Message-ID: <20120516010042.GI29393@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 10:23:35AM +0200, Marek Vasut wrote:
> This patch adds common data shared between the MXS EHCI HCD driver,
> the MXS USB Gadget driver and the imx-otg driver. These data allow
> passing clock and memory stuff from imx-otg driver into the
> host/gadget driver.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Chen Peter-B29397 <B29397@freescale.com>
> Cc: Detlev Zundel <dzu@denx.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Li Frank-B20596 <B20596@freescale.com>
> Cc: Linux USB <linux-usb@vger.kernel.org>
> Cc: Liu JunJie-B08287 <B08287@freescale.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Shi Make-B15407 <B15407@freescale.com>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Subodh Nijsure <snijsure@grid-net.com>
> Cc: Wolfgang Denk <wd@denx.de>
> ---
>  include/linux/usb/mxs-usb.h |   39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 include/linux/usb/mxs-usb.h
> 
> diff --git a/include/linux/usb/mxs-usb.h b/include/linux/usb/mxs-usb.h
> new file mode 100644
> index 0000000..2678700
> --- /dev/null
> +++ b/include/linux/usb/mxs-usb.h
> @@ -0,0 +1,39 @@
> +/*
> + * include/linux/usb/mxs-usb.h
> + *
> + * Freescale i.MX USB driver shared data.
> + *
> + * Copyright (C) 2012 Marek Vasut <marex@denx.de>
> + * on behalf of DENX Software Engineering GmbH
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#ifndef __INCLUDE_LINUX_USB_MXS_USB_H__
> +#define __INCLUDE_LINUX_USB_MXS_USB_H__
> +
> +#include <linux/types.h>
> +#include <linux/usb/otg.h>
> +
> +struct mxs_usb_platform_data {
> +	uint32_t		gpio_vbus;
> +	bool			gpio_vbus_inverted;
> +};
hmm..., people don't like platform data. DT?

Thanks
Richard
> +
> +struct mxs_ci13xxx_phy_notify {
> +	bool			discon;
> +};
> +
> +#endif /* __INCLUDE_LINUX_USB_MXS_USB_H__ */
> -- 
> 1.7.10
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
