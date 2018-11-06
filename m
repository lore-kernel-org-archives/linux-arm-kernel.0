From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue,  6 Nov 2018 22:44:02 +0100
Subject: [PATCH v3 0/2]get rid of writable linear aliases of read-only vmalloc
 mappings
Message-ID: <20181106214404.2497-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a followup to my patch 'arm64/mm: unmap the linear alias of module
allocations'.

This version changes the approach to match what x86 does, i.e., to deal
with the linear alias at a more fundamental level, in the set_memory_ro/rw
routines.

Ard Biesheuvel (2):
  arm64: mm: purge lazily unmapped vm regions before changing
    permissions
  arm64: mm: apply r/o permissions of VM areas to its linear alias as
    well

 arch/arm64/Kconfig                   | 14 ++++++++
 arch/arm64/include/asm/mmu_context.h |  2 ++
 arch/arm64/mm/mmu.c                  |  2 +-
 arch/arm64/mm/pageattr.c             | 36 +++++++++++++++++---
 4 files changed, 48 insertions(+), 6 deletions(-)

-- 
2.19.1
