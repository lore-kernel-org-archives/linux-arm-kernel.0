From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 29 Apr 2011 10:31:22 +0200
Subject: [PATCH 09/14] at91: switch pit timer to early platform devices
In-Reply-To: <20110429060801.GN3755@atomide.com>
References: <20110425180847.GA12904@game.jcrosoft.org>
	<1303756284-26529-9-git-send-email-plagnioj@jcrosoft.com>
	<BANLkTi=2_9Xcz45jyOnbxv6xwC2R5U__VA@mail.gmail.com>
	<20110428113427.GG17290@n2100.arm.linux.org.uk>
	<20110429060801.GN3755@atomide.com>
Message-ID: <20110429083122.GE13104@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23:08 Thu 28 Apr     , Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [110428 04:32]:
> > On Thu, Apr 28, 2011 at 01:23:03PM +0200, Andrew Victor wrote:
> > > hi,
> > > 
> > > > this will allow to specify the resources per soc
> > > >
> > > > as the 5series use a different start address for the pit
> > > 
> > > I really don't see the fascination with early platform_devices for timer.
> > > A sys_timer is initialized way earlier, and there are surely cleaner
> > > ways to just pass a "base address" through to the driver.
> > > The interrupt is always AT91_ID_SYS on all chips, so there is no point
> > > making it configurable.
> > 
> > Me too - it looks like this early device stuff is heading in the
> > wrong direction.
> 
> Me too. Most of the stuff can be initialized much later and really
> only timer and interrupts are needed early. Sure there are easily
> dependencies to clock framework etc, but only those clocks need
> to be initialized.
I agree too
that's why I just do timer, interrupt, earlyprintk and clocks

the rest no need to be so early

Best Regards,
J.
