From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Apr 2014 22:34:50 +0200
Subject: [RFC 08/11] ARM: dts: am33xx: Add prcm_resets node
In-Reply-To: <1398802790-29287-9-git-send-email-dmurphy@ti.com>
References: <1398802790-29287-1-git-send-email-dmurphy@ti.com>
 <1398802790-29287-9-git-send-email-dmurphy@ti.com>
Message-ID: <6286135.g77D4pMffU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 April 2014 15:19:47 Dan Murphy wrote:
> + * AM33xx reset index for PRCM Module
> + *
> + * Copyright 2014 Texas Instruments Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef _DT_BINDINGS_RESET_TI_AM33XX_H
> +#define _DT_BINDINGS_RESET_TI_AM33XX_H
> +
> +#define RESET_DEVICE_RESET                     0
> +#define RESET_GFX_RESET                                1
> +#define RESET_PER_RESET                                2
> +
> +#endif

Interfaces like this should only be used if you can't use hardware
numbers, in general. If these numbers are in the data sheet, just
put them directly into the dts file, as we do for interrupt numbers,
gpio numbers, register offsets etc.

If you have made them up to define an interface between the driver
and DT because there is no usable hardare ID, I'd suggest just using
a single file across all SoCs that have this driver, and have
a unified name space.

	Arnd
