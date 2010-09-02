From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 10:13:41 +0100
Subject: [PATCH 14/74] ST SPEAr: Adding PLGPIO driver for spear platform
In-Reply-To: <ee98dfb49c1634d60fe2fe4f8aabca183be08d24.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<ee98dfb49c1634d60fe2fe4f8aabca183be08d24.1283161023.git.viresh.kumar@st.com>
Message-ID: <20100902091341.GI26319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 30, 2010 at 04:08:45PM +0530, Viresh KUMAR wrote:
> diff --git a/arch/arm/plat-spear/plgpio.c b/arch/arm/plat-spear/plgpio.c
> new file mode 100644
> index 0000000..847ff9c
> --- /dev/null
> +++ b/arch/arm/plat-spear/plgpio.c
> @@ -0,0 +1,453 @@
> +/*
> + * arch/arm/plat-spear/plgpio.c
> + *
> + * SPEAr platform PLGPIO driver source file
> + *
> + * Copyright (C) 2010 ST Microelectronics
> + * Viresh Kumar<viresh.kumar@st.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/kernel.h>
> +#include <linux/spinlock.h>
> +#include <linux/errno.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/irq.h>
> +#include <linux/gpio.h>
> +#include <linux/slab.h>
> +#include <linux/platform_device.h>
> +#include <mach/gpio.h>

You're already including linux/gpio.h, which means mach/gpio.h will already
be included.
