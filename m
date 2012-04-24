From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Tue, 24 Apr 2012 16:48:14 +0200
Subject: [PATCH 08/11] MXS: Add imx-otg driver
In-Reply-To: <1335237523-9053-9-git-send-email-marex@denx.de>
References: <1335099567-21056-1-git-send-email-marex@denx.de>
 <1335237523-9053-1-git-send-email-marex@denx.de>
 <1335237523-9053-9-git-send-email-marex@denx.de>
Message-ID: <20374.48430.613673.968143@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Marek Vasut writes:
> This driver handles claiming of clocks and memory areas. These are later
> properly delegated to it's child devices, the USB Host (ehci-mxs) and
> USB Gadget (ci13xxx-mxs).
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Chen Peter-B29397 <B29397@freescale.com>
> Cc: Detlev Zundel <dzu@denx.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Li Frank-B20596 <B20596@freescale.com>
> Cc: Lin Tony-B19295 <B19295@freescale.com>
> Cc: Linux USB <linux-usb@vger.kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Subodh Nijsure <snijsure@grid-net.com>
> Cc: Tony Lin <tony.lin@freescale.com>
> Cc: Wolfgang Denk <wd@denx.de>
> ---
>  drivers/usb/otg/Kconfig   |    6 +
>  drivers/usb/otg/Makefile  |    1 +
>  drivers/usb/otg/imx-otg.c |  473 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 480 insertions(+)
>  create mode 100644 drivers/usb/otg/imx-otg.c
> 
> diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
> index 5c87db0..e7c6325 100644
> --- a/drivers/usb/otg/Kconfig
> +++ b/drivers/usb/otg/Kconfig
> @@ -116,6 +116,12 @@ config FSL_USB2_OTG
>  	help
>  	  Enable this to support Freescale USB OTG transceiver.
>  
> +config USB_IMX_COMPOSITE
> +	bool
> +	help
> +	  Composite driver that handles clock and memory mapping for
> +	  i.MX USB host and USB PHY.
> +
>  config USB_MV_OTG
>  	tristate "Marvell USB OTG support"
>  	depends on USB_EHCI_MV && USB_MV_UDC && USB_SUSPEND
> diff --git a/drivers/usb/otg/Makefile b/drivers/usb/otg/Makefile
> index 41aa509..7d2c631 100644
> --- a/drivers/usb/otg/Makefile
> +++ b/drivers/usb/otg/Makefile
> @@ -20,4 +20,5 @@ obj-$(CONFIG_USB_MSM_OTG)	+= msm_otg.o
>  obj-$(CONFIG_AB8500_USB)	+= ab8500-usb.o
>  fsl_usb2_otg-objs		:= fsl_otg.o otg_fsm.o
>  obj-$(CONFIG_FSL_USB2_OTG)	+= fsl_usb2_otg.o
> +obj-$(CONFIG_USB_IMX_COMPOSITE)	+= imx-otg.o
>  obj-$(CONFIG_USB_MV_OTG)	+= mv_otg.o
> diff --git a/drivers/usb/otg/imx-otg.c b/drivers/usb/otg/imx-otg.c
> new file mode 100644
> index 0000000..8440d909
> --- /dev/null
> +++ b/drivers/usb/otg/imx-otg.c
> @@ -0,0 +1,473 @@
> +/*
> + * drivers/usb/otg/imx-otg.c
> + *
> + * Freescale i.MX USB composite driver.
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
Why do you call this driver imx-otg when it is actually MXS specific?
How would you call a corresponding driver for the remaining i.MX
processors?


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
