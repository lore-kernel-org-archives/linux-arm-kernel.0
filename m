From: s.munaut@whatever-company.com (Sylvain Munaut)
Date: Mon, 29 Jun 2015 07:24:15 +0200
Subject: dma-mapping: support for DMA_ATTR_NON_CONSISTENT DMA attribute
In-Reply-To: <20150628224543.GW7557@n2100.arm.linux.org.uk>
References: <CAF6-1L5c-PbK_wfpvz1xdRkquXyuQDv4mvKfYp8fwA1LK9ZOyw@mail.gmail.com>
 <20150628224543.GW7557@n2100.arm.linux.org.uk>
Message-ID: <CAF6-1L4g0W6kboZt52fHBUPxGYWYn9-9vmm=0-WQVv1-YdfOEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


> ... and then using the *streaming* API dma_sync_* calls on it.  That
> is invalid, and will lead to undefined results on implementations of
> dma_alloc_coherent() which return remapped memory (as for older ARMs.)
> This is an abuse of the API.

Ok, fine, but then

_How_ do I do it properly ?  From a driver module, how do I allocate a
large chunk ( > 4M so no alloc_pages and no kmalloc ) of contiguous
memory that's cacheable and that I can use with the streaming API ?


Or alternatively, what are the correct "sync points" that the doc refers to ?

""" By using this API, you are guaranteeing to the platform that you
have all the correct and necessary sync points for this memory in the
driver should it choose to return non-consistent memory."""

I had assumed it was the dma_sync_* calls, but apparently not.


Cheers,

   Sylvain
