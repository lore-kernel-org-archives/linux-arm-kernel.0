From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 9 Dec 2011 08:27:24 +0800
Subject: [PATCH 1/3] rtc: stmp3xxx: add wdt-accessor function
In-Reply-To: <1323364783-1059-2-git-send-email-w.sang@pengutronix.de>
References: <1323364783-1059-1-git-send-email-w.sang@pengutronix.de>
 <1323364783-1059-2-git-send-email-w.sang@pengutronix.de>
Message-ID: <20111209002722.GG7913@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Thu, Dec 08, 2011 at 06:19:41PM +0100, Wolfram Sang wrote:
> @@ -0,0 +1,15 @@
> +/*
> + * stmp3xxx_rtc_wdt.h
> + *
> + * Copyright (C) 2011 Wolfram Sang, Pengutronix e.K.
> + *
> + * This file is released under the GPLv2.
> + */
> +#ifndef __LINUX_STMP3XXX_RTC_WDT_H
> +#define __LINUX_STMP3XXX_RTC_WDT_H
> +
> +struct stmp3xxx_wdt_pdata {
> +	void (*wdt_set_timeout)(struct device *dev, u32 timeout);

Passing callback with platform_data will make device tree migration
difficult.  Is there any possibility we can save the callback here?

Regards,
Shawn

> +};
> +
> +#endif /* __LINUX_STMP3XXX_RTC_WDT_H */
> -- 
> 1.7.7.3
