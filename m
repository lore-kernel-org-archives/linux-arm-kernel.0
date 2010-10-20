From: yegor_sub1@visionsystems.de (Yegor Yefremov)
Date: Wed, 20 Oct 2010 11:11:24 +0200
Subject: [PATCH 2/5] ks8695_wdt: explicitly define the SoC timer tick
	base rate
In-Reply-To: <20101020045131.GY12979@mail.wantstofly.org>
References: <20101020045131.GY12979@mail.wantstofly.org>
Message-ID: <4CBEB23C.7040208@visionsystems.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 20.10.2010 06:51, schrieb Lennert Buytenhek:
> ..instead of including mach/timex.h, as the latter is going away.
> 
> Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
> ---
>  drivers/watchdog/ks8695_wdt.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/watchdog/ks8695_wdt.c b/drivers/watchdog/ks8695_wdt.c
> index 2852bb2..0060519 100644
> --- a/drivers/watchdog/ks8695_wdt.c
> +++ b/drivers/watchdog/ks8695_wdt.c
> @@ -21,9 +21,10 @@
>  #include <linux/watchdog.h>
>  #include <linux/io.h>
>  #include <linux/uaccess.h>
> -#include <mach/timex.h>
>  #include <mach/regs-timer.h>
>  
> +#define KS8695_CLOCK_RATE	25000000
> +

In this way KS8695_CLOCK_RATE will be defined twice: here and in /arch/arm/mach-ks8695/include/mach/hardware.h

>  #define WDT_DEFAULT_TIME	5	/* seconds */
>  #define WDT_MAX_TIME		171	/* seconds */

I tried without redefining the macro and it compiles without errors.

Regards,
Yegor

..instead of including mach/timex.h, as the latter is going away.

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

---
 drivers/watchdog/ks8695_wdt.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

Index: b/drivers/watchdog/ks8695_wdt.c
===================================================================
--- a/drivers/watchdog/ks8695_wdt.c	2010-08-27 01:47:12.000000000 +0200
+++ b/drivers/watchdog/ks8695_wdt.c	2010-10-20 10:47:14.000000000 +0200
@@ -21,7 +21,7 @@
 #include <linux/watchdog.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
-#include <mach/timex.h>
+#include <mach/hardware.h>
 #include <mach/regs-timer.h>
 
 #define WDT_DEFAULT_TIME	5	/* seconds */


  
