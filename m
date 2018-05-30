From: mpatocka@redhat.com (Mikulas Patocka)
Date: Wed, 30 May 2018 13:00:19 -0400 (EDT)
Subject: arch_wb_cache_pmem on ARM64
Message-ID: <alpine.LRH.2.02.1805301254340.25056@file01.intranet.prod.int.rdu2.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

I'd like to ask what's the purpose of dmb(osh) in the function 
arch_wb_cache_pmem in arch/arm64/mm/flush.c?

void arch_wb_cache_pmem(void *addr, size_t size)
{
        /* Ensure order against any prior non-cacheable writes */
        dmb(osh);
        __clean_dcache_area_pop(addr, size);
}

The processor may flush the cache spontaneously, that means that all the 
flushing may actually happen before the dmb(osh) instruction - so what 
does that dmb instruction guard against?

Mikulas
