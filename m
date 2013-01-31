From: kishon@ti.com (kishon)
Date: Thu, 31 Jan 2013 14:42:48 +0530
Subject: [PATCH 2/6] USB: add devicetree helpers for determining dr_mode
 and phy_type
In-Reply-To: <1359622873-23345-3-git-send-email-s.hauer@pengutronix.de>
References: <1359622873-23345-1-git-send-email-s.hauer@pengutronix.de>
 <1359622873-23345-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <510A3590.2090309@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday 31 January 2013 02:31 PM, Sascha Hauer wrote:
> From: Michael Grzeschik <m.grzeschik@pengutronix.de>
>
> This adds two little devicetree helper functions for determining the
> dr_mode (host, peripheral, otg) and phy_type (utmi, ulpi,...) from
> the devicetree.
>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>   drivers/usb/phy/Makefile |    1 +
>   drivers/usb/phy/phy.c    |   10 ++++++++++
>   drivers/usb/usb-common.c |   36 ++++++++++++++++++++++++++++++++++++
>   include/linux/usb/of.h   |   27 +++++++++++++++++++++++++++
>   include/linux/usb/otg.h  |    7 +++++++
>   include/linux/usb/phy.h  |    9 +++++++++
>   6 files changed, 90 insertions(+)
>   create mode 100644 include/linux/usb/of.h
>
> diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
> index 9fa6327..e1be1e8 100644
> --- a/drivers/usb/phy/Makefile
> +++ b/drivers/usb/phy/Makefile
> @@ -5,6 +5,7 @@
>   ccflags-$(CONFIG_USB_DEBUG) := -DDEBUG
>
>   obj-$(CONFIG_USB_OTG_UTILS)		+= phy.o
> +obj-$(CONFIG_OF)			+= of.o

You've missed doing "git add ..usb/phy/of.c".

>   obj-$(CONFIG_OMAP_USB2)			+= omap-usb2.o
>   obj-$(CONFIG_OMAP_USB3)			+= omap-usb3.o
>   obj-$(CONFIG_OMAP_CONTROL_USB)		+= omap-control-usb.o
> diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
> index ef35eb0..3ad4b5c 100644
> --- a/drivers/usb/phy/phy.c
> +++ b/drivers/usb/phy/phy.c
> @@ -1,3 +1,13 @@
> +/*
> + * phy.c -- USB phy handling
> + *
> + * Copyright (C) 2004 Texas Instruments

it's 2013 already :-P
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.

But your *MODULE_LICENSE("GPL")* below tells it's only GPL.
> + */
.
.
<snip>
.
.

>   MODULE_LICENSE("GPL");

Thanks
Kishon
