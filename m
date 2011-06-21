From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 21 Jun 2011 11:06:37 -0400 (EDT)
Subject: [PATCH] USB: ehci: use packed,aligned(4) instead of removing
	the packed attribute
In-Reply-To: <alpine.LFD.2.00.1106201653450.2142@xanadu.home>
Message-ID: <Pine.LNX.4.44L0.1106211058250.2327-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Jun 2011, Nicolas Pitre wrote:

> On Mon, 20 Jun 2011, Alan Stern wrote:
> 
> > On Mon, 20 Jun 2011, Nicolas Pitre wrote:
> > 
> > > > As far as I can tell, the other structures in ehci.h have 
> > > > ((aligned(32)) simply in order to save space, since there can be large 
> > > > numbers of these structures allocated.
> > > 
> > > How can increasing the alignment to 32 bytes save space?
> > 
> > No, no -- the alignment is _decreased_ to 32 bits.  Without the 
> > attribute the alignment would have been 64 bits.
> 
> The aligned attribute requires a byte value not a bit value.
> Maybe what you meant is ((aligned(4)) ?

Ah, very good point!  No, I meant ((aligned(32))).  Do "grep aligned 
drivers/usb/host/ehci.h" and you'll see.

So my understanding was wrong; these structure really are being forced 
to a strict alignment.  And indeed, now that I go back and look at the 
EHCI spec, it turns out that this alignment is required by the 
hardware.

Okay, so this digression was irrelevant to our discussion.  Forget I 
mentioned it...

Alan Stern
