From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 03 Aug 2012 14:37:18 -0600
Subject: [PATCH] pinctrl: pinctrl-imx: add imx35 pinctrl driver
In-Reply-To: <1343921942-22079-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343921942-22079-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <501C367E.10808@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/2012 09:39 AM, Uwe Kleine-K?nig wrote:
> This is mostly cut'n'paste from the imx51 pinctrl driver.

> +++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx35-pinctrl.txt

> +See below for available PIN_FUNC_ID for imx35:
> +# grep '   IMX_PIN_REG' drivers/pinctrl/pinctrl-imx35.c | awk '{ print NR-1 " " $8 }'

I'd remove that line from the document; the binding doc is supposed to
be OS-agnostic, and the file drivers/pinctrl/pinctrl-imx35.c probably
only exists in Linux.

> diff --git a/drivers/pinctrl/pinctrl-imx35.c b/drivers/pinctrl/pinctrl-imx35.c

> +/*
> + * imx35 pinctrl driver.
> + *
> + * This driver was mostly copied from the imx51 pinctrl driver which has:
> + *
> + * Copyright (C) 2012 Freescale Semiconductor, Inc.
> + * Copyright (C) 2012 Linaro, Inc.
> + *
> + * Author: Dong Aisheng <dong.aisheng@linaro.org>

You're not going to add your (c)? Maybe since it's mostly just data it
doesn't matter.

> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.
> + */

Other than that this is basically just SoC data, so I'm not really
qualified to comment:-) So,

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
