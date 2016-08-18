From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 18 Aug 2016 17:29:58 +0100
Subject: [GIT PULL] arm64 fixes for 4.8-rc3
Message-ID: <20160818162955.GA592@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below. Thank you.

The following changes since commit 694d0d0bb2030d2e36df73e2d23d5770511dbc8d:

  Linux 4.8-rc2 (2016-08-14 19:11:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to a93a4d62324123dcda383bdb4ab89151bbc0e499:

  arm64: Fix shift warning in arch/arm64/mm/dump.c (2016-08-18 12:38:11 +0100)

----------------------------------------------------------------
arm64 fixes:

- Avoid a literal load with the MMU off on the CPU resume path
  (potential inconsistency between cache and RAM)

- Build error with CONFIG_ACPI=n fixed

- Compiler warning in the arch/arm64/mm/dump.c code fixed

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64: kernel: avoid literal load of virtual address with MMU off

Catalin Marinas (2):
      arm64: Fix NUMA build error when !CONFIG_ACPI
      arm64: Fix shift warning in arch/arm64/mm/dump.c

 arch/arm64/kernel/sleep.S | 10 +++++++++-
 arch/arm64/mm/dump.c      |  6 +++---
 arch/arm64/mm/numa.c      |  2 ++
 3 files changed, 14 insertions(+), 4 deletions(-)

-- 
Catalin
