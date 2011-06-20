From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 20 Jun 2011 14:57:29 -0400 (EDT)
Subject: [PATCH] USB: ehci: use packed,aligned(4) instead of removing
	the packed attribute
In-Reply-To: <4DFF9568.8030704@ahsoftware.de>
Message-ID: <Pine.LNX.4.44L0.1106201455460.2113-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Jun 2011, Alexander Holler wrote:

> Am 20.06.2011 20:39, schrieb Alan Stern:
> > On Mon, 20 Jun 2011, Alexander Holler wrote:
> >
> >> I see it that way: packed is needed to be sure that at least for struct
> >> ehci_regs there are no padding bytes inbetween the members.
> >
> > But is it _really_ needed?
> >
> >> It might
> >> work without, but that depends on the compiler (-version, architecture,
> >> whatever).
> >
> > Have there _ever_ been _any_ combinations of compiler, version,
> > architecture, whatever, that had unwanted padding bytes in this
> > structure?
> 
> I don't know. But if there would be no doubts, this discussion would not 
> happen and I assume there never would have been an attribute packed there.

Don't be so sure.  That is very old code; the attribute could easily 
have been present for no good reason.

Alan Stern
