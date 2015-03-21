From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 21 Mar 2015 10:54:09 +0000
Subject: [GIT PULL] arm64 fixes for 4.0-rc5
Message-ID: <20150321105401.GA32696@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit 06e5801b8cb3fc057d88cb4dc03c0b64b2744cda:

  Linux 4.0-rc4 (2015-03-15 17:38:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 7132813c384515c9dede1ae20e56f3895feb7f1e:

  arm64: Honor __GFP_ZERO in dma allocations (2015-03-20 18:18:54 +0000)

----------------------------------------------------------------
arm64 fixes:
- mm switching fix where the kernel pgd ends up in the user TTBR0 after
  returning from an EFI run-time services call
- fix __GFP_ZERO handling for atomic pool and CMA DMA allocations (the
  generic code does get the gfp flags, so it's left with the arch code
  to memzero accordingly)

----------------------------------------------------------------
Suzuki K. Poulose (1):
      arm64: Honor __GFP_ZERO in dma allocations

Will Deacon (1):
      arm64: efi: don't restore TTBR0 if active_mm points at init_mm

 arch/arm64/include/asm/proc-fns.h |  6 +++++-
 arch/arm64/kernel/efi.c           |  6 +++++-
 arch/arm64/mm/dma-mapping.c       | 12 +++++++++---
 3 files changed, 19 insertions(+), 5 deletions(-)

-- 
Catalin
