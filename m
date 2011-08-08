From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Aug 2011 16:29:52 +0100
Subject: [RFC] ARM: dma_map|unmap_sg plus iommu
In-Reply-To: <CAB-zwWj-VCWQ6h8wjv7owG7n7p59Ep4qXiQY3LruT64sikuSKg@mail.gmail.com>
References: <CAB-zwWjb+2ExjNDB3OtHmRmgaHMnO-VgEe9VZk_wU=ryrq_AGw@mail.gmail.com>
	<000301cc4dc4$31b53630$951fa290$%szyprowski@samsung.com>
	<20110729093555.GA13522@8bytes.org>
	<001901cc4dd8$4afb4e40$e0f1eac0$%szyprowski@samsung.com>
	<20110729105422.GB13522@8bytes.org>
	<004201cc4dfb$47ee4770$d7cad650$%szyprowski@samsung.com>
	<CAHQjnOM58AReFuDpcSjHvNP2UZX1ZUeuWyfWCG6Ayxdfj4QE7w@mail.gmail.com>
	<CAB-zwWj-VCWQ6h8wjv7owG7n7p59Ep4qXiQY3LruT64sikuSKg@mail.gmail.com>
Message-ID: <20110808152952.GA19367@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 08, 2011 at 10:21:46AM -0500, Ramirez Luna, Omar wrote:
> Hi,
> 
> On Sun, Jul 31, 2011 at 7:57 PM, KyongHo Cho <pullip.cho@samsung.com> wrote:
> > On Fri, Jul 29, 2011 at 11:24 PM, Marek Szyprowski
> ...
> >> Right now I have no idea how to handle this better. Perhaps with should be
> >> possible
> >> to specify somehow the target dma_address when doing memory allocation, but I'm
> >> not
> >> really convinced yet if this is really required.
> >>
> > What about using 'dma_handle' argument of alloc_coherent callback of
> > dma_map_ops?
> > Although it is an output argument, I think we can convey a hint or
> > start address to map
> > to the IO memory manager that resides behind dma API.
> 
> I also thought on this one, even dma_map_single receives a void *ptr
> which could be casted into a struct with both physical and virtual
> addresses to be mapped, but IMHO, this starts to add twists into the
> dma map parameters which might create confusion.

No - don't even consider that.  That's highly non-standard usage and
it'll break all existing drivers to do so.
