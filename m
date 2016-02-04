From: will.deacon@arm.com (Will Deacon)
Date: Thu, 4 Feb 2016 18:49:22 +0000
Subject: [GIT PULL] arm64: fixes for -rc3
Message-ID: <20160204184922.GC21422@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull these arm64 fixes for -rc3. Nothing particularly interesting
here, but all important fixes nonetheless. Details in the tag.

Cheers,

Will

--->8

The following changes since commit 36f90b0a2ddd60823fe193a85e60ff1906c2a9b3:

  Linux 4.5-rc2 (2016-01-31 18:12:16 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 3e275c64a973ba1554ef87f76c9f0f5b5221ab14:

  arm64: asm: Explicitly include linux/personality.h in asm/page.h (2016-02-03 19:22:02 +0000)

----------------------------------------------------------------
arm64 fixes:

- Add missing PAN toggling in the futex code

- Fix missing #include that briefly caused issues in -next

- Allow changing of vmalloc permissions with set_memory_* (used by bpf)

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64: allow vmalloc regions to be set with set_memory_*

James Morse (1):
      arm64: futex.h: Add missing PAN toggling

Mark Brown (1):
      arm64: asm: Explicitly include linux/personality.h in asm/page.h

 arch/arm64/include/asm/futex.h |  2 ++
 arch/arm64/include/asm/page.h  |  1 +
 arch/arm64/mm/pageattr.c       | 23 +++++++++++++++++++----
 3 files changed, 22 insertions(+), 4 deletions(-)
