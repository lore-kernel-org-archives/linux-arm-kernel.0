From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 31 Jan 2013 18:01:08 +0800
Subject: [PATCH 2/6] USB: add devicetree helpers for determining
 dr_mode and phy_type
In-Reply-To: <1359622873-23345-3-git-send-email-s.hauer@pengutronix.de>
References: <1359622873-23345-1-git-send-email-s.hauer@pengutronix.de>
 <1359622873-23345-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20130131100107.GD14629@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 10:01:09AM +0100, Sascha Hauer wrote:
> From: Michael Grzeschik <m.grzeschik@pengutronix.de>
> 
> 
> +	for (i = 0; i < ARRAY_SIZE(usb_dr_modes); i++)
> +		if (!strcmp(dr_mode, usb_dr_modes[i]))
> +			return i;

if (strcmp(dr_mode, usb_dr_modes[i]) == 0) may be more friendly.

> +
> +#ifndef __LINUX_USB_OF_H
> +#define __LINUX_USB_OF_H
> +
> +#include <linux/usb/phy.h>
> +
> +#ifdef CONFIG_OF
> +enum usb_phy_interface of_usb_get_phy_mode(struct device_node *np);

Will you put definition to phy.c, I can't find it at this version

> index e8a5fe8..4e8bfbb 100644
> --- a/include/linux/usb/otg.h
> +++ b/include/linux/usb/otg.h
> @@ -99,4 +99,11 @@ otg_start_srp(struct usb_otg *otg)
>  /* for OTG controller drivers (and maybe other stuff) */
>  extern int usb_bus_start_enum(struct usb_bus *bus, unsigned port_num);
>  
> +enum usb_dr_mode {
> +	USB_DR_MODE_UNKNOWN,
> +	USB_DR_MODE_HOST,
> +	USB_DR_MODE_PERIPHERAL,
> +	USB_DR_MODE_OTG,
> +};
> +

I am not sure if otg.h is a good place to put this, in fact, we need
a common header file for it.
-- 

Best Regards,
Peter Chen
