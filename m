From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Jan 2012 12:23:36 +0000
Subject: [RFC PATCH 0/5] ARM: introducing DT topology
In-Reply-To: <20120119121832.GD9268@arm.com>
References: <1326897408-11204-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20120118162423.GK1068@n2100.arm.linux.org.uk>
 <20120118175028.GD9691@e102568-lin.cambridge.arm.com>
 <20120118180453.GN1068@n2100.arm.linux.org.uk>
 <20120119121832.GD9268@arm.com>
Message-ID: <20120119122336.GY1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2012 at 12:18:32PM +0000, Catalin Marinas wrote:
> On Wed, Jan 18, 2012 at 06:04:53PM +0000, Russell King - ARM Linux wrote:
> > On Wed, Jan 18, 2012 at 05:50:28PM +0000, Lorenzo Pieralisi wrote:
> > > > This sounds like you're saying that the contents of MPIDR might be buggy
> > > > sometime in the future?  Do we actually know of any situations where the
> > > > information in there is currently wrong (outside of the development lab)?
> > > > If not, it's not something we should cater for until it's actually happened,
> > > > and then the pain should be felt by those silly enough to allow the chip
> > > > to go out the door.
> > > 
> > > I share your view Russell. Having said that: MPIDR is IMPLEMENTATION DEFINED.
> > 
> > I'll assume you mean that it's left to the implementation to set MPIDR
> > appropriately, and you're expecting implementations to make mistakes
> > with it.
> 
> I think what Lorenzo means is that MPIDR is indeed a mandated register
> with certain bits specified by the ARM ARM. However, the affinity bits
> are left to the implementation. The ARM ARM makes recommendations and
> gives some examples but they are not mandatory. An implementer is under
> no legal obligation to follow the examples. It is not that unlikely that
> someone in the future may use a different cluster/processor counting
> scheme than ours. Also in the context of virtualisation, the lower
> affinity field may be used for virtual CPUs counting).

So what you're saying is that the definition of this register has become
soo loose that it's completely useless.  Oh what a really great move.

Your designers really need their heads bashed against a brick wall to
knock some sense into them over stuff like this.  It's exactly this
kind of idiotic 'infinite flexibility' that Linus had a moan about
last year.

What it means is that we need _more_ code to support whatever
manufacturers come up in their scheme of things - rather than having
a standard way to represent these details, which software can parse
in a consistent way.

Instead, we have something that's effectively mandated to be present
but is basically useless because no software can parse it properly
without specific information from the manufacturer, and even then
its not guaranteed.

Well done ARM Ltd.  Again.

Stop doing this.
