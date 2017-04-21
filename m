From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 22 Apr 2017 04:03:25 +0900
Subject: [RFC PATCH 0/2] kbuild: use relative path from $(srctree) instead of
 __FILE__
Message-ID: <1492801407-26823-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Kbuild works in objtree, not in srctree.  So, __FILE__ is prefixed
with $(srctree)/ for out-of-tree build.

It would be nice to see the same log regardless
in-tree, or out-of-tree build.

1/2 adds a new macro KBUILD_FILE.  This points the relative path
of the file we are building.  This is intended to replace __FILE__.

2/2 replaces __FILE__ in bug.h as an example.  This will improve
the output of WARN_ON() etc.



Masahiro Yamada (2):
  kbuild: add KBUILD_FILE to point relative file path from $(srctree)
  bug.h: replace __FILE__ with KBUILD_FILE for shorter names in log

 arch/alpha/include/asm/bug.h          | 2 +-
 arch/arc/include/asm/bug.h            | 2 +-
 arch/arm/include/asm/bug.h            | 4 ++--
 arch/arm64/include/asm/bug.h          | 2 +-
 arch/avr32/include/asm/bug.h          | 2 +-
 arch/blackfin/include/asm/bug.h       | 2 +-
 arch/cris/include/arch-v10/arch/bug.h | 6 +++---
 arch/cris/include/arch-v32/arch/bug.h | 2 +-
 arch/frv/include/asm/bug.h            | 2 +-
 arch/ia64/include/asm/bug.h           | 2 +-
 arch/m68k/include/asm/bug.h           | 4 ++--
 arch/mn10300/include/asm/bug.h        | 2 +-
 arch/parisc/include/asm/bug.h         | 4 ++--
 arch/powerpc/include/asm/bug.h        | 8 ++++----
 arch/s390/include/asm/bug.h           | 2 +-
 arch/score/include/asm/bug.h          | 4 ++--
 arch/sh/include/asm/bug.h             | 8 ++++----
 arch/sparc/include/asm/bug.h          | 2 +-
 arch/x86/include/asm/bug.h            | 2 +-
 include/asm-generic/bug.h             | 8 ++++----
 scripts/Kbuild.include                | 4 ++++
 scripts/Makefile.lib                  | 5 +++--
 22 files changed, 42 insertions(+), 37 deletions(-)

-- 
2.7.4
