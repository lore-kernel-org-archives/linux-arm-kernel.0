From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 27 Mar 2010 22:55:22 +0000
Subject: [PATCH] ARM: mach-sa1100: Put nanoEngine support back in the
	kernel.
In-Reply-To: <1268338199-32222-1-git-send-email-mroberto@cpti.cetuc.puc-rio.br>
References: <1268338199-32222-1-git-send-email-mroberto@cpti.cetuc.puc-rio.br>
Message-ID: <20100327225522.GD13203@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 11, 2010 at 05:09:59PM -0300, Marcelo Roberto Jimenez wrote:
> --- /dev/null
> +++ b/arch/arm/configs/nanoengine_defconfig
> @@ -0,0 +1,1396 @@

Please don't include defconfigs along with other code.

> +/*
> + * linux/arch/arm/mach-sa1100/nanoengine.c
> + *
> + * Bright Star Engineering's nanoEngine board init code.
> + *
> + * Copyright (C) 2009 Marcelo Roberto Jimenez <mroberto@cpti.cetuc.puc-rio.br>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/root_dev.h>
> +#include <linux/tty.h>

Do you really need tty.h in here?

> +
> +#include <asm/mach-types.h>
> +#include <asm/setup.h>
> +
> +#include <asm/mach/arch.h>
> +#include <asm/mach/flash.h>
> +#include <asm/mach/map.h>
> +#include <asm/mach/serial_sa1100.h>
> +
> +#include <mach/hardware.h>
> +
> +#include "generic.h"
> +
> +/* Flash bank 0 */
> +static struct mtd_partition nanoengine_partitions[] = {
> +	{
> +	.name		= "nanoEngine boot firmware and parameter table",

Each '{' should indent the next line by a tab.
