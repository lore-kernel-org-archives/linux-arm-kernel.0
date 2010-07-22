From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 22 Jul 2010 14:05:37 +0300
Subject: [PATCH] Add support for Vista Silicon Visstrim_m10 board [v5].
In-Reply-To: <1279795695-6211-1-git-send-email-javier.martin@vista-silicon.com>
References: <1279795695-6211-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <20100722110537.GC12359@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On Thu, Jul 22, 2010 at 12:48:15PM +0200, Javier Martin wrote:
> Vista Silicon Visstrim_m10 i.MX27 based board is used
> as multimedia streaming server, access control and other
> custom applications.
> 
> Include files in correct order and use <linux/gpio.h>
> instead of <mach/gpio.h>.
> 
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
> ---
>  arch/arm/mach-imx/Kconfig                   |    9 +
>  arch/arm/mach-imx/Makefile                  |    1 +
>  arch/arm/mach-imx/mach-imx27_visstrim_m10.c |  266 +++++++++++++++++++++++++++
>  3 files changed, 276 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-imx/mach-imx27_visstrim_m10.c

[snip]

> new file mode 100644
> index 0000000..f18b9ed
> --- /dev/null
> +++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
> @@ -0,0 +1,266 @@
> +/*
> + * mach-imx27_visstrim_m10.c
> + *
> + * Copyright 2010  Javier Martin <javier.martin@vista-silicon.com>
> + *
> + * Based on mach-pcm038.c, mach-pca100.c, mach-mx27ads.c and others.
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
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
> + * MA 02110-1301, USA.
> + */
> +
> +#define pr_fmt(fmt) "visstrim_m10: " fmt

This isn't used anywhere.

> +#include <linux/platform_device.h>
> +#include <linux/mtd/physmap.h>
> +#include <linux/i2c.h>
> +#include <linux/i2c/pca953x.h>
> +#include <linux/gpio_keys.h>
> +#include <linux/input.h>
> +#include <linux/gpio.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/time.h>
> +#include <mach/common.h>
> +#include <mach/mmc.h>
> +#include <mach/iomux.h>
> +#include <mach/mxc_ehci.h>
> +
> +

One empty line should be enough.

> +#include "devices-imx27.h"
> +#include "devices.h"
> +
> +#define OTG_PHY_CS_GPIO (GPIO_PORTF + 17)
> +#define SDHC1_IRQ IRQ_GPIOB(25)
> +
> +
> +

Ditto.

[snip]

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
