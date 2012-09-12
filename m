From: j-pihet@ti.com (Pihet-XID, Jean)
Date: Wed, 12 Sep 2012 09:16:46 +0200
Subject: [PATCH 13/16] ARM: omap: move platform_data definitions
In-Reply-To: <1347368390-31252-13-git-send-email-arnd@arndb.de>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-13-git-send-email-arnd@arndb.de>
Message-ID: <CAN5iSWqnyA0VNDkaCb7bcZOhQxOxJ8xUy4RXWgt+xukSUmHnAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, Sep 11, 2012 at 2:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> Platform data for device drivers should be defined in
> include/linux/platform_data/*.h, not in the architecture
> and platform specific directories.
>
> This moves such data out of the omap include directories
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

...

> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
> index 0ac2caf..7abf1c0 100644
> --- a/arch/arm/mach-omap2/voltage.h
> +++ b/arch/arm/mach-omap2/voltage.h
> @@ -16,7 +16,7 @@
>
>  #include <linux/err.h>
>
> -#include <plat/voltage.h>
> +#include <linux/platform_data/smartreflex-omap.h>
>
>  #include "vc.h"
>  #include "vp.h"
...
> diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/include/linux/platform_data/smartreflex-omap.h
> similarity index 100%
> rename from arch/arm/plat-omap/include/plat/voltage.h
> rename to include/linux/platform_data/smartreflex-omap.h
The filename should be voltage-omap.h. The header file is for a
voltage layer which is used by other layers, one of them is the
smartreflex driver code (in drivers/power/avs).
The header file for the smartreflex driver is in
include/linux/power/smartreflex.h.

> diff --git a/include/linux/power/smartreflex.h b/include/linux/power/smartreflex.h
> index 3101e62..e376f94 100644
> --- a/include/linux/power/smartreflex.h
> +++ b/include/linux/power/smartreflex.h
> @@ -23,7 +23,7 @@
>  #include <linux/types.h>
>  #include <linux/platform_device.h>
>  #include <linux/delay.h>
> -#include <plat/voltage.h>
> +#include <linux/platform_data/smartreflex-omap.h>
>
>  /*
>   * Different Smartreflex IPs version. The v1 is the 65nm version used in

Thanks for the clean-up!

Regards,
Jean
