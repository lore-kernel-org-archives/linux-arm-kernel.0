From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 16 Jun 2011 16:30:27 -0400 (EDT)
Subject: [PATCH] USB: ehci: use packed,aligned(4) instead of removing
	the packed attribute
In-Reply-To: <4DFA634D.6000907@ahsoftware.de>
Message-ID: <Pine.LNX.4.44L0.1106161626160.1697-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 Jun 2011, Alexander Holler wrote:

> > Hmmm.  I won't say that ((packed,aligned(4))) is wrong.  But it's not
> > clearly necessary either.
> 
> Maybe I should have added a "cosmetic:" in front of the subject of the 
> patch. ;)
> 
> Using packed doesn't seem to be necessary (at least not with those 
> versions of gcc I'm using here), I've tried both versions (on arm, 
> without packed and with packed, aligned(4)) and both are working. I've 
> only posted the patch because I found the usage of packed, aligned(4) 
> much clearer than without packed. And It might help avoiding such 
> discussions like this with people like me who aren't that deep involved 
> in gcc-specific implementation details. ;)
> 
> Anyway, feel free to nack that patch. I don't really care and just 
> thought I should post it (e.g. as an alternative to removing that packed).

There are other structures that need to avoid padding but aren't marked
((packed)), such as ehci_qtd and ehci_qh_hw in drivers/usb/host/ehci.h.  
I don't see why those in ehci_def.h should get special treatment.

Alan Stern
