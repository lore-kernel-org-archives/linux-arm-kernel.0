From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 22 Jun 2018 18:37:17 +0100
Subject: [GIT PULL] arm64 fixes for 4.18-rc2
Message-ID: <20180622173714.jtvicri5szn4dzb4@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 71c8fc0c96abf8e53e74ed4d891d671e585f9076:

  arm64: mm: Ensure writes to swapper are ordered wrt subsequent cache maintenance (2018-06-22 17:23:40 +0100)

----------------------------------------------------------------
arm64 fixes:

- Zero buffers allocated with FORCE_CONTIGUOUS explicitly until the CMA
  code honours __GFP_ZERO

- notrace annotation for secondary_start_kernel()

- Use early_param() instead of __setup() for "kpti=" as it is needed for
  the cpufeature callback remapping swapper to non-global mappings

- Ensure writes to swapper are ordered wrt subsequent cache maintenance
  in the kpti non-global remapping code

----------------------------------------------------------------
Marek Szyprowski (1):
      arm64: dma-mapping: clear buffers allocated with FORCE_CONTIGUOUS flag

Will Deacon (2):
      arm64: kpti: Use early_param for kpti= command-line option
      arm64: mm: Ensure writes to swapper are ordered wrt subsequent cache maintenance

Zhizhou Zhang (1):
      arm64: make secondary_start_kernel() notrace

 arch/arm64/kernel/cpufeature.c | 2 +-
 arch/arm64/kernel/smp.c        | 2 +-
 arch/arm64/mm/dma-mapping.c    | 9 +++++----
 arch/arm64/mm/proc.S           | 5 +++--
 4 files changed, 10 insertions(+), 8 deletions(-)

-- 
Catalin
