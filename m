From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 20 Jul 2010 18:12:01 +0100
Subject: [PATCH 0/5] ARM: Cache maintenance changes
Message-ID: <20100720171201.19582.85920.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These patches have been posted on the linux-arm-kernel mailing list in
the past but I'm cc'ing linux-arch this time (following Fujita's
suggestion).

The main feature is the second patch - changing the meaning of PG_arch_1
from 'dirty' to 'clean' so that we do cache flushing even for PIO
drivers that do not call flush_dcache_page() (similarly to IA-64 and
PowerPC). There is some clean-up as well to avoid excessive flushing.

Catalin Marinas (5):
      ARM: Allow lazy cache flushing via PG_arch_1 for highmem pages
      ARM: Assume new page cache pages have dirty D-cache
      ARM: Introduce __sync_icache_dcache() for VIPT caches
      ARM: Use lazy cache flushing on ARMv7 SMP systems
      ARM: Remove superfluous flush_kernel_dcache_page()

-- 
Catalin
