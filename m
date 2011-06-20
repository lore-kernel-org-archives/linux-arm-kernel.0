From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 20 Jun 2011 18:36:18 -0400 (EDT)
Subject: [PATCH] USB: ehci: use packed, aligned(4) instead of removing the
	packed attribute
In-Reply-To: <Pine.LNX.4.44L0.1106201640290.2113-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1106201640290.2113-100000@iolanthe.rowland.org>
Message-ID: <alpine.LFD.2.00.1106201653450.2142@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Jun 2011, Alan Stern wrote:

> On Mon, 20 Jun 2011, Nicolas Pitre wrote:
> 
> > > As far as I can tell, the other structures in ehci.h have 
> > > ((aligned(32)) simply in order to save space, since there can be large 
> > > numbers of these structures allocated.
> > 
> > How can increasing the alignment to 32 bytes save space?
> 
> No, no -- the alignment is _decreased_ to 32 bits.  Without the 
> attribute the alignment would have been 64 bits.

The aligned attribute requires a byte value not a bit value.
Maybe what you meant is ((aligned(4)) ?


Nicolas
