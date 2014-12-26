From: tony@atomide.com (Tony Lindgren)
Date: Fri, 26 Dec 2014 07:54:57 -0800
Subject: [PATCH] add omap34xx temperature monitoring support
In-Reply-To: <20141226102933.GA28778@amd>
References: <20141226102933.GA28778@amd>
Message-ID: <20141226155456.GB12409@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [141226 02:32]:
> --- /dev/null
> +++ b/drivers/hwmon/omap34xx_temp.c
> @@ -0,0 +1,263 @@
> +/*
> + * omap34xx_temp.c - Linux kernel module for OMAP34xx hardware monitoring
> + *
> + * Copyright (C) 2008 Nokia Corporation
> + *
> + * Written by Peter De Schrijver <peter.de-schrijver@nokia.com>
> + *
> + * Inspired by k8temp.c
> + *
> + * This file is subject to the terms and conditions of the GNU General
> + * Public License. See the file "COPYING" in the main directory of this
> + * archive for more details.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/hrtimer.h>
> +#include <linux/module.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +
> +#include "../../arch/arm/mach-omap2/control.h"

No need to do this, you can use syscon here like pbias-regulator.c
is doing.

Regards,

Tony
