From: public_filter@yahoo.com (P F)
Date: Wed, 15 Sep 2010 17:25:38 -0700 (PDT)
Subject: [RFC] mmaping with VIVT cache
Message-ID: <831453.93557.qm@web120220.mail.ne1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

--- On Tue, 9/14/10, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> The fact is that mapping buffers as cacheable into
> userspace on non-
> coherent architectures _will_ result in the cache contents
> getting in
> the way of updates to the DMA'd buffer.? It's a
> fundamental property
> of such hardware implementations.

Thank you for the explanation.

I realize this is driver specific, but I would like to confirm that your
explanation matches my problem.  Unless I misunderstand the UVC driver,
the buffer which is mapped into userspace is distinct from the one which
is updated by DMA.

The mmap'd buffer is allocated by vmalloc_32(), and later mapped with
vmalloc_to_page()/vm_insert_page().  The DMA'd buffer is allocated by
usb_buffer_alloc().  At the appropriate time, the DMA'd buffer is
memcpy()'d into the mmap'd buffer, and userspace is allowed to handle it,
at which point it is corrupt.

Is this scenario consistent with your above explanation, or does your explanation require that the mmap'd buffer and DMA'd buffer be one and
the same?



      
