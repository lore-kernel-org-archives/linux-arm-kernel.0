From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 21 Jun 2011 10:58:19 -0400 (EDT)
Subject: [PATCH] USB: ehci: use packed,aligned(4) instead of removing
	the packed attribute
In-Reply-To: <alpine.LFD.2.00.1106201824320.2142@xanadu.home>
Message-ID: <Pine.LNX.4.44L0.1106211054460.2327-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Jun 2011, Nicolas Pitre wrote:

> > We don't fall into any of these cases, and therefore as you say, we
> > don't need packed.  Arnd and I have both explained this.  So why do you 
> > keep arguing that we do need it?
> 
> Please show me where I keep arguing that you need it?

Not explicitly perhaps.  But you did write:

> Doesn't mean that because it used to work that it is strictly correct.  
> Wouldn't be the first time that a GCC upgrade broke the kernel because 
> the kernel wasn't describing things properly enough.

which strongly implies that "packed" is needed.  You also wrote:

> Yes, but that's a consequence of not being able to access those fields 
> in their naturally aligned position anymore.  Hence the addition of the 
> align attribute to tell the compiler that we know that the structure is 
> still aligned to a certain degree letting the compiler to avoid 
> byte-oriented instructions when possible.

which is predicated on the assumption that "packed" is needed.

Alan Stern
