From: maz@misterjones.org (Marc Zyngier)
Date: Fri, 18 Dec 2009 15:57:11 +0100
Subject: [PATCH 6/7] ARM: S5P6440: Add Board and configuration file
In-Reply-To: <1261127996-30253-2-git-send-email-kgene.kim@samsung.com>
References: <1261127996-30253-1-git-send-email-kgene.kim@samsung.com>
	<1261127996-30253-2-git-send-email-kgene.kim@samsung.com>
Message-ID: <20091218155711.5a3efd99@life-in-the-fast-lane>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Dec 2009 18:19:53 +0900
Kukjin Kim <kgene.kim@samsung.com> wrote:

> diff --git a/arch/arm/mach-s5p6440/mach-smdk6440.c b/arch/arm/mach-s5p6440/mach-smdk6440.c
> new file mode 100644
> index 0000000..e5c560e
> --- /dev/null
> +++ b/arch/arm/mach-s5p6440/mach-smdk6440.c
> @@ -0,0 +1,135 @@
> +/* linux/arch/arm/mach-s5p6440/mach-smdk6440.c
> + *
> + * Copyright (c) 2009 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/interrupt.h>
> +#include <linux/list.h>
> +#include <linux/timer.h>
> +#include <linux/delay.h>
> +#include <linux/init.h>
> +#include <linux/serial_core.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/clk.h>
> +
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +#include <asm/mach/irq.h>

asm/mach/irq.h doesn't seem to contain anything useful.

> +
> +#include <mach/hardware.h>
> +#include <mach/map.h>
> +
> +#include <asm/irq.h>

Please don't directly include asm/irq.h. Use linux/irq.h instead.
-- 
Fast. Cheap. Reliable. Pick two.
