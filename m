From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 9 Dec 2011 10:22:19 +0100
Subject: [PATCH 1/3] rtc: stmp3xxx: add wdt-accessor function
In-Reply-To: <20111209002722.GG7913@S2100-06.ap.freescale.net>
References: <1323364783-1059-1-git-send-email-w.sang@pengutronix.de>
 <1323364783-1059-2-git-send-email-w.sang@pengutronix.de>
 <20111209002722.GG7913@S2100-06.ap.freescale.net>
Message-ID: <20111209092219.GA3327@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2011 at 08:27:24AM +0800, Shawn Guo wrote:
> Hi Wolfram,
> 
> On Thu, Dec 08, 2011 at 06:19:41PM +0100, Wolfram Sang wrote:
> > @@ -0,0 +1,15 @@
> > +/*
> > + * stmp3xxx_rtc_wdt.h
> > + *
> > + * Copyright (C) 2011 Wolfram Sang, Pengutronix e.K.
> > + *
> > + * This file is released under the GPLv2.
> > + */
> > +#ifndef __LINUX_STMP3XXX_RTC_WDT_H
> > +#define __LINUX_STMP3XXX_RTC_WDT_H
> > +
> > +struct stmp3xxx_wdt_pdata {
> > +	void (*wdt_set_timeout)(struct device *dev, u32 timeout);
> 
> Passing callback with platform_data will make device tree migration
> difficult.  Is there any possibility we can save the callback here?

This won't affect the device tree. The platform_data is not set up per
board. It is the RTC driver which adds the platform_data to the
platform_device which was also created inside the RTC driver. So, device
tree or not, simply enable the watchdog in Kconfig and all will be fine.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111209/db3be99b/attachment.sig>
