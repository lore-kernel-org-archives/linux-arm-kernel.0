From: kwangwoo.lee@sk.com (Kwangwoo Lee)
Date: Fri, 15 Jul 2016 11:46:19 +0900
Subject: [PATCH v3 0/3]  support pmem on arm64
Message-ID: <1468550782-14454-1-git-send-email-kwangwoo.lee@sk.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set add supporting the pmem driver on arm64 architecture which
can be used on NVDIMM(Non-Volatile DIMM). It has been tested on QEMU with
NVDIMM ACPI/NFIT support on AArch64 VIRT platform.

Until the changes of pmem codes posted to nvdimm list is merged which assums
supporting ADR(Asynchronous DRAM Refresh) or direct flushing based on the
flush hint provided by ACPI/NFIT, this pmem implementation on arm64 can be
a solution to evaluate pmem on arm64 architecture.

Change log:

v3)
do not use a access helper in arch_memcpy_to_pmem().
split cache related codes with different patch set.
fix some comments in pmem.h.

v2)
rewrite functions under the mapping information MEMREMAP_WB.
rewrite the comments for arm64 in pmem.h
add __clean_dcache_area() to clean the cache lines to the PoC.

v1)
add pmem support codes.

Kwangwoo Lee (3):
  arm64: mm: add __clean_dcache_area()
  arm64: mm: add mmio_flush_range() to support pmem
  arm64: pmem: add pmem support codes

 arch/arm64/Kconfig                  |   2 +
 arch/arm64/include/asm/cacheflush.h |   3 +
 arch/arm64/include/asm/pmem.h       | 143 ++++++++++++++++++++++++++++++++++++
 arch/arm64/mm/cache.S               |  18 +++++
 4 files changed, 166 insertions(+)
 create mode 100644 arch/arm64/include/asm/pmem.h

-- 
2.5.0
