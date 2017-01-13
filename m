From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 13 Jan 2017 18:21:49 +0000
Subject: [GIT PULL] arm64 fixes for 4.10-rc4
Message-ID: <20170113182146.GA6825@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit a121103c922847ba5010819a3f250f1f7fc84ab8:

  Linux 4.10-rc3 (2017-01-08 14:18:17 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 41c066f2c4d436c535616fe182331766c57838f0:

  arm64: assembler: make adr_l work in modules under KASLR (2017-01-12 18:10:52 +0000)

----------------------------------------------------------------
- Fix huge_ptep_set_access_flags() to return "changed" when any of the
  ptes in the contiguous range is changed, not just the last one

- Fix the adr_l assembly macro to work in modules under KASLR

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64: assembler: make adr_l work in modules under KASLR

Huang Shijie (1):
      arm64: hugetlb: fix the wrong return value for huge_ptep_set_access_flags

 arch/arm64/include/asm/assembler.h | 36 +++++++++++++++++++++++++++---------
 arch/arm64/mm/hugetlbpage.c        |  2 +-
 2 files changed, 28 insertions(+), 10 deletions(-)

-- 
Catalin
