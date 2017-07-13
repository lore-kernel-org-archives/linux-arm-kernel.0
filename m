From: michael.moese@men.de (michael.moese at men.de)
Date: Thu, 13 Jul 2017 12:00:31 +0200
Subject: i.MX 6 and PCIe DMA issues
In-Reply-To: <20170713090423.GA31807@n2100.armlinux.org.uk>
References: <04e1d18a504a477b84f5a9ec661dc9ae@MEN-EX01.intra.men.de>
 <5235ccf4-9dc2-a4aa-280b-18a0ab5a42bf@arm.com>
 <20170713070718.GA3871@mmlinux>
 <20170713090423.GA31807@n2100.armlinux.org.uk>
Message-ID: <20170713100031.GA31131@mmlinux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 10:04:23AM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 13, 2017 at 09:07:19AM +0200, michael.moese at men.de wrote:
> > Ok, I hope I am correct. I alloc my memory using dma_alloc_coherent()
> > once, the dma_handle is passed to the device, with no other dma_map*()
> > or dma_sync_*() calls needed?
> 
> Correct.
Great. Thanks for the clarification. I will make sure the usage is done
the right way.

> You must always use the two addresses returned from dma_alloc_coherent()
> and never try to translate them - the DMA address is for programming
> into the hardware, and the virtual address for CPU accesses.  If you do
> try to pass these to the various translators (like virt_to_phys()) the
> result is undefined.

I was trying to just print some addresses for debugging. I removed this
again. I'm just confused, because the DMA device address seems to be the
physical one. At least the memory contains my data. The virtual memory
contains different data. 

Could it be possible this mapping on my board is going wrong?

Michael
