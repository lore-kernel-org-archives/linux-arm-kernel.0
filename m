From: oliver@neukum.org (Oliver Neukum)
Date: Tue, 16 Feb 2010 15:22:38 +0100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF8038@dbde02.ent.ti.com>
References: <20100208065519.GE1290@ucw.cz>
	<201002161446.59920.oliver@neukum.org>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C3CF8038@dbde02.ent.ti.com>
Message-ID: <201002161522.38467.oliver@neukum.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 16. Februar 2010 15:12:45 schrieb Shilimkar, Santosh:
> > > > I am afraid for these controllers the controller driver must be responsible
> > > > for all DMA and cache issues. Indicating the exact requirements to the
> > > > upper layer would be a battle already lost.
> > > > so the safe choice is not to set has_dma and the generic layer will leave
> > > > the issue to the lower level.
> > > This means don't use dma at all which will almost kill the performance.
> > 
> > Why would you be unable to map a buffer in the hcd driver when you know
> > that you'll use DMA?
> Probably it can be. The USB stack has the dma maintenance code at common 
> place for all controllers and hence we were just trying to see if there is 
> way to handle that way.

This is true. If you can find a clean way to describe your requirements
to the generic layer, that would be better. The problem is that we must
not end up with a dozen flags.

Your original patch however kills ehci, ohci and uhci on some architectures.

	Regards
		Oliver
