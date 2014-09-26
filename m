From: keescook@chromium.org (Kees Cook)
Date: Fri, 26 Sep 2014 11:16:43 -0700
Subject: [PULL] ARM ro-nx tree (3.18)
Message-ID: <20140926181643.GA25494@www.outflux.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please pull this series for ro-nx support on ARM for 3.18.

Thanks!

-Kees

The following changes since commit cc31d8f887953e9824c4d9333b15c335ee7d1b65:

  Merge branches 'fiq' (early part), 'fixes' and 'misc' into for-next (2014-09-26 14:40:19 +0100)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/ronx-3.18

for you to fetch changes up to 9ad61652b33dba3a4630c1dad401a19b2508179b:

  ARM: mm: allow text and rodata sections to be read-only (2014-09-26 11:11:00 -0700)

----------------------------------------------------------------
ARM support for CONFIG_DEBUG_RODATA
generic fixmaps

----------------------------------------------------------------
Doug Anderson (1):
      arm: kgdb: Handle read-only text / modules

Kees Cook (3):
      arm: fixmap: implement __set_fixmap()
      ARM: mm: allow non-text sections to be non-executable
      ARM: mm: allow text and rodata sections to be read-only

Mark Salter (1):
      arm: use generic fixmap.h

Nikolay Borisov (1):
      ARM: kexec: Make .text R/W in machine_kexec

Rabin Vincent (1):
      arm: use fixmap for text patching when text is RO

Rob Herring (1):
      ARM: expand fixmap region to 3MB

 Documentation/arm/memory.txt      |   2 +-
 arch/arm/include/asm/cacheflush.h |  10 +++
 arch/arm/include/asm/fixmap.h     |  31 ++++----
 arch/arm/kernel/Makefile          |   2 +-
 arch/arm/kernel/ftrace.c          |  19 +++++
 arch/arm/kernel/jump_label.c      |   2 +-
 arch/arm/kernel/kgdb.c            |  29 ++++++++
 arch/arm/kernel/machine_kexec.c   |   9 ++-
 arch/arm/kernel/patch.c           |  92 ++++++++++++++++++-----
 arch/arm/kernel/patch.h           |  12 ++-
 arch/arm/kernel/vmlinux.lds.S     |  20 +++++
 arch/arm/mm/Kconfig               |  21 ++++++
 arch/arm/mm/highmem.c             |  15 ++--
 arch/arm/mm/init.c                | 149 +++++++++++++++++++++++++++++++++++++-
 arch/arm/mm/mmu.c                 |  39 +++++++++-
 15 files changed, 395 insertions(+), 57 deletions(-)

-- 
Kees Cook
Chrome OS Security
