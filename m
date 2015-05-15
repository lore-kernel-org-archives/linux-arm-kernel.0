From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Fri, 15 May 2015 16:30:03 +0000
Subject: [PATCH 2/9] ARM: imx: define an enum for gpt timer device type
In-Reply-To: <1431677507-27420-3-git-send-email-shawnguo@kernel.org>
References: <1431677507-27420-1-git-send-email-shawnguo@kernel.org>
 <1431677507-27420-3-git-send-email-shawnguo@kernel.org>
Message-ID: <BL2PR03MB3700FB7CCC3587B481DBEA983C70@BL2PR03MB370.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: shawnguo at kernel.org [mailto:shawnguo at kernel.org]
> Sent: 2015?5?15? 3:12
> To: linux-arm-kernel at lists.infradead.org
> Cc: kernel at pengutronix.de; Daniel Lezcano; Wang Shenwei-B38339; Shawn Guo
> Subject: [PATCH 2/9] ARM: imx: define an enum for gpt timer device type
> 
> From: Shawn Guo <shawn.guo@linaro.org>
> 
> Define an enum for gpt timer device type in include/soc/imx/timer.h to tell the
> gpt block differences among SoCs.  Update non-DT users (clock
> drivers) to pass the device type.
> 
> As we now have include/soc/imx/timer.h, the declaration of
> mxc_timer_init() is moved into there as the best fit.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 000000000000..bbbafd65f464
> --- /dev/null
> +++ b/include/soc/imx/timer.h
> @@ -0,0 +1,26 @@
> +/*
> + * Copyright 2015 Linaro Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __SOC_IMX_TIMER_H__
> +#define __SOC_IMX_TIMER_H__
> +
> +enum imx_gpt_type {
> +	GPT_TYPE_IMX1,		/* i.MX1 */
> +	GPT_TYPE_IMX21,		/* i.MX21/27 */
> +	GPT_TYPE_IMX31,		/* i.MX31/35/25/37/51/6Q */
> +	GPT_TYPE_IMX6DL,	/* i.MX6DL/SX/SL */
> +};
> +

Since there is only one type of GPT IP block with different versions, I think to use the word of "GPT_VER_xxx" would make sense.

Regards,
Shenwei

> +/*
> + * This is a stop-gap solution for clock drivers like imx1/imx21 which
> +call
> + * mxc_timer_init() to initialize timer for non-DT boot.  It can be
> +removed
> + * when these legacy non-DT support is converted or dropped.
> + */
> +void mxc_timer_init(unsigned long pbase, int irq, enum imx_gpt_type
> +type);
> +
> +#endif  /* __SOC_IMX_TIMER_H__ */
> --
> 1.9.1
