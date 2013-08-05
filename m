From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 5 Aug 2013 14:14:56 +0800
Subject: [PATCH 5/7] ARM: dts: imx27 pin functions
In-Reply-To: <1375439907-10462-6-git-send-email-mpa@pengutronix.de>
References: <1375439907-10462-1-git-send-email-mpa@pengutronix.de>
 <1375439907-10462-6-git-send-email-mpa@pengutronix.de>
Message-ID: <20130805061453.GE24629@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 02, 2013 at 12:38:25PM +0200, Markus Pargmann wrote:
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx27-pinfunc.h | 520 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 520 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx27-pinfunc.h
> 
> diff --git a/arch/arm/boot/dts/imx27-pinfunc.h b/arch/arm/boot/dts/imx27-pinfunc.h
> new file mode 100644
> index 0000000..f3b4c55
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx27-pinfunc.h
> @@ -0,0 +1,520 @@
> +/*
> + * Copyright 2013 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#ifndef __DTS_IMX27_PINFUNC_H
> +#define __DTS_IMX27_PINFUNC_H
> +
> +/*
> + * The pin function ID is a tuple of
> + * <pin mux_config>
> + * mux_config consists of
> + * function + (direction << 2) + (gpio_oconf << 4) + (gpio_iconfa << 8) + (gpio_iconfb << 10)
> + *
> + * function:      0 - Primary function
> + *                1 - Alternate function
> + *                2 - GPIO
> + * direction:     0 - Input
> + *                1 - Output
> + * gpio_oconf:    0 - A_IN
> + *                1 - B_IN
> + *                2 - C_IN
> + *                3 - Data Register
> + * gpio_iconfa/b: 0 - GPIO_IN
> + *                1 - Interrupt Status Register
> + *                2 - 0
> + *                3 - 1

This should be documented in bindings doc as well.

Shawn

> + */
