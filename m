From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 11 Oct 2018 10:24:33 -0600
Subject: [PATCH 5/5] RISC-V: Implement sparsemem
In-Reply-To: <20181011133730.GB7276@lst.de>
References: <20181005161642.2462-1-logang@deltatee.com>
 <20181005161642.2462-6-logang@deltatee.com> <20181011133730.GB7276@lst.de>
Message-ID: <8cea5ffa-5fbf-8ea2-b673-20e2d09a910d@deltatee.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2018-10-11 7:37 a.m., Christoph Hellwig wrote:
>> +/*
>> + * Log2 of the upper bound of the size of a struct page. Used for sizing
>> + * the vmemmap region only, does not affect actual memory footprint.
>> + * We don't use sizeof(struct page) directly since taking its size here
>> + * requires its definition to be available at this point in the inclusion
>> + * chain, and it may not be a power of 2 in the first place.
>> + */
>> +#define STRUCT_PAGE_MAX_SHIFT	6
> 
> I know this is copied from arm64, but wouldn't this be a good time
> to move this next to the struct page defintion?
> 
> Also this:
> 
> arch/arm64/mm/init.c:   BUILD_BUG_ON(sizeof(struct page) > (1 << STRUCT_PAGE_MAX_SHIFT));
> 
> should move to comment code (or would have to be duplicated for riscv)

Makes sense. Where is a good place for the BUILD_BUG_ON in common code?

I've queued up changes for your other feedback.

Thanks,

Logan
