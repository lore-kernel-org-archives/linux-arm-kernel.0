From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 11 Jan 2011 18:57:04 +0100
Subject: [PATCH 1/2] serial: Add auart driver for i.MX23/28
In-Reply-To: <20110111171050.GA522@pengutronix.de>
References: <1294758545-9445-1-git-send-email-s.hauer@pengutronix.de>
	<1294758545-9445-2-git-send-email-s.hauer@pengutronix.de>
	<20110111171050.GA522@pengutronix.de>
Message-ID: <20110111175704.GV12078@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 11, 2011 at 06:10:50PM +0100, Wolfram Sang wrote:
> On Tue, Jan 11, 2011 at 04:09:04PM +0100, Sascha Hauer wrote:
> [...]
> > +#include <asm/cacheflush.h>
> > +#include <mach/mx28.h>
> 
> What about MX23 and STMP3xxx?

This include is not needed, will remove. Instead we need linux/io.h.

> 
> > +
> > +#define MXS_AUART_PORTS 5
> 
> MX23 has just 2. We should better adapt to that depending on the type?

This is just the maximum number the driver supports, it's safe to keep
it as is.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
