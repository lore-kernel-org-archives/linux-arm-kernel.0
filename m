From: akpm@linux-foundation.org (Andrew Morton)
Date: Mon, 16 Dec 2013 14:46:12 -0800
Subject: [PATCH] rtc: at91sam9: include <mach/hardware.h> explicitly
In-Reply-To: <20131216192816.GC14866@pengutronix.de>
References: <1384524058-20712-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20131126134117.GF28642@pengutronix.de>
 <20131126134444.GG28642@pengutronix.de>
 <20131126183629.GK28642@pengutronix.de>
 <20131216001158.0e15e93c.akpm@linux-foundation.org>
 <20131216192816.GC14866@pengutronix.de>
Message-ID: <20131216144612.8f33194eb247f81a0741b64a@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 Dec 2013 20:28:16 +0100 Uwe Kleine-K__nig <u.kleine-koenig@pengutronix.de> wrote:

> Hello Andrew,
> 
> On Mon, Dec 16, 2013 at 12:11:58AM -0800, Andrew Morton wrote:
> > On Tue, 26 Nov 2013 19:36:29 +0100 Uwe Kleine-K__nig <u.kleine-koenig@pengutronix.de> wrote:
> > > On Tue, Nov 26, 2013 at 02:44:44PM +0100, Uwe Kleine-K__nig wrote:
> > > > On Tue, Nov 26, 2013 at 02:41:17PM +0100, Uwe Kleine-K__nig wrote:
> > > > > On Fri, Nov 15, 2013 at 03:00:58PM +0100, Uwe Kleine-K__nig wrote:
> > > > > > The driver needs the symbol AT91_SLOW_CLOCK which is defined in
> > > > > > arch/arm/mach-at91/include/mach/hardware.h. This file is included
> > > > > > implicitly via linux/module.h -> linux/kmod.h -> linux/gfp.h ->
> > > > > > linux/mmzone.h -> linux/memory_hotplug.h -> linux/notifier.h ->
> > > > > > linux/srcu.h -> linux/workqueue.h -> linux/timer.h -> linux/ktime.h ->
> > > > > > linux/jiffies.h -> linux/timex.h -> mach/timex.h -> mach/hardware.h .
> > > > > > 
> > > > > > So better include it explicitly not only because the last link will go
> > > > > > away soon.
> > > > > > 
> > > > > > Signed-off-by: Uwe Kleine-K__nig <u.kleine-koenig@pengutronix.de>
> > > > > Ping. Is this patch ok despite Jean-Christophe's objection?
> > > > I saw that akpm already took it into his tree.
> > > This patch is one of the last few that are needed to drop <mach/timex.h>
> > > alltogether that I don't have an ack from the respective maintainer yet.
> > > 
> > > Can you give your ack instead of sending the patch to Linus, then I'd
> > > take it with the patch dropping <mach/timex.h> to make it easier to
> > > merge.
> > 
> > ack ;)
> thanks. There is another rtc change that I didn't receive any feedback
> for from a maintainer:
> 
> 	rtc: pxa: drop unused #define TIMER_FREQ

ack.  Robert Jarzmik also acked that one.

> . In the meantime I send a pull request asking to ignore that I didn't
> get any maintainer reply for the rtc changes. Do you think it's sensible
> to change the entry in MAINTAINERS? Any combination of:
> 
> 	a) drop Alessandro's M: line
> 	b) add you
> 	c) change Status from Maintained to Odd Fixes or Orphan

Yeah, I should have a couple hundred MAINTAINERS entries.  Instead I
just lurk on mailing lists ;)
