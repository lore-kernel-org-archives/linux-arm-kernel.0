From: joro@8bytes.org ('Joerg Roedel')
Date: Fri, 29 Jul 2011 12:54:22 +0200
Subject: [RFC] ARM: dma_map|unmap_sg plus iommu
In-Reply-To: <001901cc4dd8$4afb4e40$e0f1eac0$%szyprowski@samsung.com>
References: <CAB-zwWjb+2ExjNDB3OtHmRmgaHMnO-VgEe9VZk_wU=ryrq_AGw@mail.gmail.com>
	<000301cc4dc4$31b53630$951fa290$%szyprowski@samsung.com>
	<20110729093555.GA13522@8bytes.org>
	<001901cc4dd8$4afb4e40$e0f1eac0$%szyprowski@samsung.com>
Message-ID: <20110729105422.GB13522@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 29, 2011 at 12:14:25PM +0200, Marek Szyprowski wrote:
> > This sounds rather hacky. How about partitioning the address space for
> > the device and give the dma-api only a part of it. The other parts can
> > be directly mapped using the iommu-api then.
> 
> Well, I'm not convinced that iommu-api should be used by the device drivers 
> directly. If possible we should rather extend dma-mapping than use such hacks.

Building this into dma-api would turn it into an iommu-api. The line
between the apis are clear. The iommu-api provides direct mapping
of bus-addresses to system-addresses while the dma-api puts a memory
manager on-top which deals with bus-address allocation itself.
So if you want to map bus-addresses directly the iommu-api is the way to
go. This is in no way a hack.

Regards,

	Joerg
