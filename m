From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Mar 2010 20:30:51 +0000
Subject: [PATCH] ARM support single byte cmpxchg and cmpxchg_local on ARMv6
In-Reply-To: <20100310200235.GA29827@Krystal>
References: <20100310162221.GA19201@localhost>
	<20100310173503.GC12345@n2100.arm.linux.org.uk>
	<20100310200235.GA29827@Krystal>
Message-ID: <20100310203051.GF12345@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 10, 2010 at 03:02:36PM -0500, Mathieu Desnoyers wrote:
> * Russell King - ARM Linux (linux at arm.linux.org.uk) wrote:
> > On Wed, Mar 10, 2010 at 06:22:21PM +0200, Imre Deak wrote:
> > > recently you've added support for __cmpxchg for ARMv6+. There the assumption
> > > is that ldrex[bh]/strex[bh] is only supported on platforms with the 32v6K
> > > extension.
> > > 
> > > Currently the __xchg code uses these even without the extension. Should this
> > > be fixed?
> > 
> > From what I remember, the half-word versions definitely aren't supported
> > on anything without V6K extensions.  I think that the byte and word
> > versions are supported on V6 and up though.
> > 
> > That'd make both __cmpxchg and __xchg slightly buggy, in different ways.
> > 
> > What it does mean is that atomic operations on unsigned shorts using
> > ldrex/strex will only be possible on V6K and up.
> 
> Does the following help (addressing the single byte cmpxchg part of the
> problem) ?

First I'd need to look up what the real conditions are on the ldrex
instructions - which I'm not doing at the moment on account of being
down with the lurgy this week...
