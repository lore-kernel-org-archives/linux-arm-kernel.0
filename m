From: jamie@shareable.org (Jamie Lokier)
Date: Mon, 11 Jan 2010 23:10:27 +0000
Subject: 32-bit Thumb-2 breakpoints
In-Reply-To: <20100111225436.GA7408@caradoc.them.org>
References: <20100111215816.GA1068@caradoc.them.org>
	<20100111223503.GD7925@n2100.arm.linux.org.uk>
	<20100111225436.GA7408@caradoc.them.org>
Message-ID: <20100111231027.GA30714@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Jacobowitz wrote:
> In the example from my mail:
> 
>    cmp   r0, r0
>    itt   eq
> A: cmpeq r0, r1
> B: moveq r0, r2
> C: nop
> 
> The cmpeq can be an adcs.w, eors.w, et cetera.  We're at A, trying to
> figure out whether to put a breakpoint on B or C (both of which could
> validly be branches).
>
> It's possible I've missed something obvious, of course!

I couldn't really tell from a quick glance at the net, which only
half-explained itt, so I'll ask some newbie-sounding questions just in
case it is something obvious.

Isn't the itt sequence for Thumb-2 supposed to be consistent with the
condition sequence for ARM, so that it should be:

    cmp   r0, r0
    itt   eq
 A: cmpeq r0, r1
 B: movne r0, r2   <- that is, ne not eq, because it's the "then" branch
 C: nop

And does the cmp at A really affect execution of the instructions at B
and C in a Thumb-2 itt sequence, rather than the condition being
checked once@the time of the itt instruction and played out for the
following 3 instructions?

Thanks,
-- Jamie
