From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 15 Oct 2018 09:06:48 +0200
Subject: [PATCH V2 2/2] pinctrl: imx: add imx8qxp driver
In-Reply-To: <1539437252-20603-3-git-send-email-aisheng.dong@nxp.com>
References: <1539437252-20603-1-git-send-email-aisheng.dong@nxp.com>
 <1539437252-20603-3-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20181015070648.7ss65nv7ozrsypj2@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 13, 2018 at 01:32:12PM +0000, A.s. Dong wrote:
> MX8QXP contains a system controller that is responsible for controlling
> the pad setting of the IPs that are present. Communication between the
> host processor running an OS and the system controller happens through
> a SCU protocol. This patch adds the SCU based MX8QXP pinctrl driver.
> 
> diff --git a/include/dt-bindings/pinctrl/pads-imx8qxp.h b/include/dt-bindings/pinctrl/pads-imx8qxp.h
> new file mode 100644
> index 0000000..8f477c3
> --- /dev/null
> +++ b/include/dt-bindings/pinctrl/pads-imx8qxp.h
> @@ -0,0 +1,751 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> + * Copyright 2017~2018 NXP
> + */
> +
> +#ifndef _SC_PADS_H
> +#define _SC_PADS_H
> +
> +/* pin id */
> +#define SC_P_PCIE_CTRL0_PERST_B                  0

As said in the thread adding board support: These should have a proper
IMX8QP_ prefix.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
