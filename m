From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 11 Oct 2018 12:45:56 -0600
Subject: [PATCH 5/5] RISC-V: Implement sparsemem
In-Reply-To: <8cea5ffa-5fbf-8ea2-b673-20e2d09a910d@deltatee.com>
References: <20181005161642.2462-1-logang@deltatee.com>
 <20181005161642.2462-6-logang@deltatee.com> <20181011133730.GB7276@lst.de>
 <8cea5ffa-5fbf-8ea2-b673-20e2d09a910d@deltatee.com>
Message-ID: <83cfd2d7-b840-b0c6-594e-8b39be8177c1@deltatee.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2018-10-11 10:24 a.m., Logan Gunthorpe wrote:
> 
> 
> On 2018-10-11 7:37 a.m., Christoph Hellwig wrote:
>>> +/*
>>> + * Log2 of the upper bound of the size of a struct page. Used for sizing
>>> + * the vmemmap region only, does not affect actual memory footprint.
>>> + * We don't use sizeof(struct page) directly since taking its size here
>>> + * requires its definition to be available at this point in the inclusion
>>> + * chain, and it may not be a power of 2 in the first place.
>>> + */
>>> +#define STRUCT_PAGE_MAX_SHIFT	6
>>
>> I know this is copied from arm64, but wouldn't this be a good time
>> to move this next to the struct page defintion?

Ok, I spoke too soon...

Having this define next to the struct page definition works great for
riscv. However, making that happen in arm64 seems to be a nightmare. The
include chain in arm64 is tangled up so much that including mm_types
where this is needed seems to be extremely difficult.

Unless you have any ideas, this might not be possible.

Logan
