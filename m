From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 14 May 2018 23:37:20 +0200
Subject: [PATCH 1/7] i2c: i2c-gpio: move header to platform_data
In-Reply-To: <20180419200015.15095-2-wsa@the-dreams.de>
References: <20180419200015.15095-1-wsa@the-dreams.de>
 <20180419200015.15095-2-wsa@the-dreams.de>
Message-ID: <20180514213719.o6ceftp2quem3s7f@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>  arch/arm/mach-ks8695/board-acs5k.c               | 2 +-
>  arch/arm/mach-sa1100/simpad.c                    | 2 +-
>  arch/mips/alchemy/board-gpr.c                    | 2 +-

Those still need acks...

> diff --git a/arch/arm/mach-ks8695/board-acs5k.c b/arch/arm/mach-ks8695/board-acs5k.c
> index 937eb1d47e7b..ef835d82cdb9 100644
> --- a/arch/arm/mach-ks8695/board-acs5k.c
> +++ b/arch/arm/mach-ks8695/board-acs5k.c
> @@ -19,7 +19,7 @@
>  #include <linux/gpio/machine.h>
>  #include <linux/i2c.h>
>  #include <linux/i2c-algo-bit.h>
> -#include <linux/i2c-gpio.h>
> +#include <linux/platform_data/i2c-gpio.h>
>  #include <linux/platform_data/pca953x.h>
>  
>  #include <linux/mtd/mtd.h>

...

> diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
> index ace010479eb6..49a61e6f3c5f 100644
> --- a/arch/arm/mach-sa1100/simpad.c
> +++ b/arch/arm/mach-sa1100/simpad.c
> @@ -37,7 +37,7 @@
>  #include <linux/input.h>
>  #include <linux/gpio_keys.h>
>  #include <linux/leds.h>
> -#include <linux/i2c-gpio.h>
> +#include <linux/platform_data/i2c-gpio.h>
>  
>  #include "generic.h"
>  
> diff --git a/arch/mips/alchemy/board-gpr.c b/arch/mips/alchemy/board-gpr.c
> index 4e79dbd54a33..fa75d75b5ba9 100644
> --- a/arch/mips/alchemy/board-gpr.c
> +++ b/arch/mips/alchemy/board-gpr.c
> @@ -29,7 +29,7 @@
>  #include <linux/leds.h>
>  #include <linux/gpio.h>
>  #include <linux/i2c.h>
> -#include <linux/i2c-gpio.h>
> +#include <linux/platform_data/i2c-gpio.h>
>  #include <linux/gpio/machine.h>
>  #include <asm/bootinfo.h>
>  #include <asm/idle.h>

... and this was the shortened diff for those.

Greg, Russell, Ralf, James? Is it okay if I take this via my tree?

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180514/f3c37915/attachment.sig>
