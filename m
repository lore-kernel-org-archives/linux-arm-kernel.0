From: will.deacon@arm.com (Will Deacon)
Date: Fri, 22 Jun 2018 09:31:14 +0100
Subject: [PATCH v2 0/4] I-side fixes
Message-ID: <1529656278-878-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here's version two of the patches I previously posted here:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/584857.html

Changes since v1 include:

  * Removal of "hotpatch" mechanism for certain classes of instructions
  * Avoid attempting IPI when secondaries are in stop_machine()
  * Leave ISBs intact in the stop_machine() callbacks

Cheers,

Will

--->8

Will Deacon (4):
  arm64: Avoid flush_icache_range() in alternatives patching code
  arm64: Remove unnecessary ISBs from set_{pte,pmd,pud}
  arm64: IPI each CPU after invalidating the I-cache for kernel mappings
  arm64: insn: Don't fallback on nosync path for general insn patching

 arch/arm64/include/asm/alternative.h |  7 +++-
 arch/arm64/include/asm/cacheflush.h  | 13 ++++++-
 arch/arm64/include/asm/insn.h        |  2 --
 arch/arm64/include/asm/pgtable.h     |  6 +---
 arch/arm64/kernel/alternative.c      | 51 ++++++++++++++++++++++----
 arch/arm64/kernel/cpu_errata.c       |  2 +-
 arch/arm64/kernel/insn.c             | 70 ++----------------------------------
 arch/arm64/kernel/module.c           |  5 ++-
 arch/arm64/mm/cache.S                |  4 +--
 9 files changed, 71 insertions(+), 89 deletions(-)

-- 
2.1.4
