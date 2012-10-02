From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 2 Oct 2012 22:07:53 +0200
Subject: [PATCH v7 1/3] watchdog: at91sam9_wdt: add device tree
Message-ID: <20121002200753.GA12565@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Date: Tue,  2 Oct 2012 18:01:00 +0200
> From: Fabio Porcedda <fabio.porcedda@gmail.com>
> To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog at vger.kernel.org,
>         linux-arm-kernel at lists.infradead.org, Nicolas Ferre
>         <nicolas.ferre@atmel.com>, Jean-Christophe PLAGNIOL-VILLARD
>         <plagnioj@jcrosoft.com>, Andrew Victor <linux@maxim.org.za>
> Cc: devicetree-discuss at lists.ozlabs.org
> Subject: [PATCH v7 1/3] watchdog: at91sam9_wdt: add device tree
>         support
> Message-ID:
>         <1349193662-23482-2-git-send-email-fabio.porcedda@gmail.com>
> 
> Tested on an at91sam9260 board (evk-pro3)
> 
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> +++ b/drivers/watchdog/at91sam9_wdt.c
> @@ -32,6 +32,7 @@
>  #include <linux/timer.h>
>  #include <linux/bitops.h>
>  #include <linux/uaccess.h>
> +#include <linux/of.h>
> 
>  #include "at91sam9_wdt.h"
> 
> > @@ -302,11 +303,21 @@ static int __exit at91wdt_remove(struct platform_device *pdev)
>         return res;
>  }
> 
> +#if defined(CONFIG_OF)
> +static const struct of_device_id at91_wdt_dt_ids[] = {
> +       { .compatible = "atmel,at91sam9260-wdt" },
> +       { /* sentinel */ }
> +};

Hi Fabio

You are missing __devinitdata.

    Andrew
