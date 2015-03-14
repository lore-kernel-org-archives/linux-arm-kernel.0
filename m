From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 14 Mar 2015 11:34:17 +0000
Subject: [GIT PULL] arm64 fixes for 4.0-rc4
Message-ID: <20150314113406.GA26776@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit 9eccca0843205f87c00404b663188b88eb248051:

  Linux 4.0-rc3 (2015-03-08 16:09:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 947bb7587fc2c1d1f6b89462ef1255ec30d4e682:

  arm64: put __boot_cpu_mode label after alignment instead of before (2015-03-14 11:02:26 +0000)

----------------------------------------------------------------
arm64 fixes:
- add TLB invalidation for page table tear-down which was missed when
  support for CONFIG_HAVE_RCU_TABLE_FREE was added (assuming page table
  freeing was always deferred)
- use UEFI for system and reset poweroff if available
- fix asm label placement in relation to the alignment statement

----------------------------------------------------------------
Ard Biesheuvel (2):
      efi/arm64: use UEFI for system reset and poweroff
      arm64: put __boot_cpu_mode label after alignment instead of before

Catalin Marinas (1):
      arm64: Invalidate the TLB corresponding to intermediate page table levels

 arch/arm64/include/asm/tlb.h      |  3 +++
 arch/arm64/include/asm/tlbflush.h | 13 +++++++++++++
 arch/arm64/kernel/efi.c           |  9 +++++++++
 arch/arm64/kernel/head.S          |  2 +-
 arch/arm64/kernel/process.c       |  8 ++++++++
 5 files changed, 34 insertions(+), 1 deletion(-)

-- 
Catalin
