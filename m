From: s.munaut@whatever-company.com (Sylvain Munaut)
Date: Mon, 29 Jun 2015 15:22:38 +0200
Subject: dma-mapping: support for DMA_ATTR_NON_CONSISTENT DMA attribute
In-Reply-To: <20150629100804.GA7557@n2100.arm.linux.org.uk>
References: <CAF6-1L5c-PbK_wfpvz1xdRkquXyuQDv4mvKfYp8fwA1LK9ZOyw@mail.gmail.com>
 <20150628224543.GW7557@n2100.arm.linux.org.uk>
 <CAF6-1L4g0W6kboZt52fHBUPxGYWYn9-9vmm=0-WQVv1-YdfOEA@mail.gmail.com>
 <5590E962.4020700@topic.nl>
 <CAF6-1L584tp5o8U7S-w4-_XSjH4uXdMJSY89grLyFuwrJF3UyA@mail.gmail.com>
 <20150629100804.GA7557@n2100.arm.linux.org.uk>
Message-ID: <CAF6-1L4Lt2wH8fmUQv=p4M8GAQ0bdMZGkr8CiiZfyaJo15w+tQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,


On Mon, Jun 29, 2015 at 12:08 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jun 29, 2015 at 12:05:09PM +0200, Sylvain Munaut wrote:
>> Well that can't be since the dma_sync_* are part of streaming API and
>> the dma_alloc_attrs is part of the "coherent" API (even though you
>> have the NON_COHERENT flag in it ... that's a bit weird).
>>
>> But I don't see the alternative, unless the doc is suggesting I
>> basically do all the cache invalidation myself manually and doing arch
>> specific stuff directly in the driver ?
>
> Maybe someone with this problem should work on a solution - augmenting
> the coherent API with a set of functions to do what you want?
>
> Please, if you find something lacking like this, make a proposal and
> send a patch - but bear in mind that such an extension is not a matter
> for just ARM, but every other architecture that the kernel supports,
> so merely sending it to ARM mailing lists isn't going to get you very
> far.

I think I'd do it the other way, and augment the streaming API with a
method to allocate memory (either using kmalloc for small size or from
the CMA for large chunks).

This seems to be much less architecture dependent.

Would that be acceptable ?


All in all, the DMA_ATTR_NON_CONSISTENT flag seems to be used by only
2 drivers (and I couldn't really trace easily how they handle the
sync).


Cheers,

   Sylvain
