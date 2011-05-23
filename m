From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 May 2011 16:52:28 +0200
Subject: Updated mach-types update
In-Reply-To: <20110522091136.GC17672@n2100.arm.linux.org.uk>
References: <20110320110322.GC16646@n2100.arm.linux.org.uk>
	<BANLkTi=buKPmceOhF=SU6kkYRPxsJMn6hA@mail.gmail.com>
	<20110522091136.GC17672@n2100.arm.linux.org.uk>
Message-ID: <201105231652.28497.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 22 May 2011, Russell King - ARM Linux wrote:
> On Sat, May 21, 2011 at 09:35:29AM +0800, Jaya Kumar wrote:
> > On Sun, Mar 20, 2011 at 7:03 PM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > >
> > > What this means is that any platform in the machine database which has not
> > > been submitted to mainline for 12 months since it was registered will be
> > > automatically dropped from the file, and the platform maintainer will need
> > > to either talk to me to get it reinstated before submission, or update the
> > > entry in some way to 'freshen' it.
> >
> > Apologies, I just realized this patch removed an entry for a board I
> > am working with. Could you reinstate the following entry:
> > 
> > 2363          WAYLAND         wayland         Ofer Zaarur
> > 
> > I plan to submit support for this board as soon as I can.
> 
> I'm not sure how that squares with Linus' complaint during the last merge
> window - I'm currently nervous about sending Linus updates to mach-types
> as it is.  Maybe our new sub-architecture people can comment on their
> perception of the situation with new board support.

We discussed this in Budapest and basically agreed that we wouldn't stop
new board numbers and board files from being added until there is
enough infrastructure present to add new boards with the device tree
only. I would certainly not stop anyone from adding new boards in the
current merge window, or probably the next one.

However, for each subarchitecture that has gains support for device
tree probing, I would no longer add any new boards, and also not add
new subarchitectures that require board files.

Since we are not planning to enforce removal of board files any time
soon, I think we should also keep maintaining the mach-types for
now, including updates. If you are worried about Linus complaining
about it, I guess we can add arch/arm/tools/ to the files that we
maintain along with mach-* and plat-*.

	Arnd
