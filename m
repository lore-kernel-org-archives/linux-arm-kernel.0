From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 28 Apr 2011 15:15:38 +0200
Subject: [PATCH 09/14] at91: switch pit timer to early platform devices
In-Reply-To: <20110428113427.GG17290@n2100.arm.linux.org.uk>
References: <20110425180847.GA12904@game.jcrosoft.org>
	<1303756284-26529-9-git-send-email-plagnioj@jcrosoft.com>
	<BANLkTi=2_9Xcz45jyOnbxv6xwC2R5U__VA@mail.gmail.com>
	<20110428113427.GG17290@n2100.arm.linux.org.uk>
Message-ID: <20110428131538.GA10594@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12:34 Thu 28 Apr     , Russell King - ARM Linux wrote:
> On Thu, Apr 28, 2011 at 01:23:03PM +0200, Andrew Victor wrote:
> > hi,
> > 
> > > this will allow to specify the resources per soc
> > >
> > > as the 5series use a different start address for the pit
> > 
> > I really don't see the fascination with early platform_devices for timer.
> > A sys_timer is initialized way earlier, and there are surely cleaner
> > ways to just pass a "base address" through to the driver.
> > The interrupt is always AT91_ID_SYS on all chips, so there is no point
> > making it configurable.
> 
> Me too - it looks like this early device stuff is heading in the
> wrong direction.
> 
> There is a point when the kernel expects to have knowledge of the
> passing of time initialized, and that's when the system_timer->init
> callback is made.  At this point, everything is in place for the
> ticks to start, and some of the subsequent parts of the kernel may
> expect jiffies to be updating after this call has returned.
> 
> Shoving stuff in other random places in the initialization order is
> asking for things to break - maybe not immediately, but down the
> line as things change in the generic parts of the code.
> 
> Stick to using the callbacks provided for their defined purpose and
> life will be easier.  It'll also be a lot easier to consolidate some
> of the crap we've accumulated across each platform if everyone's
> doing stuff in the same way.
> 
> And that's another reason to say no to this.  Please stop inventing new
> ways to do things unless you're prepared to provide it as a replacement
> for all the (ARM) platforms we have in the kernel.
Personally I do not change the current arm way

I init the timer during system_timer->init

I just the the early device their to pass the resources
but if switch all arm timer this way is fine to you I'm ready to do the whole
update

Best Regards,
J.
