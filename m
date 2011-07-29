From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 29 Jul 2011 12:14:25 +0200
Subject: [RFC] ARM: dma_map|unmap_sg plus iommu
In-Reply-To: <20110729093555.GA13522@8bytes.org>
References: <CAB-zwWjb+2ExjNDB3OtHmRmgaHMnO-VgEe9VZk_wU=ryrq_AGw@mail.gmail.com>
	<000301cc4dc4$31b53630$951fa290$%szyprowski@samsung.com>
	<20110729093555.GA13522@8bytes.org>
Message-ID: <001901cc4dd8$4afb4e40$e0f1eac0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Friday, July 29, 2011 11:36 AM Joerg Roedel wrote:

> On Fri, Jul 29, 2011 at 09:50:32AM +0200, Marek Szyprowski wrote:
> > On Thursday, July 28, 2011 11:10 PM Ramirez Luna, Omar wrote:
> 
> > > 2. tidspbridge driver sometimes needs to map a physical address into a
> > > fixed virtual address (i.e. the start of a firmware section is expected to
> > > be at dsp va 0x20000000), there is no straight forward way to do this with
> > > the dma api given that it only expects to receive a cpu_addr, a sg or a
> > > page, by adding iov_address I could pass phys and iov addresses in a sg
> > > and overcome this limitation, but, these addresses belong to:
> >
> > We also encountered the problem of fixed firmware address. We addressed is
by
> > setting io address space start to this address and letting device driver to
> > rely on the fact that the first call to dma_alloc() will match this address.
> 
> This sounds rather hacky. How about partitioning the address space for
> the device and give the dma-api only a part of it. The other parts can
> be directly mapped using the iommu-api then.

Well, I'm not convinced that iommu-api should be used by the device drivers 
directly. If possible we should rather extend dma-mapping than use such hacks.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
