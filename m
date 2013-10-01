From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Tue, 1 Oct 2013 18:59:55 +0900
Subject: Why does unmap_area_sections() depend on !CONFIG_SMP?
Message-ID: <20131001095955.GA22859@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Russell.

I looked at ioremap code in arm tree and found that unmap_area_sections()
is enabled only if !CONFIG_SMP. I can't understand the comments
above this function and it comes from you. Could you elaborate more
on this?

I guess that flush_cache_vunmap() before clearing page table and
flush_tlb_kernel_range() after clearing page table is safe enough to cache
consistency regardless CONFIG_SMP configuration. I think that 4K vunmap()
also depends on this flushing logic.

Please let me know what I am missing here.

Thanks.
