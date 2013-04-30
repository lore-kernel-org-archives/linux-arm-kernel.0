From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 30 Apr 2013 16:16:16 +0800
Subject: [Question] flush_dcache_page() need to flush icache?
Message-ID: <CACVXFVMz3jLEPDYFM-_S_t5TiqikVSRiKf9cBNocH3QhVexwZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Looks flush_dcache_page() need to deal with both dcache alias and I/D
cache coherency, but set_pte_at() has already run __sync_icache_dcache()
to make I/D cache coherency in the path of executable page fault.

So could the flushing icache be removed in flush_dcache_page()?

If it is yes for the above question, could the flushing dcache in case of
vipt nonaliasing be removed in flush_dcache_page() too?

Maybe they are stupid questions, sorry in advance.

Thanks,
-- 
Ming Lei
