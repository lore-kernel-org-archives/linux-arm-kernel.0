From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 21 Nov 2012 11:57:58 -0500
Subject: [PATCH] Dove: Attempt to fix PMU/RTC interrupts
In-Reply-To: <20121121165353.GP3290@n2100.arm.linux.org.uk>
References: <20121118162944.GV3290@n2100.arm.linux.org.uk>
 <20121121155946.GU10259@lunn.ch>
 <20121121165353.GP3290@n2100.arm.linux.org.uk>
Message-ID: <20121121165758.GA15800@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 04:53:53PM +0000, Russell King - ARM Linux wrote:
> On Wed, Nov 21, 2012 at 04:59:46PM +0100, Andrew Lunn wrote:
> > On Sun, Nov 18, 2012 at 04:29:44PM +0000, Russell King - ARM Linux wrote:
> > > Fix the acknowledgement of PMU interrupts on Dove: some Dove hardware
> > > has not been sensibly designed so that interrupts can be handled in a
> > > race free manner.  The PMU is one such instance.
> > 
> > Hi Russel
> > 
> > I checked with Marvell. They confirmed there is no race free way to
> > clear these interrupts :-(
> 
> That's what I thought given how the hardware behaves and what the
> documentation says.  So the best we can do is to ensure that the window
> between reading and writing is as small as possible.  Not perfect but
> it's the best we can do with the buggy hardware we have. :(

Russell,

I'll go ahead and pull this in to mvebu/fixes and flag it for stable.

thx,

Jason.
