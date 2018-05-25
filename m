From: will.deacon@arm.com (Will Deacon)
Date: Fri, 25 May 2018 17:04:49 +0100
Subject: [GIT PULL] arm64: fixes for -rc7
Message-ID: <20180525160448.GF3255@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here are a few arm64 fixes for -rc7. The two main fixes are for the asm
constraints in our LSE atomics and for our pmd/pud setters when changing
permissions for kernel mappings. Summary in the tag.

Please pull,

Will

--->8

The following changes since commit 771c577c23bac90597c685971d7297ea00f99d11:

  Linux 4.17-rc6 (2018-05-20 15:31:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 82034c23fcbc2389c73d97737f61fa2dd6526413:

  arm64: Make sure permission updates happen for pmd/pud (2018-05-24 11:19:31 +0100)

----------------------------------------------------------------
More arm64 fixes:

- Fix application of read-only permissions to kernel section mappings

- Sanitise reported ESR values for signals delivered on a kernel address

- Ensure tishift GCC helpers are exported to modules

- Fix inline asm constraints for some LSE atomics

----------------------------------------------------------------
Jason A. Donenfeld (1):
      arm64: export tishift functions to modules

Laura Abbott (1):
      arm64: Make sure permission updates happen for pmd/pud

Peter Maydell (1):
      arm64: fault: Don't leak data in ESR context for user fault on kernel VA

Will Deacon (1):
      arm64: lse: Add early clobbers to some input/output asm operands

 arch/arm64/include/asm/atomic_lse.h | 24 ++++++++---------
 arch/arm64/kernel/arm64ksyms.c      |  8 ++++++
 arch/arm64/lib/tishift.S            | 15 ++---------
 arch/arm64/mm/fault.c               | 51 +++++++++++++++++++++++++++++++++++++
 arch/arm64/mm/mmu.c                 | 16 +++++++-----
 5 files changed, 83 insertions(+), 31 deletions(-)
