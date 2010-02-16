From: oliver@neukum.org (Oliver Neukum)
Date: Tue, 16 Feb 2010 14:46:59 +0100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF800B@dbde02.ent.ti.com>
References: <20100208065519.GE1290@ucw.cz>
	<201002161432.57705.oliver@neukum.org>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C3CF800B@dbde02.ent.ti.com>
Message-ID: <201002161446.59920.oliver@neukum.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 16. Februar 2010 14:40:45 schrieb Shilimkar, Santosh:
> > > If the CPU writes to a DMA_FROM_DEVICE buffer between map and unmap, the
> > > writes can sit in the cache, and on unmap, they will be discarded.
> > >
> > > Cleaning the cache on unmap is not an option; that too can lead to DMA
> > > buffer corruption in the DMA case.
> > 
> > I am afraid for these controllers the controller driver must be responsible
> > for all DMA and cache issues. Indicating the exact requirements to the
> > upper layer would be a battle already lost.
> > so the safe choice is not to set has_dma and the generic layer will leave
> > the issue to the lower level.
> This means don't use dma at all which will almost kill the performance.

Why would you be unable to map a buffer in the hcd driver when you know
that you'll use DMA?

	Regards
		Oliver
