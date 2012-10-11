From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Oct 2012 12:10:11 +0000
Subject: [PATCH] pinctrl/nomadik: support other alternate-C functions
In-Reply-To: <1349185041-1810-1-git-send-email-linus.walleij@stericsson.com>
References: <1349185041-1810-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <201210111210.12122.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 October 2012, Linus Walleij wrote:
> --- a/drivers/pinctrl/pinctrl-nomadik.c
> +++ b/drivers/pinctrl/pinctrl-nomadik.c
> @@ -30,6 +30,7 @@
>  #include <linux/pinctrl/pinconf.h>
>  /* Since we request GPIOs from ourself */
>  #include <linux/pinctrl/consumer.h>
> +#include <linux/mfd/dbx500-prcmu.h>
>  
>  #include <asm/mach/irq.h>
>  

This patch just showed up in linux-next and caused this error
when building nhk8815_defconfig:

In file included from /home/arnd/linux-arm/drivers/pinctrl/pinctrl-nomadik.c:33:0:
/home/arnd/linux-arm/include/linux/mfd/dbx500-prcmu.h:459:90: error: redefinition of 'prcmu_abb_read'
/home/arnd/linux-arm/include/linux/mfd/db8500-prcmu.h:673:90: note: previous definition of 'prcmu_abb_read' was here
/home/arnd/linux-arm/include/linux/mfd/dbx500-prcmu.h:464:90: error: redefinition of 'prcmu_abb_write'
/home/arnd/linux-arm/include/linux/mfd/db8500-prcmu.h:678:90: note: previous definition of 'prcmu_abb_write' was here
/home/arnd/linux-arm/include/linux/mfd/dbx500-prcmu.h:475:90: error: redefinition of 'prcmu_config_clkout'
/home/arnd/linux-arm/include/linux/mfd/db8500-prcmu.h:643:90: note: previous definition of 'prcmu_config_clkout' was here
/home/arnd/linux-arm/include/linux/mfd/dbx500-prcmu.h:537:90: error: redefinition of 'prcmu_ac_wake_req'
/home/arnd/linux-arm/include/linux/mfd/db8500-prcmu.h:683:90: note: previous definition of 'prcmu_ac_wake_req' was here
/home/arnd/linux-arm/include/linux/mfd/dbx500-prcmu.h:542:91: error: redefinition of 'prcmu_ac_sleep_req'
/home/arnd/linux-arm/include/linux/mfd/db8500-prcmu.h:688:91: note: previous definition of 'prcmu_ac_sleep_req' was here
make[2]: *** [drivers/pinctrl/pinctrl-nomadik.o] Error 1
make[1]: *** [drivers/pinctrl/] Error 2
make: *** [sub-make] Error 2


	Arnd
