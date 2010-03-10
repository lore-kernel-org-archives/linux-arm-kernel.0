From: jamie@shareable.org (Jamie Lokier)
Date: Wed, 10 Mar 2010 23:16:26 +0000
Subject: __xchg for sizes other than 32bit
In-Reply-To: <20100310173503.GC12345@n2100.arm.linux.org.uk>
References: <20100310162221.GA19201@localhost>
	<20100310173503.GC12345@n2100.arm.linux.org.uk>
Message-ID: <20100310231626.GB11663@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Wed, Mar 10, 2010 at 06:22:21PM +0200, Imre Deak wrote:
> > recently you've added support for __cmpxchg for ARMv6+. There the assumption
> > is that ldrex[bh]/strex[bh] is only supported on platforms with the 32v6K
> > extension.
> > 
> > Currently the __xchg code uses these even without the extension. Should this
> > be fixed?
> 
> >From what I remember, the half-word versions definitely aren't supported
> on anything without V6K extensions.  I think that the byte and word
> versions are supported on V6 and up though.
> 
> That'd make both __cmpxchg and __xchg slightly buggy, in different ways.
> 
> What it does mean is that atomic operations on unsigned shorts using
> ldrex/strex will only be possible on V6K and up.

It's possible to emulate 16-bit cmpxchg using 32-bit cmpxchg.

xchg can't be emulated with wider xchg, but of course it can use wider
cmpxchg in a loop.

That sort of thing probably should be in asm-generic somewhere.

-- Jamie
