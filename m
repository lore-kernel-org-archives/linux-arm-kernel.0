From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 02 May 2013 09:53:17 -0700
Subject: [PATCH V2 1/2] ARM/MVF600: add Vybrid Family platform support
In-Reply-To: <1367480285-26159-2-git-send-email-b35083@freescale.com>
References: <1367480285-26159-1-git-send-email-b35083@freescale.com>
 <1367480285-26159-2-git-send-email-b35083@freescale.com>
Message-ID: <20130502165317.7790.1722@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Jingchang Lu (2013-05-02 00:38:04)
> diff --git a/arch/arm/mach-imx/clk-mvf.c b/arch/arm/mach-imx/clk-mvf.c
> new file mode 100644
> index 0000000..1467a304
> --- /dev/null
> +++ b/arch/arm/mach-imx/clk-mvf.c
> @@ -0,0 +1,406 @@
> +/*
> + * Copyright 2012-2013 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/types.h>
> +#include <linux/time.h>
> +#include <linux/hrtimer.h>
> +#include <linux/mm.h>
> +#include <linux/errno.h>
> +#include <linux/delay.h>
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/clkdev.h>
> +#include <linux/regulator/consumer.h>
> +#include <asm/div64.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clk-private.h>

Please do not use clk-private.h.  I plan to remove it soon.

Regards,
Mike
