From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 03 Feb 2010 10:19:33 -0500 (EST)
Subject: 32-bit Thumb-2 breakpoints
In-Reply-To: <1265209487.1970.42.camel@pc1117.cambridge.arm.com>
References: <20100203005038.GA16356@caradoc.them.org>
	<1265197942.1970.34.camel@pc1117.cambridge.arm.com>
	<20100203132824.GA27048@n2100.arm.linux.org.uk>
	<4B699010.6010203@parrot.com>
	<1265209487.1970.42.camel@pc1117.cambridge.arm.com>
Message-ID: <alpine.LFD.2.00.1002031017550.1681@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 3 Feb 2010, Catalin Marinas wrote:

> On Wed, 2010-02-03 at 15:02 +0000, Matthieu CASTET wrote:
> > Russell King - ARM Linux a ?crit :
> > > On Wed, Feb 03, 2010 at 11:52:22AM +0000, Catalin Marinas wrote:
> > >> On Wed, 2010-02-03 at 00:50 +0000, Daniel Jacobowitz wrote:
> > >>> On Tue, Feb 02, 2010 at 10:43:22PM +0000, Russell King - ARM Linux
> > >>> wrote:
> > >>>> Umm, today there were patches posted using hardware support for
> > >>>> breakpoints / watchpoints.  I've not read through those patches
> > >>>> yet, but in light of hardware support, do we really need this patch
> > >>>> anymore?
> > >>> Yes, it's unrelated.  Hardware breakpoints are a constrained resource,
> > >>> but we can insert unlimited software breakpoints (and often need to
> > >>> exceed the hardware breakpoint limit).
> > >> I agree, we still need support for software breakpoints.
> > >>
> > >> The main benefit of hardware debugging support is for watchpoints.
> > >
> > > Software breakpoints are a pain in the backside if you have threaded
> > > programs, because when you insert a breakpoint into one thread, it's
> > > active in all threads - you can't insert a breakpoint into only one
> > > thread.
> > 
> > An annoying things about software breakpoints is that gdb doesn't
> > understand arm kernel helper (for atomic operation/tls). And when it try
> > to set breakpoint here it fails...
> 
> That kernel helpers are in a page is not writable (or COW-able). Maybe
> with hardware breakpoints this could be solved.

This is a well known ABI on ARM, so IMHO gdb should simply manage to put 
a breakpoint right before or right after those helpers are invoked.


Nicolas
