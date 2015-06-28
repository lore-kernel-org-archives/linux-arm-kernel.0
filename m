From: s.munaut@whatever-company.com (Sylvain Munaut)
Date: Sun, 28 Jun 2015 22:32:41 +0200
Subject: dma-mapping: support for DMA_ATTR_NON_CONSISTENT DMA attribute
Message-ID: <CAF6-1L5c-PbK_wfpvz1xdRkquXyuQDv4mvKfYp8fwA1LK9ZOyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


I've found this patch from several month ago :

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/325489.html

And I find it very useful, but I couldn't find why it wasn't merged ?
What was the problem with it ?

In my use case, I need to allocate fairly large buffers (holding video
data) and the hardware requires them to be contiguous.

I ensure the consistency by using the DMA streaming API
(dma_sync_single_for_{cpu,device}) and so when the buffer is "owned"
by the CPU, I definitely want cached access because coherent memory
speed is just abysmal ... (about 10x slower to read the whole buffer
sequentially).

Since the buffer is > 4M, I can't rely on kmalloc or alloc_pages to
allocate it and dma_alloc_attrs with this patch applied does exactly
what I need.

Did I miss something ? Is there another way to do what I need ? (well
beside reimplementing the whole dma_alloc_attr logic myself ...)


Cheers,

    Sylvain
