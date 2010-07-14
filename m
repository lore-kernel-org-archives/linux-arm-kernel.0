From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 13 Jul 2010 23:25:24 -0400 (EDT)
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
Message-ID: <alpine.LFD.2.00.1007132253450.10598@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Jul 2010, Russell King - ARM Linux wrote:

> Things like a grand unification of the clk infrastructure, addruart,
> and boot interface all seem to be relatively minor things compared
> to determining whether platform support really benefits from DT,
> which is whole point of my statement on wanting to see a real
> implementation of it.

Well, I'm afraid we simply won't be able to see benefits until we have a 
full implementation.  But to have a full implementation, we still need 
to perform some preliminary work.  And that preliminary 
work is beneficial to the code whether or not DT is actually used in the 
end.  So this will be incremental.

> What I'm interested in its impact on the numerous board support files
> that we currently have - some 348 of them at the present time.  For
> example, currently these are used to provide small fragments of code
> to drivers to support what are effectively board quirks.  What I'm
> particularly interested in is how these quirks get attached to their
> relevant drivers - and whether this becomes easier with DT or harder
> with it.

My wish for all this DT work is actually _not_ to touch any of those 
existing 348 board support files.  I don't want DT to become a 
_replacement_ hardware config framework for ARM, but rather an 
_alternative_ method along with the existing one.  So the idea is 
actually to consider DT support just as another board with its own 
machine ID.  And to make things even more straight forward, I want to 
have a different machine ID for each SOC family to which DT support is 
added.  This way both the DT way and the traditional way can coexist and 
allow for easy testing, comparison, validation, and possibly transition 
for new targets in a non intrusive and disturbing way.

> If it makes this stuff simpler, then all well and good - it's a net
> benefit.  If it makes this a lot more complicated - eg, because we
> need to declare every bit of quirk code into some kind of table for
> DT to pick up and bind in some manner to a driver - then moving to
> DT will be a disaster for maintainability and readability, and we
> lose type checking on these quirk functions.

By keeping the traditional method around we'll be able to see whether or 
not DT is actually simpler.  I don't think anyone wants to maintain an 
ugly quirk table, and if DT ends up being so then people will simply 
continue using the current method.

> It's this area, and related areas to it that I'm really interested
> in, rather than these grand unification schemes which seem to be top
> priority at the moment.

Those grand unification schemes are due to an orthogonal issue which is 
to be able to support more than one SOC family with a single kernel 
binary, whether or not DT is used.  Of course DT support will benefit 
from that work too.

> What really concerns me at the moment is that there's soo much work
> being put into the peripheral DT issues without first answering the
> question about whether DT on ARM is viable by providing a working
> real complex platform implementation.

That might only happen incrementally with time.  Until then, as I said, 
the current work may only improve the kernel even without DT.


Nicolas
