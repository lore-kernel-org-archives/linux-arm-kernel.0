From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 15 Apr 2015 10:59:36 -0700
Subject: [PATCH 13/13] thermal: of: implement .set_trips for device tree
 thermal zones
In-Reply-To: <20150413063018.GT9742@pengutronix.de>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
 <1427385240-6086-14-git-send-email-s.hauer@pengutronix.de>
 <20150407024307.GH4648@localhost.localdomain>
 <20150413063018.GT9742@pengutronix.de>
Message-ID: <20150415175936.GR32500@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 13, 2015 at 08:30:18AM +0200, Sascha Hauer wrote:
> On Mon, Apr 06, 2015 at 07:43:08PM -0700, Eduardo Valentin wrote:
> > On Thu, Mar 26, 2015 at 04:54:00PM +0100, Sascha Hauer wrote:
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > ---
> > >  drivers/thermal/of-thermal.c | 12 ++++++++++++
> > >  include/linux/thermal.h      |  1 +
> > >  2 files changed, 13 insertions(+)
> > 
> > Can you please include at least one user of this call back in your patch
> > series?
> 
> Thanks for the comments on this series. I'll address them in the next
> round. The user for this callback is not yet ready to be posted. I'll
> try and move this patch to the end of the series so that the series can
> be applied without this one.

I'm actually interested in this patch, as I am developing a thermal
sensor driver that has hardware-assisted temperature-trip interrupts.
I'm testing out your patches now, and will probably end up using them on
my local tree. With help of this (and a few other changes I need to
make), my driver should be ready to post soon.

So, I'll try to post my driver soon as an example, if you'd like. I'd
also appreciate a CC on any future revisions, if you don't mind. I'm
subscribed to the list, but it's not always easy to pick out the signal
from the noise.

Thanks,
Brian

P.S. Time for a mild complaint: I think it seems to be a bit of a plague
in the thermal subsystem; there are API's, and even user-space ABI's
(!!) that have no in-kernel users! e.g., generate_netlink_event()
http://article.gmane.org/gmane.linux.power-management.general/58685
