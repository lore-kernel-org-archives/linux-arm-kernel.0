From: michael.moese@men.de (michael.moese at men.de)
Date: Fri, 14 Jul 2017 13:07:37 +0200
Subject: i.MX 6 and PCIe DMA issues
In-Reply-To: <37eec44d-2157-1f11-681f-7fbc50983d62@arm.com>
References: <04e1d18a504a477b84f5a9ec661dc9ae@MEN-EX01.intra.men.de>
 <5235ccf4-9dc2-a4aa-280b-18a0ab5a42bf@arm.com>
 <20170713070718.GA3871@mmlinux>
 <37eec44d-2157-1f11-681f-7fbc50983d62@arm.com>
Message-ID: <20170714110737.GA17229@mmlinux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 03:57:19PM +0100, Robin Murphy wrote:
> >> I don't much like the sound of that "and" there - coherent DMA
> >> allocations are, as the name implies, already coherent for CPU and DMA
> >> accesses, and require no maintenance; the streaming DMA API
> >> (dma_{map,unmap,sync}_*) on the other hand is *only* for use on
> >> kmalloced memory.
I removed all the calls to dma_{map,unmap,sync}_* and took special care
on the handling of the dma_attr_t's. I now dma_alloc_coherent my memory,
and do nothing else with the dma_attr_t's. It seems to work, at least
partly, now. I had to grab a newer board, because we killed it while
soldering wires to trace PCI Express traffic.

Maybe I had some weird old CPU or some strange U-Boot or I simply missed
removing all dma_sync_* calls or similar before.

Now I got other issues, but at least the DMA seems to be working now.
Thanks to you, I think I understood this topic now, thank you.

Now I can try to figure out why a read to the PCI Express may stop all
traffic - that's a different story.


Thanks,
Michael
