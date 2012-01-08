From: richard.zhao@linaro.org (Richard Zhao)
Date: Sun, 8 Jan 2012 21:05:44 +0800
Subject: [RFC PATCH v3 3/5] pinctrl: imx: add pinctrl imx driver
In-Reply-To: <1324402840-32451-4-git-send-email-b29396@freescale.com>
References: <1324402840-32451-1-git-send-email-b29396@freescale.com>
 <1324402840-32451-4-git-send-email-b29396@freescale.com>
Message-ID: <20120108130542.GC2203@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[snip]
> --- /dev/null
> +++ b/drivers/pinctrl/pinctrl-imx53.c
> @@ -0,0 +1,443 @@
> +/*
> + * imx53 pinctrl driver based on imx pinmux core
> + *
> + * Copyright (C) 2011 Freescale Semiconductor, Inc.
> + * Copyright (C) 2011 Linaro, Inc.
> + *
> + * Author: Dong Aisheng <dong.aisheng@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <linux/pinctrl/pinctrl.h>
> +#include <linux/pinctrl/pinmux.h>
> +
> +#include "pinctrl-imx-core.h"
> +
> +#define IMX53_IOMUXC_MUX_OFFSET 0x20
> +#define IMX53_IOMUXC_MAXPIN	(23*23)
> +
> +enum imx_imx53_pinctrl_pads {
> +	MX53_GPIO_19 = 0,
> +	MX53_KEY_COL0 = 1,
> +	MX53_KEY_ROW0 = 2,
> +	MX53_KEY_COL1 = 3,
> +	MX53_KEY_ROW1 = 4,
> +	MX53_KEY_COL2 = 5,
> +	MX53_KEY_ROW2 = 6,
...
Why not describe it in dts and make this file generic for imx?
One node for one pad, it'll be easy to extend pad properties. You know
the pad may set pull up/down, open drain, drive strenth, daisy chain etc.
The features have to be supported, to make your model usefull.

Thanks
Richard
