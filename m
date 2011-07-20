From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 20 Jul 2011 21:26:22 +0200
Subject: [PATCH 4/7] mx28: add usb host phy functions
In-Reply-To: <1311160106-4898-5-git-send-email-tony.lin@freescale.com>
References: <1311160106-4898-1-git-send-email-tony.lin@freescale.com>
	<1311160106-4898-5-git-send-email-tony.lin@freescale.com>
Message-ID: <20110720192622.GM26347@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2011 at 07:08:23PM +0800, Tony Lin wrote:
> add usb phy register definitions and functions
> usb host driver will use these functions to initialize
> usb phy and change phy working mode
> 
>  
>  obj-y += devices/
> diff --git a/arch/arm/mach-mxs/regs-usbphy-mx28.h b/arch/arm/mach-mxs/regs-usbphy-mx28.h
> new file mode 100644
> index 0000000..a367927
> --- /dev/null
> +++ b/arch/arm/mach-mxs/regs-usbphy-mx28.h
> @@ -0,0 +1,323 @@
> +/*
> + * Freescale USBPHY Register Definitions
> + *
> + * Copyright 2008-2011 Freescale Semiconductor, Inc. All Rights Reserved.
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
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
> + *
> + * This file is created by xml file. Don't Edit it.

Please remove this comment. We can and will change this header if need
arises.

> + *
> + * Xml Revision: 1.52
> + * Template revision: 26195
> + */
> +
> +#ifndef __ARCH_ARM___USBPHY_H
> +#define __ARCH_ARM___USBPHY_H
> +
> +
> +#define HW_USBPHY_PWD	(0x00000000)
> +#define HW_USBPHY_PWD_SET	(0x00000004)
> +#define HW_USBPHY_PWD_CLR	(0x00000008)
> +#define HW_USBPHY_PWD_TOG	(0x0000000c)
> +
> +#define BP_USBPHY_PWD_RSVD2	21
> +#define BM_USBPHY_PWD_RSVD2	0xFFE00000
> +#define BF_USBPHY_PWD_RSVD2(v) \
> +		(((v) << 21) & BM_USBPHY_PWD_RSVD2)
> +#define BM_USBPHY_PWD_RXPWDRX	0x00100000
> +#define BM_USBPHY_PWD_RXPWDDIFF	0x00080000
> +#define BM_USBPHY_PWD_RXPWD1PT1	0x00040000
> +#define BM_USBPHY_PWD_RXPWDENV	0x00020000
> +#define BP_USBPHY_PWD_RSVD1	13
> +#define BM_USBPHY_PWD_RSVD1	0x0001E000
> +#define BF_USBPHY_PWD_RSVD1(v)  \
> +		(((v) << 13) & BM_USBPHY_PWD_RSVD1)

Please remove all these reserved bits. They only reduce readability


> diff --git a/arch/arm/mach-mxs/usb_h1.c b/arch/arm/mach-mxs/usb_h1.c
