From: heiko@sntech.de (Heiko =?iso-8859-15?q?St=FCbner?=)
Date: Thu, 11 Apr 2013 23:43:34 +0200
Subject: [PATCH v3 05/10] i2c: s3c2410: make header file local
In-Reply-To: <1365716245-99231-6-git-send-email-arnd@arndb.de>
References: <1365716245-99231-1-git-send-email-arnd@arndb.de>
 <1365716245-99231-6-git-send-email-arnd@arndb.de>
Message-ID: <201304112343.34534.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Am Donnerstag, 11. April 2013, 23:37:20 schrieb Arnd Bergmann:
> No other file in the kernel besides i2c-s3c2410.c uses the current
> plat/regs-iic.h, so we can simply move the header file to live in the
> same directory as the driver, as a preparation to multiplatform builds.

There is already a patch doing similar changes [0] in the i2c tree for 3.10


Heiko


[0] 
https://git.kernel.org/cgit/linux/kernel/git/wsa/linux.git/commit/?h=i2c/for-
next&id=e636602ac2613da8c1777cb42443223994be4107

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-i2c at vger.kernel.org
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Ben Dooks <ben-linux@fluff.org>
> ---
>  arch/arm/mach-s3c24xx/mach-rx1950.c                                    | 1
> - arch/arm/plat-samsung/devs.c                                           |
> 1 - drivers/i2c/busses/i2c-s3c2410.c                                      
> | 3 ++- .../include/plat/regs-iic.h => drivers/i2c/busses/i2c-s3c2410.h   
>     | 0 4 files changed, 2 insertions(+), 3 deletions(-)
>  rename arch/arm/plat-samsung/include/plat/regs-iic.h =>
> drivers/i2c/busses/i2c-s3c2410.h (100%)
> 
> diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c
> b/arch/arm/mach-s3c24xx/mach-rx1950.c index 1f9ba2a..43f3ac5 100644
> --- a/arch/arm/mach-s3c24xx/mach-rx1950.c
> +++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
> @@ -56,7 +56,6 @@
>  #include <plat/cpu.h>
>  #include <plat/devs.h>
>  #include <plat/pm.h>
> -#include <plat/regs-iic.h>
>  #include <plat/regs-serial.h>
> 
>  #include "common.h"
> diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
> index de9ad27..5e37051 100644
> --- a/arch/arm/plat-samsung/devs.c
> +++ b/arch/arm/plat-samsung/devs.c
> @@ -62,7 +62,6 @@
>  #include <linux/platform_data/usb-s3c2410_udc.h>
>  #include <linux/platform_data/usb-ohci-s3c2410.h>
>  #include <plat/usb-phy.h>
> -#include <plat/regs-iic.h>
>  #include <plat/regs-serial.h>
>  #include <plat/regs-spi.h>
>  #include <linux/platform_data/spi-s3c64xx.h>
> diff --git a/drivers/i2c/busses/i2c-s3c2410.c
> b/drivers/i2c/busses/i2c-s3c2410.c index f6b880b..d042ad0 100644
> --- a/drivers/i2c/busses/i2c-s3c2410.c
> +++ b/drivers/i2c/busses/i2c-s3c2410.c
> @@ -42,9 +42,10 @@
> 
>  #include <asm/irq.h>
> 
> -#include <plat/regs-iic.h>
>  #include <linux/platform_data/i2c-s3c2410.h>
> 
> +#include "i2c-s3c2410.h"
> +
>  /* Treat S3C2410 as baseline hardware, anything else is supported via
> quirks */ #define QUIRK_S3C2440		(1 << 0)
>  #define QUIRK_HDMIPHY		(1 << 1)
> diff --git a/arch/arm/plat-samsung/include/plat/regs-iic.h
> b/drivers/i2c/busses/i2c-s3c2410.h similarity index 100%
> rename from arch/arm/plat-samsung/include/plat/regs-iic.h
> rename to drivers/i2c/busses/i2c-s3c2410.h
