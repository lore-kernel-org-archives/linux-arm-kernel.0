From: will.deacon@arm.com (Will Deacon)
Date: Fri, 5 Aug 2016 16:48:47 +0100
Subject: [GIT PULL] arm64: fixes for -rc1
Message-ID: <20160805154847.GD13272@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull these arm64 fixes for -rc1. The branch is based on the
for-next/core tag you pulled from Catalin last week. He's on holiday
once again, so I'm handling the fixes until he's back.

Details in the tag.

Cheers,

Will

--->8

The following changes since commit fd6380b75065fd2ff51b5f7cbbe6be77d71ea9c7:

  arm64: arm: Fix-up the removal of the arm64 regs_query_register_name() prototype (2016-07-27 08:15:42 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 747a70e60b7234e8fd9c35dd2f2db10ac1db231d:

  arm64: Fix copy-on-write referencing in HugeTLB (2016-08-04 13:41:18 +0100)

----------------------------------------------------------------
arm64 fixes:

- Fix HugeTLB leak due to CoW and PTE_RDONLY mismatch
- Avoid accessing unmapped FDT fields when checking validity
- Correctly account for vDSO AUX entry in ARCH_DLINFO
- Fix kallsyms with absolute expressions in linker script
- Kill unnecessary symbol-based relocs in vmlinux

----------------------------------------------------------------
Ard Biesheuvel (3):
      arm64: vmlinux.lds: make __rela_offset and __dynsym_offset ABSOLUTE
      arm64: relocatable: suppress R_AARCH64_ABS64 relocations in vmlinux
      arm64: mm: avoid fdt_check_header() before the FDT is fully mapped

James Hogan (1):
      arm64: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO

Steve Capper (1):
      arm64: Fix copy-on-write referencing in HugeTLB

 arch/arm64/Makefile                  |  2 +-
 arch/arm64/include/asm/elf.h         |  1 +
 arch/arm64/include/asm/pgtable.h     | 17 +++++++++++++++++
 arch/arm64/include/uapi/asm/auxvec.h |  2 ++
 arch/arm64/kernel/head.S             | 21 +++------------------
 arch/arm64/kernel/vmlinux.lds.S      | 13 ++-----------
 arch/arm64/mm/mmu.c                  |  8 ++++----
 7 files changed, 30 insertions(+), 34 deletions(-)
