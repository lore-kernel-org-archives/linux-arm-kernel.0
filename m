From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 14 Nov 2014 18:38:38 +0000
Subject: [GIT PULL] arm64 fixes for 3.18
Message-ID: <20141114183831.GA11574@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit 206c5f60a3d902bc4b56dab2de3e88de5eb06108:

  Linux 3.18-rc4 (2014-11-09 14:55:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 5fd6690c8fb2c3012012979dd8ce7492c69c5d86:

  arm64: ARCH_PFN_OFFSET should be unsigned long (2014-11-13 15:21:40 +0000)

----------------------------------------------------------------
arm64 fixes:

- Fix EFI stub cache maintenance causing aborts during boot on certain
  platforms
- Handle byte stores in __clear_user without panicking
- Fix race condition in aarch64_insn_patch_text_sync() (instruction
  patching)
- Couple of type fixes

----------------------------------------------------------------
Kyle McMartin (1):
      arm64: __clear_user: handle exceptions on strb

Mark Rutland (1):
      arm64: efi: Fix stub cache maintenance

Min-Hua Chen (1):
      arm64: Fix data type for physical address

Neil Zhang (1):
      arm64: ARCH_PFN_OFFSET should be unsigned long

William Cohen (1):
      Correct the race condition in aarch64_insn_patch_text_sync()

 arch/arm64/include/asm/memory.h |  2 +-
 arch/arm64/kernel/efi-entry.S   | 27 +++++++++++++++++++++------
 arch/arm64/kernel/insn.c        |  5 +++--
 arch/arm64/lib/clear_user.S     |  2 +-
 arch/arm64/mm/mmu.c             |  2 +-
 5 files changed, 27 insertions(+), 11 deletions(-)

-- 
Catalin
