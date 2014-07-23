From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 23 Jul 2014 17:37:18 +0100
Subject: [GIT PULL] arm64 fix for 3.16
Message-ID: <20140723163713.GA31311@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 patch below. Thanks.


The following changes since commit fa2ec3ea10bd377f9d55772b1dab65178425a1a2:

  arm64: implement TASK_SIZE_OF (2014-07-08 17:30:59 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to d50314a6b0702c630c35b88148c1acb76d2e4ede:

  arm64: Create non-empty ZONE_DMA when DRAM starts above 4GB (2014-07-23 11:23:58 +0100)

----------------------------------------------------------------
Fix arm64 regression introduced by limiting the CMA buffer to ZONE_DMA
on platforms where RAM starts above 4GB (and ZONE_DMA becoming 0).

----------------------------------------------------------------
Catalin Marinas (1):
      arm64: Create non-empty ZONE_DMA when DRAM starts above 4GB

 arch/arm64/mm/init.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)
