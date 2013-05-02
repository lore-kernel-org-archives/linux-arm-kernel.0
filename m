From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 02 May 2013 20:33:48 +0200
Subject: [PATCH] irqchip: add support for Marvell Orion SoCs
In-Reply-To: <1367519104-19677-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1367519104-19677-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <5182B18C.4080404@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/02/2013 08:25 PM, Sebastian Hesselbarth wrote:
> This patch adds an irqchip driver for the main interrupt controller found
> on Marvell Orion SoCs (Kirkwood, Dove, Orion5x, Discovery Innovation).
> Corresponding device tree documentation is also added.
>
> Signed-off-by: Sebastian Hesselbarth<sebastian.hesselbarth@gmail.com>
> ---
> Note: This patch triggers a checkpatch warning for
>    WARNING: Avoid CamelCase:<handle_IRQ>
>
[...]
> diff --git a/include/linux/irqchip/orion.h b/include/linux/irqchip/orion.h
> new file mode 100644
> index 0000000..04f7bab
> --- /dev/null
> +++ b/include/linux/irqchip/orion.h
> @@ -0,0 +1,18 @@
> +/*
> + * Marvell Orion SoCs IRQ chip driver header.
> + *
> + * Sebastian Hesselbarth<sebastian.hesselbarth@gmail.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#ifndef __LINUX_IRQCHIP_ORION_H
> +#define __LINUX_IRQCHIP_ORION_H
> +
> +#include<asm/exception.h>

First review by myself. The above include is a left-over and
will be removed in a v2.

> +
> +extern void orion_init_irq(void);
> +
> +#endif
