From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Wed, 14 Jul 2010 12:11:52 +0800
Subject: [RFC,PATCH 0/2] Allow late mdesc detection
In-Reply-To: <20100713093346.GC20590@n2100.arm.linux.org.uk>
References: <1278903792.387175.713057245098.0.gpush@pororo>
	<alpine.LFD.2.00.1007112334390.10598@xanadu.home>
	<1278921935.9235.90.camel@pororo.lan>
	<alpine.LFD.2.00.1007120904240.10598@xanadu.home>
	<AANLkTikXejaVsFsudO3ABKzR80V6yCBHm7c6y32hurdt@mail.gmail.com>
	<20100713072848.GC19839@n2100.arm.linux.org.uk>
	<1279011746.2521.394.camel@pororo.lan>
	<20100713093346.GC20590@n2100.arm.linux.org.uk>
Message-ID: <1279080712.15089.53.camel@pororo.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> What I'm interested in its impact on the numerous board support files
> that we currently have - some 348 of them at the present time.  For
> example, currently these are used to provide small fragments of code
> to drivers to support what are effectively board quirks.  What I'm
> particularly interested in is how these quirks get attached to their
> relevant drivers - and whether this becomes easier with DT or harder
> with it.
> 
> If it makes this stuff simpler, then all well and good - it's a net
> benefit.  If it makes this a lot more complicated - eg, because we
> need to declare every bit of quirk code into some kind of table for
> DT to pick up and bind in some manner to a driver - then moving to
> DT will be a disaster for maintainability and readability, and we
> lose type checking on these quirk functions.

OK, I'll do some work to get the mx51 port improved, with a particular
focus on demonstrating how the board-specific stuff can be handled.

However, we still have a bit of a chicken-and-egg problem here - in
order to properly demonstrate what the DT will mean for board support
(ie, years down the line), we'd need a larger base of machines ported to
DT. I don't see people committing to that work if it may be thrown away
if we don't end up using the DT approach.

Perhaps we could provide information in two different ways - first, the
mx51 and versatile ports as an example of how specific things are done
with the DT, and we can chat separately about what you'd like to know
about the overall architectural stuff, which can't really be covered in
the single-board ports.

> It's this area, and related areas to it that I'm really interested
> in, rather than these grand unification schemes which seem to be top
> priority at the moment.

A lot of the unification work is separate from the DT - Nicolas and Eric
are working on general kernel consolidation stuff, which is intended to
be useful without the DT. At present (and as far as I know), Grant and I
are the only ones doing DT-specific infrastructure changes for ARM.

> What really concerns me at the moment is that there's soo much work
> being put into the peripheral DT issues without first answering the
> question about whether DT on ARM is viable by providing a working
> real complex platform implementation.

They're not all peripheral DT issues, more "core design" of DT on ARM.
For example, if there's no way to have a common clk, the DT stuff gets a
lot harder.  I'm trying to get some of those issues sorted (in a way
that is useful even without the DT work) in the process of my overall
porting.

But yeah, I understand that these don't really help you with evaluating
DT on ARM, they're more for my own benefit to work out the issues we'll
face doing the work. As these are being resolved, I'm getting closer to
demonstratable stuff without gross hacks :)

Cheers,


Jeremy
