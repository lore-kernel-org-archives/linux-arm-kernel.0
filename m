From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 06 Apr 2011 22:55:30 -0400 (EDT)
Subject: [PATCH 1/2] ARM: Differentiate SheevaPlugs and DockStars on the
	basis of the memory size.
In-Reply-To: <4D9CF5B3.9020007@ahsoftware.de>
References: <1302122121-3652-1-git-send-email-holler@ahsoftware.de>
	<1302122121-3652-2-git-send-email-holler@ahsoftware.de>
	<alpine.LFD.2.00.1104061739100.28032@xanadu.home>
	<4D9CED15.2010806@ahsoftware.de>
	<alpine.LFD.2.00.1104061850410.28032@xanadu.home>
	<4D9CF5B3.9020007@ahsoftware.de>
Message-ID: <alpine.LFD.2.00.1104062228410.28032@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Apr 2011, Alexander Holler wrote:

> > > So I don't think this in any way a fragile hack.
> > 
> > Determining a machine type based on its amount of RAM is fragile, ugly
> > and sets up a bad example for even more hacky tricks like this to crop
> > up. If someone is experimenting with his SheevaPlug by giving different
> > memory information in the kernel cmdline e.g. to create memory holes in
> > order to test some memory allocator changes, then the kernel may think
> > that it is not running on a SheevaPlug but a DockStar, and the resulting
> > behavior will certainly be unexpected.
> 
> People doing such should now what they do. And the pr_info() in the
> "abomination" should be enough to give those experimenters a hint (if it is
> missing or new).

They shouldn't have to.  We have a well defined system to identify 
machines/platforms with a unique number already.  It is completely 
unambiguous.  What you're proposing is to break that system.

The proper way to go about this rationalization is to move that stuff 
over to device tree.

> > > Anyway, it was just a suggestion.
> > 
> > Better luck next time.
> 
> Sorry, I don't feel the need to waste my time prodcuing patches to get them
> called "abominations". Which means my willingness to post further patches just
> got below zero.

I'm sorry if you feel like that.  You shouldn't take this too personal.  
It is not like if I qualified _you_ as a moron and a pariah (yes this 
happened to me last week from our master penguin himself).


Nicolas
