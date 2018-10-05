From: logang@deltatee.com (Logan Gunthorpe)
Date: Fri,  5 Oct 2018 10:16:37 -0600
Subject: [PATCH 0/5] sparsemem support for RISC-V
Message-ID: <20181005161642.2462-1-logang@deltatee.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Everyone,

This patchset is intended to implement sparsemem on RISC-V.
The first few patches are introducing a common helper used by the
sparesmem implementation in other architectures and the final
patch is the actual RISC-V implementation.

This is the first small step in supporting P2P on RISC-V.

Thanks,

Logan

--

Logan Gunthorpe (5):
  mm/sparse: add common helper to mark all memblocks present
  ARM: mm: make use of new memblocks_present() helper
  arm64: mm: make use of new memblocks_present() helper
  sh: mm: make use of new memblocks_present() helper
  RISC-V: Implement sparsemem

 arch/arm/mm/init.c                 | 17 +----------------
 arch/arm64/mm/init.c               | 20 +-------------------
 arch/riscv/Kconfig                 | 23 +++++++++++++++++++++++
 arch/riscv/include/asm/pgtable.h   | 24 ++++++++++++++++++++----
 arch/riscv/include/asm/sparsemem.h | 11 +++++++++++
 arch/riscv/kernel/setup.c          |  4 +++-
 arch/riscv/mm/init.c               |  8 ++++++++
 arch/sh/mm/init.c                  |  7 +------
 include/linux/mmzone.h             |  6 ++++++
 mm/sparse.c                        | 15 +++++++++++++++
 10 files changed, 89 insertions(+), 46 deletions(-)
 create mode 100644 arch/riscv/include/asm/sparsemem.h

--
2.19.0
