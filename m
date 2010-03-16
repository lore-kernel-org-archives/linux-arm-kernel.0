From: budheej@gmail.com (Budhee Jamaich)
Date: Wed, 17 Mar 2010 01:17:45 +0200
Subject: mapping uncached memory
Message-ID: <57314e841003161617l53dc3a50la969369f0161ccdd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hello,

we are looking for ways to map memory as uncached,
so remote devices reading/writing to this memory will see consistent data.


these are the alternatives we currently see:


1. clean cache after every write to the memory (/invalidate the cache
before every read)

this can be done using dmac_clean/inv_range and outer_clean/inv_range
just like in dma_cache_maint.
btw - what's the difference between the dmac_* and the outer_*
functions ? why both are needed ?

disadvantage: this will be needed to be called before/after every memory access





2. use pgprot_noncached when assigning vma->vm_page_prot in our
driver's mmap method


will that really work ? all memory accesses will be uncached ?








3. use dma_alloc_coherent in some way

cons: documentation says we still need to use cache clean/inv
operations, so this might not really be of any advantage. but if that
is so, what's the idea behind coherent pools of memory ? how does it
work at all ?




what do you say ?


thank you all very much in advance
budhee
