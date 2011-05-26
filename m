From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 May 2011 14:59:42 +0100
Subject: [PATCH 1/1] ARM: thumb: Have the machine name indicate
	operation in thumb mode.
In-Reply-To: <20110526135604.GA2119@arm.com>
References: <alpine.LFD.2.00.1105161008320.14430@xanadu.home>
	<20110516144311.GC7715@arm.com>
	<BANLkTik0LL+dFCo_H-YhF+BUOXyP7MAKzA@mail.gmail.com>
	<alpine.LFD.2.00.1105181803090.14430@xanadu.home>
	<20110518223319.GB21384@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1105181845540.14430@xanadu.home>
	<20110518225749.GF21384@n2100.arm.linux.org.uk>
	<BANLkTinS4XR-QrCsmhStROxkJEy1-PwCTA@mail.gmail.com>
	<20110526130104.GA5762@n2100.arm.linux.org.uk>
	<20110526135604.GA2119@arm.com>
Message-ID: <20110526135942.GJ24876@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 26, 2011 at 02:56:04PM +0100, Dave Martin wrote:
> On Thu, May 26, 2011 at 02:01:04PM +0100, Russell King - ARM Linux wrote:
> > On Wed, May 25, 2011 at 03:08:05PM -0700, Vadim Bendebury (??) wrote:
> > > On Wed, May 18, 2011 at 3:57 PM, Russell King - ARM Linux <
> > > linux at arm.linux.org.uk> wrote:
> > > > In which case I think we'll have to talk to kbuild people to get
> > > > mkcompile_h modified.  Also maybe asking what other architectures
> > > > do for this kind of problem may be a good idea - especially before
> > > > we start abusing and hacking stuff like the hardware name.
> > > 
> > > So, what would be an equivalent in other architectures to ask about - it
> > > seems that the ability to run in Thumb/ARM mode is fairly unique for ARM.
> > 
> > What about 32-bit vs 64-bit x86 ?
> 
> Thumb seems different because is is irrelevant to the kernel/user ABI
> (or, if it's not irrelevant, we have a bug somewhere...)
> 
> Documenting what ISA the kernel was built with is therefore similar to
> documenting what optimisation options were used -- i.e., it's interesting
> and occasionally useful for humans, but not something software should
> normally be querying or care about in any way.

In which case its a bit like exposing whether the kernel was built with
or without frame pointers, or which -O level, which compiler flags, etc.

I think its best therefore that it remains in the kernel config along
with all the other 'optimisation' settings.

We don't even need to print it in the oops report because that already
tells us what ISA we were executing as - and from that and the Code: line
we can imply the kernel build ISA.
