From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Jan 2010 23:15:37 +0000
Subject: 32-bit Thumb-2 breakpoints
In-Reply-To: <20100111231027.GA30714@shareable.org>
References: <20100111215816.GA1068@caradoc.them.org>
	<20100111223503.GD7925@n2100.arm.linux.org.uk>
	<20100111225436.GA7408@caradoc.them.org>
	<20100111231027.GA30714@shareable.org>
Message-ID: <20100111231536.GH7925@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 11:10:27PM +0000, Jamie Lokier wrote:
> Daniel Jacobowitz wrote:
> > In the example from my mail:
> > 
> >    cmp   r0, r0
> >    itt   eq
> > A: cmpeq r0, r1
> > B: moveq r0, r2
> > C: nop
> > 
> > The cmpeq can be an adcs.w, eors.w, et cetera.  We're at A, trying to
> > figure out whether to put a breakpoint on B or C (both of which could
> > validly be branches).
> >
> > It's possible I've missed something obvious, of course!
> 
> I couldn't really tell from a quick glance at the net, which only
> half-explained itt, so I'll ask some newbie-sounding questions just in
> case it is something obvious.

itt = if then then. (if condition met, execute following two instructions)
ite = if then else. (if condition met, execute following instruction,
  otherwise execute the instruction following _that_ instruction.)

The CPSR records the IT state.
