From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 27 Feb 2015 18:44:16 +0000
Subject: [GIT PULL] arm64 fixes for 4.0
Message-ID: <20150227184403.GA4745@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to af4819af8db05da4753b3b74a11cb00b381247e7:

  arm64: cpuidle: add asm/proc-fns.h inclusion (2015-02-27 18:05:56 +0000)

----------------------------------------------------------------
Various arm64 fixes:
- ftrace branch generation fix
- branch instruction encoding fix
- include files, guards and unused prototypes clean-up
- minor VDSO ABI fix (clock_getres)
- PSCI functions moved to .S to avoid compilation error with gcc 5
- pte_modify fix to not ignore the mapping type
- crypto: AES interleaved increased to 4x (for performance reasons)
- text patching fix for modules
- swiotlb increased back to 64MB
- copy_siginfo_to_user32() fix for big endian

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64: crypto: increase AES interleave to 4x

Catalin Marinas (2):
      arm64: Increase the swiotlb buffer size 64MB
      arm64: compat Fix siginfo_t -> compat_siginfo_t conversion on big endian

Feng Kan (1):
      arm64: enable PTE type bit in the mask for pte_modify

Lorenzo Pieralisi (1):
      arm64: cpuidle: add asm/proc-fns.h inclusion

Marc Zyngier (2):
      arm64: guard asm/assembler.h against multiple inclusions
      arm64: Fix text patching logic when using fixmap

Nathan Lynch (1):
      arm64: vdso: minor ABI fix for clock_getres

Pratyush Anand (1):
      arm64: ftrace: fix ftrace_modify_graph_caller for branch replace

Robin Murphy (1):
      arm64: insn: fix compare-and-branch encodings

Will Deacon (1):
      arm64: psci: move psci firmware calls out of line

Yingjoe Chen (1):
      arm64: mm: remove unused functions and variable protoypes

 arch/arm64/crypto/Makefile            |  2 +-
 arch/arm64/include/asm/assembler.h    |  5 +++++
 arch/arm64/include/asm/cpuidle.h      |  2 ++
 arch/arm64/include/asm/insn.h         |  6 ++++--
 arch/arm64/include/asm/pgtable.h      |  2 +-
 arch/arm64/include/asm/processor.h    |  3 ++-
 arch/arm64/include/asm/tlbflush.h     |  5 -----
 arch/arm64/kernel/Makefile            |  5 +++--
 arch/arm64/kernel/ftrace.c            |  2 +-
 arch/arm64/kernel/insn.c              |  4 +++-
 arch/arm64/kernel/psci-call.S         | 28 ++++++++++++++++++++++++++
 arch/arm64/kernel/psci.c              | 37 +++--------------------------------
 arch/arm64/kernel/signal32.c          |  5 ++---
 arch/arm64/kernel/vdso/gettimeofday.S |  3 +--
 arch/arm64/mm/dma-mapping.c           | 16 +++------------
 arch/arm64/mm/init.c                  | 14 ++++++++-----
 16 files changed, 68 insertions(+), 71 deletions(-)
 create mode 100644 arch/arm64/kernel/psci-call.S

-- 
Catalin
