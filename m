From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 May 2014 11:31:42 +0200
Subject: [PATCH v6 1/2] clk: shmobile: r8a7779: Add clocks support
In-Reply-To: <1397775951-30992-2-git-send-email-horms+renesas@verge.net.au>
References: <1397775951-30992-1-git-send-email-horms+renesas@verge.net.au>
 <1397775951-30992-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <201405271131.42301.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 April 2014, Simon Horman wrote:
> diff --git a/drivers/clk/shmobile/clk-r8a7779.c b/drivers/clk/shmobile/clk-r8a7779.c
> new file mode 100644
> index 0000000..652ecac
> --- /dev/null
> +++ b/drivers/clk/shmobile/clk-r8a7779.c
> @@ -0,0 +1,180 @@
> +/*
> + * r8a7779 Core CPG Clocks
> + *
> + * Copyright (C) 2013, 2014 Horms Solutions Ltd.
> + *
> + * Contact: Simon Horman <horms@verge.net.au>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk/shmobile.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/spinlock.h>
> +
> +#include <dt-bindings/clock/r8a7779-clock.h>

This currently causes a build error in Linux-next, since the header file has not
been merged along with the driver.

	Arnd
