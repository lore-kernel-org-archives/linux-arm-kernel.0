From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 30 Apr 2013 10:05:02 +0100
Subject: [Question] flush_dcache_page() need to flush icache?
In-Reply-To: <CACVXFVMz3jLEPDYFM-_S_t5TiqikVSRiKf9cBNocH3QhVexwZg@mail.gmail.com>
References: <CACVXFVMz3jLEPDYFM-_S_t5TiqikVSRiKf9cBNocH3QhVexwZg@mail.gmail.com>
Message-ID: <20130430090502.GC29766@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 30, 2013 at 09:16:16AM +0100, Ming Lei wrote:
> Looks flush_dcache_page() need to deal with both dcache alias and I/D
> cache coherency, but set_pte_at() has already run __sync_icache_dcache()
> to make I/D cache coherency in the path of executable page fault.
> 
> So could the flushing icache be removed in flush_dcache_page()?

That's the case for (mapping && mapping_mapped(mapping)) where the
kernel modifies a page cache page which is already mapped in user space
and we won't get a subsequent set_pte_at() call.

-- 
Catalin
