From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 11 Jun 2010 13:15:45 +0100
Subject: kmalloc/__get_free_pages and SHMLBA
Message-ID: <20100611120841.GF4403@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm writing a driver at the moment that mmap()'s a buffer into userspace and
then performs DMA from the kernel buffer into the device. If I allocate with
kmalloc()/__get_free_pages() is there anything that can be done to guarantee
that the allocation is aligned to SHMLBA or do I need to try overallocating
and do this myself?

The alternative is to use vmalloc_user() and use vmalloc_to_page() to get the
direct mapping addresses to perform the DMA mapping but I'd like to be able to
DMA the whole buffer without the need for scatterlists.

Jamie
