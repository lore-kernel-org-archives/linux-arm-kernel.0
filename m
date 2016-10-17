From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 17 Oct 2016 09:54:15 -0700
Subject: [PATCH 1/3] ARM: memory: da8xx-ddrctl: new driver
In-Reply-To: <1476721850-454-2-git-send-email-bgolaszewski@baylibre.com>
 (Bartosz Golaszewski's message of "Mon, 17 Oct 2016 18:30:48 +0200")
References: <1476721850-454-1-git-send-email-bgolaszewski@baylibre.com>
 <1476721850-454-2-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <7h8ttmdih4.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bartosz Golaszewski <bgolaszewski@baylibre.com> writes:

> Create a new driver for the da8xx DDR2/mDDR controller and implement
> support for writing to the Peripheral Bus Burst Priority Register.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

[...]

> diff --git a/drivers/memory/da8xx-ddrctl.c b/drivers/memory/da8xx-ddrctl.c
> new file mode 100644
> index 0000000..dcd0a61
> --- /dev/null
> +++ b/drivers/memory/da8xx-ddrctl.c
> @@ -0,0 +1,77 @@
> +/*
> + * TI da8xx DDR2/mDDR controller driver
> + *
> + * Copyright (C) 2016 BayLibre SAS
> + *
> + * Author:
> + *   Bartosz Golaszewski <bgolaszewski@baylibre.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +
> +#define DA8XX_DDR_CTL_BASE	0xB0000000

This base addr should be the reg property of the node.

> +#define DA8XX_PBBPR_OFFSET	0x00000020
> +#define DA8XX_PBBPR_REG(p)	((p) + DA8XX_PBBPR_OFFSET)

Kevin
