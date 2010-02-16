From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 16 Feb 2010 19:10:45 +0530
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <201002161432.57705.oliver@neukum.org>
References: <20100208065519.GE1290@ucw.cz>
	<201002161007.20576.oliver@neukum.org>
	<20100216093946.GA13884@n2100.arm.linux.org.uk>
	<201002161432.57705.oliver@neukum.org>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF800B@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Oliver Neukum [mailto:oliver at neukum.org]
> Sent: Tuesday, February 16, 2010 7:03 PM
> To: Russell King - ARM Linux
> Cc: Shilimkar, Santosh; Catalin Marinas; Pavel Machek; Greg KH; Matthew Dharm; Sergei Shtylyov; Ming
> Lei; Sebastian Siewior; linux-usb at vger.kernel.org; linux-kernel; linux-arm-kernel; Mankad, Maulik
> Ojas
> Subject: Re: USB mass storage and ARM cache coherency
> 
> Am Dienstag, 16. Februar 2010 10:39:46 schrieb Russell King - ARM Linux:
> > However, because ARM CPUs can now speculatively prefetch, just leaving it
> > at that results in corruption of buffers used for DMA.  So we have to
> > invalidate DMA_FROM_DEVICE and DMA_BIDIRECTIONAL buffers on unmap to
> > ensure coherency with DMA operations.
> >
> > If the CPU writes to a DMA_FROM_DEVICE buffer between map and unmap, the
> > writes can sit in the cache, and on unmap, they will be discarded.
> >
> > Cleaning the cache on unmap is not an option; that too can lead to DMA
> > buffer corruption in the DMA case.
> 
> I am afraid for these controllers the controller driver must be responsible
> for all DMA and cache issues. Indicating the exact requirements to the
> upper layer would be a battle already lost.
> so the safe choice is not to set has_dma and the generic layer will leave
> the issue to the lower level.
This means don't use dma at all which will almost kill the performance.

Regards,
Santosh
