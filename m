From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 10 Nov 2018 11:44:54 +0000
Subject: [GIT PULL] arm64 fixes for 4.20-rc2
Message-ID: <20181110114452.GA90619@arrakis.emea.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 24cc61d8cb5a9232fadf21a830061853c1268fdd:

  arm64: memblock: don't permit memblock resizing until linear mapping is up (2018-11-08 17:54:03 +0000)

----------------------------------------------------------------
arm64 fixes:

- Fix occasional page fault during boot due to memblock resizing before
  the linear map is up.

- Define NET_IP_ALIGN to 0 to improve the DMA performance on some
  platforms.

- lib/raid6 test build fix.

- .mailmap update for Punit Agrawal

----------------------------------------------------------------
Ard Biesheuvel (2):
      arm64: mm: define NET_IP_ALIGN to 0
      arm64: memblock: don't permit memblock resizing until linear mapping is up

Jeremy Linton (1):
      lib/raid6: Fix arm64 test build

Punit Agrawal (1):
      mailmap: Update email for Punit Agrawal

 .mailmap                           | 1 +
 arch/arm64/include/asm/processor.h | 8 ++++++++
 arch/arm64/mm/init.c               | 2 --
 arch/arm64/mm/mmu.c                | 2 ++
 lib/raid6/test/Makefile            | 4 ++--
 5 files changed, 13 insertions(+), 4 deletions(-)

-- 
Catalin
