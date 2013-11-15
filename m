From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 15 Nov 2013 15:55:54 +0100
Subject: [PATCH] rtc: at91sam9: include <mach/hardware.h> explicitly
In-Reply-To: <20131115142327.GQ28304@ns203013.ovh.net>
References: <1384524058-20712-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20131115142327.GQ28304@ns203013.ovh.net>
Message-ID: <20131115145554.GC19318@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Nov 15, 2013 at 03:23:27PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 15:00 Fri 15 Nov     , Uwe Kleine-K??nig wrote:
> > The driver needs the symbol AT91_SLOW_CLOCK which is defined in
> > arch/arm/mach-at91/include/mach/hardware.h. This file is included
> > implicitly via linux/module.h -> linux/kmod.h -> linux/gfp.h ->
> > linux/mmzone.h -> linux/memory_hotplug.h -> linux/notifier.h ->
> > linux/srcu.h -> linux/workqueue.h -> linux/timer.h -> linux/ktime.h ->
> > linux/jiffies.h -> linux/timex.h -> mach/timex.h -> mach/hardware.h .
> > 
> > So better include it explicitly not only because the last link will go
> > away soon.
> > 
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> we should never use this symbol you need to request the clock clk32k
IMHO this should be addressed in another patch. My intent is to get rid
of <mach/timex.h>. So I let someone else take this patch opportunity.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
