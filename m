From: will.deacon@arm.com (Will Deacon)
Date: Fri, 4 Aug 2017 19:32:04 +0100
Subject: [GIT PULL] arm64: fixes for -rc4
Message-ID: <20170804183204.GB24125@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here are some more arm64 fixes for 4.13. The main one is the PTE race
with the hardware walker, but there are a couple of other things too.

Please pull,

Will

--->8

The following changes since commit 16f73eb02d7e1765ccab3d2018e0bd98eb93d973:

  Linux 4.13-rc3 (2017-07-30 12:40:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 82cd588052815eb4146f9f7c5347ca5e32c56360:

  arm64: avoid overflow in VA_START and PAGE_OFFSET (2017-08-04 15:06:35 +0100)

----------------------------------------------------------------
arm64 fixes:

- Report correct timer frequency to userspace when trapping CNTFRQ_EL0

- Fix race with hardware page table updates when updating access flags

- Silence clang overflow warning in VA_START and PAGE_OFFSET calculations

----------------------------------------------------------------
Catalin Marinas (1):
      arm64: Fix potential race with hardware DBM in ptep_set_access_flags()

Marc Zyngier (1):
      arm64: Use arch_timer_get_rate when trapping CNTFRQ_EL0

Nick Desaulniers (1):
      arm64: avoid overflow in VA_START and PAGE_OFFSET

 arch/arm64/include/asm/memory.h |  6 ++++--
 arch/arm64/kernel/traps.c       |  2 +-
 arch/arm64/mm/fault.c           | 15 ++++++++-------
 3 files changed, 13 insertions(+), 10 deletions(-)
