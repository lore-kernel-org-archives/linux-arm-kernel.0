From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 20 Jan 2017 13:52:52 +0000
Subject: [GIT PULL] arm64 fixes for 4.10-rc5
Message-ID: <20170120135249.GA19095@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below for 4.10. Thanks.

The following changes since commit 49def1853334396f948dcb4cedb9347abb318df5:

  Linux 4.10-rc4 (2017-01-15 16:21:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 7d9e8f71b989230bc613d121ca38507d34ada849:

  arm64: avoid returning from bad_mode (2017-01-19 15:38:22 +0000)

----------------------------------------------------------------
- Avoid potential stack information leak via the ptrace ABI caused by
  uninitialised variables

- SWIOTLB DMA API fall-back allocation fix when the SWIOTLB buffer is
  not initialised (all RAM is suitable for 32-bit DMA masks)

- Fix the bad_mode function returning for unhandled exceptions coming
  from user space

- Fix name clash in __page_to_voff()

----------------------------------------------------------------
Alexander Graf (1):
      arm64: Fix swiotlb fallback allocation

Dave Martin (5):
      arm64/ptrace: Preserve previous registers for short regset write
      arm64/ptrace: Preserve previous registers for short regset write
      arm64/ptrace: Preserve previous registers for short regset write
      arm64/ptrace: Avoid uninitialised struct padding in fpr_set()
      arm64/ptrace: Reject attempts to set incomplete hardware breakpoint fields

Mark Rutland (1):
      arm64: avoid returning from bad_mode

Oleksandr Andrushchenko (1):
      arm64: mm: avoid name clash in __page_to_voff()

 arch/arm64/include/asm/memory.h      |  2 +-
 arch/arm64/include/uapi/asm/ptrace.h |  1 +
 arch/arm64/kernel/entry.S            |  2 +-
 arch/arm64/kernel/ptrace.c           | 16 +++++++++++-----
 arch/arm64/kernel/traps.c            | 28 ++++++++++++++++++++++++----
 arch/arm64/mm/init.c                 |  2 ++
 6 files changed, 40 insertions(+), 11 deletions(-)

-- 
Catalin
